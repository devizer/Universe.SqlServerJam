#if !NETSTANDARD1_4 || true
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.ServiceProcess;
using System.Threading;

namespace Universe.SqlServerJam
{
    public static class SqlServerDataSourceExtensions
    {

        // It does not warm it up
        public static void RestartServiceOrLocalDb(this SqlServerDataSource dataSource, int stopTimeout = 30, int startTimeout = 30)
        {
            if (!TinyCrossInfo.IsWindows) return;
            if (!dataSource.IsLocal) return;

            // Console.WriteLine($"[DEBUG] DO Restart {dataSource}");
            Stopwatch stopAt = Stopwatch.StartNew();
            // if (sqlServerRef.Kind == SqlServerDiscoverySource.LocalDB)
            if (dataSource.IsLocalDb)
            {
                bool isStoppedDetails = dataSource.StopServiceOrLocalDb(stopTimeout);
                // Stop takes 5 sec usually
                Thread.Sleep(10);
            }
            else if (dataSource.IsLocalService)
            {
                SqlServiceStatus serviceStatus = dataSource.CheckLocalServiceStatus();
                var isStoppedAtStart = serviceStatus?.State == SqlServiceStatus.ServiceState.Stopped;
                if (!isStoppedAtStart)
                {
                    bool isStoppedDetails = dataSource.StopServiceOrLocalDb(stopTimeout);
                    do
                    {
                        var isStopped = SqlServiceStatus.ServiceState.Stopped == dataSource.CheckLocalServiceStatus()?.State;
                        if (isStopped) break;
                    } while (stopAt.ElapsedMilliseconds < stopTimeout * 1000);
                }
            }

            dataSource.StartServiceOrLocalDb(timeout: startTimeout);

            /*
            THIS WILL NOT populate Version of original SqlServerRef 
            SqlServerRef sqlServerRef = new SqlServerRef()
            {
                Kind = dataSource.IsLocalDb ? SqlServerDiscoverySource.LocalDB : dataSource.IsLocalService ? SqlServerDiscoverySource.Local : SqlServerDiscoverySource.WellKnown,
                Version = null,
                InstallerVersion = null,
                ServiceStartup = LocalServiceStartup.Unknown,
                Data = dataSource.Original
            };
            sqlServerRef.WarmUp(timeout: TimeSpan.FromSeconds(startTimeout));
            */
        }


        public static SqlServiceStatus CheckLocalServiceStatus(this SqlServerDataSource dataSource)
        {
            // TODO: Do not return fail on Linux/MacOS
            if (!TinyCrossInfo.IsWindows) 
                return new SqlServiceStatus(new InvalidOperationException("CheckLocalServiceStatus() is supported on Windows only"));

            SqlServiceStatus ret = null;
            try
            {
                using (ServiceController service = new ServiceController(GetServiceName(dataSource)))
                {
                    var state = (SqlServiceStatus.ServiceState)(int)service.Status;
                    ret = new SqlServiceStatus(state);
                }
            }
            catch (Exception e)
            {
                ret = new SqlServiceStatus(e);
            }

            return ret;
        }


        public static string GetServiceName(this SqlServerDataSource dataSource)
        {
            if (dataSource?.IsLocalService != true)
                throw new Exception("GetServiceName() is applicable for local sql servers");

            return dataSource.ServiceName;
        }

        public static bool StartLocalDB(this SqlServerDataSource dataSource, TimeSpan timeout = default(TimeSpan))
        {
            if (timeout.Ticks == 0)
                timeout = TimeSpan.FromSeconds(30);

            if (dataSource?.IsLocalDb != true) return false;

            Stopwatch sw = Stopwatch.StartNew();
            while (true)
            {
                try
                {
                    string cs = String.Format(SqlServerJamDiscoveryConfiguration.LocalDbConnectionStringFormat, dataSource.Original);
                    cs = SqlServerJamConfigurationExtensions.ResetConnectionPooling(cs, false);
                    cs = SqlServerJamConfigurationExtensions.ResetConnectionTimeout(cs, 2);
                    using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(cs))
                    {
                        con.Manage().Ping(timeout: 2);
                        return true;
                    }
                }
                catch
                {
                    string instanceName = dataSource.LocalDbInstance;
                    // try { StartLocalDB_Impl(instanceName, (int)timeout.TotalMilliseconds); } catch { }
                }

                Thread.Sleep(10);
                if (sw.Elapsed > timeout)
                    return false;
            }
        }


        public static LocalServiceStartup GetLocalServiceStartup(this SqlServerDataSource dataSource)
        {
            if (!TinyCrossInfo.IsWindows) return LocalServiceStartup.Unknown;

            var structured = dataSource;
            if (structured?.IsLocalService != true) return LocalServiceStartup.Unknown;

            string serviceName = structured.ServiceName;
            string registryPath = $@"SYSTEM\CurrentControlSet\Services\{serviceName}";

            try
            {
                using (RegistryKey key = Registry.LocalMachine.OpenSubKey(registryPath, false))
                {
                    if (key != null)
                    {
                        int start = Convert.ToInt32(key.GetValue("Start", -1));
                        int delayedAutoStart = Convert.ToInt32(key.GetValue("DelayedAutoStart", 0));

                        if (start == 2 && delayedAutoStart == 1)
                            return LocalServiceStartup.AutomaticDelayed;
                        else if (start == 2)
                            return LocalServiceStartup.Automatic;
                        else if (start == 3)
                            return LocalServiceStartup.Manual;
                        else if (start == 4)
                            return LocalServiceStartup.Disabled;
                    }
                }
            }
            catch
            {
            }

            return LocalServiceStartup.Unknown;
        }

        // Returns true if service is running
        public static bool StartServiceOrLocalDb(this SqlServerDataSource dataSource, int timeout = 30)
        {
            if (!TinyCrossInfo.IsWindows) return false;
            if (dataSource == null) return false;
            if (dataSource.IsLocalDb)
                return StartLocalDB(dataSource, TimeSpan.FromSeconds(timeout));

            // if (!IsLocalService(dataSource)) return false;
            if (!dataSource.IsLocalService) return false;

            var serviceStatus = CheckLocalServiceStatus(dataSource);
            // ServiceController service = new ServiceController(GetServiceName(dataSource));
            // if (service.Status == ServiceControllerStatus.Running)
            if (serviceStatus?.State == SqlServiceStatus.ServiceState.Running)
                return true;

            var startup = GetLocalServiceStartup(dataSource);
            if (startup == LocalServiceStartup.Disabled) return false;

            try
            {
                var serviceName = GetServiceName(dataSource);
                // Console.WriteLine($"[DEBUG] Starting Service {serviceName}");
                ServiceController service = new ServiceController(serviceName);
                // service.Status

                service.Start();
                return true;
            }
            catch (Exception ex)
            {
            }

            return false;
        }

        
        // Return true if action taken
        public static bool StopServiceOrLocalDb(this SqlServerDataSource dataSource, int stopTimeout)
        {
            if (!TinyCrossInfo.IsWindows) return false;
            if (dataSource == null) return false;

            if (dataSource.IsLocalDb)
            {
                string instanceName = dataSource.LocalDbInstance;
                var sqlLocalDbExe = SqlLocalDbDiscovery.FindSqlLocalDbExes().FirstOrDefault();
                if (sqlLocalDbExe != null)
                {
                    try
                    {
                        SqlLocalDbDiscovery.TinyHiddenExec(sqlLocalDbExe, $"stop \"{instanceName}\"", stopTimeout);
                    }
                    catch (Exception ex)
                    {
                        Trace.WriteLine($"Stop failed for LocalDB instance [{instanceName}] using '{sqlLocalDbExe}'{Environment.NewLine}{ex}");
                    }
                }
            }
            else if (dataSource.IsLocalService)
            {
                var serviceName = dataSource.ServiceName;

                var serviceStatus = CheckLocalServiceStatus(dataSource);
                if (serviceStatus?.State == SqlServiceStatus.ServiceState.Stopped) return false;

                var startup = GetLocalServiceStartup(dataSource);
                if (startup == LocalServiceStartup.Disabled) return false;

                try
                {
                    ServiceController service = new ServiceController(serviceName);
                    service.Stop();
                    return true;
                }
                catch (Exception ex)
                {
                    // LOG fail
                    return false;
                }
            }

            return false;
        }
    }

    public enum LocalServiceStartup
    {
        Unknown,
        AutomaticDelayed = 22,
        Automatic = 2,
        Manual = 3,
        Disabled = 4
    }

    public class SqlServiceStatus
    {
        public ServiceState State { get; set; }
        public Exception StatusError { get; set; }
        public string AsString { get; set; }

        public SqlServiceStatus()
        {
            State = ServiceState.Unknown;
            StatusError = null;
            AsString = State.ToString();
        }

        public SqlServiceStatus(Exception ex)
        {
            StatusError = ex;
            State = ServiceState.Unknown;
            AsString = ex.GetLegacyExceptionDigest();
        }

        public SqlServiceStatus(ServiceState state)
        {
            State = state;
            AsString = State.ToString().Replace("_", " ");
        }

        public override string ToString()
        {
            return AsString;
        }

        public enum ServiceState
        {
            Unknown = 0,
            Stopped = 1,
            Start_Pending = 2,
            Stop_Pending = 3,
            Running = 4,
            Continue_Pending = 5,
            Pause_Pending = 6,
            Paused = 7,
        }

    }
}
#endif