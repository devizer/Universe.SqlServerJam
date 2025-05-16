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
    // TODO: Rename to DataSourceStructuredExtensions
    public static class SqlServiceExtentions
    {
        public static SqlServiceStatus CheckLocalServiceStatus(string dataSource)
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


        public static string GetServiceName(string dataSource)
        {
            var structured = DataSourceStructured.ParseDataSource(dataSource);
            if (structured?.IsLocalService != true)
                throw new Exception("GetServiceName() is applicable for local sql servers");

            return structured.ServiceName;
        }

        public static bool StartLocalDB(string dataSource, TimeSpan timeout = default(TimeSpan))
        {
            if (timeout.Ticks == 0)
                timeout = TimeSpan.FromSeconds(30);

            var structured = DataSourceStructured.ParseDataSource(dataSource);
            if (structured?.IsLocalDb != true) return false;

            Stopwatch sw = Stopwatch.StartNew();
            while (true)
            {
                try
                {
                    string cs = String.Format(SqlServerJamDiscoveryConfiguration.LocalDbConnectionStringFormat, dataSource);
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
                    string instanceName = dataSource.Split('\\').LastOrDefault() ?? "MSSQLLocalDB";
                    // try { StartLocalDB_Impl(instanceName, (int)timeout.TotalMilliseconds); } catch { }
                }

                Thread.Sleep(10);
                if (sw.Elapsed > timeout)
                    return false;
            }

        }

        [Obsolete("Deprecated. Will be removed", false)]
        public static IEnumerable<string> FindSqlLocalDbExes()
        {
            string[] vers = new[] { "170", "160", "150", "140", "130", "120" };
            foreach (var ver in vers)
            {
                string candidate = Environment.ExpandEnvironmentVariables(
                    @"%ProgramFiles%\Microsoft SQL Server\" + ver + @"\Tools\Binn\SqlLocalDB.exe"
                );

                if (File.Exists(candidate))
                {
                    yield return candidate;
                }
            }
        }

        public static LocalServiceStartup GetLocalServiceStartup(string dataSource)
        {
            if (!TinyCrossInfo.IsWindows) return LocalServiceStartup.Unknown;

            var structured = DataSourceStructured.ParseDataSource(dataSource);
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
        public static bool StartServiceOrLocalDb(string dataSource, int timeout = 30)
        {
            if (!TinyCrossInfo.IsWindows) return false;
            var structured = DataSourceStructured.ParseDataSource(dataSource);
            if (structured == null) return false;
            if (structured.IsLocalDb)
                return StartLocalDB(dataSource, TimeSpan.FromSeconds(timeout));

            // if (!IsLocalService(dataSource)) return false;
            if (!structured.IsLocalService) return false;

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
        public static bool StopServiceOrLocalDb(string dataSource, int stopTimeout)
        {
            if (!TinyCrossInfo.IsWindows) return false;
            DataSourceStructured structured = DataSourceStructured.ParseDataSource(dataSource);
            if (structured == null) return false;

            if (structured.IsLocalDb)
            {
                string instanceName = structured.LocalDbInstance;
                var sqlLocalDbExe = FindSqlLocalDbExes().FirstOrDefault();
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
            else if (structured.IsLocalService)
            {
                var serviceName = structured.ServiceName;

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

    // Only Local Service or LocalDB
    // TODO: Rename to SqlDataSource
    public class DataSourceStructured
    {
        public bool IsLocalService { get; set; }
        public bool IsLocalDb { get; set; }

        public bool IsLocal => IsLocalDb || IsLocalService;

        // Not Null if IsLocalService
        public string ServiceName { get; set; }

        public string LocalDbInstance { get; set; }

        public override string ToString()
        {
            if (IsLocalDb)
                return $"LocalDb '{LocalDbInstance}'";

            if (IsLocalService)
                return $" Local Service '{ServiceName}'";

            return "Non-local or null service, e.g. neither SQL Server nor LocalDB";
        }

        public static DataSourceStructured ParseConnectionString(string connectionString)
        {
            var dataSource = SqlServerJamConfigurationExtensions.GetDataSource(connectionString);
            return ParseDataSource(dataSource);
        }

        public static DataSourceStructured ParseDataSource(string dataSource)
        {
            var arrWithProtocol = dataSource.Split(':');
            var instanceWithoutProtocol = arrWithProtocol.Last();
            var protocol = arrWithProtocol.Length >= 2 ? arrWithProtocol[0] : null; // null | lpc | tcp | np
            var hostWithPort = instanceWithoutProtocol.Split('\\').First();
            var host = hostWithPort.Split(',').First();

            // TODO: if Port or Protocol tcp or named pipe then NOT a LocalDB
            bool isLocalService =
                host.Equals("(local)", StringComparisonExtensions.IgnoreCase)
                || host.Equals(".", StringComparisonExtensions.IgnoreCase)
                || host.Equals("::1", StringComparisonExtensions.IgnoreCase)
                || host.Equals("127.0.0.1", StringComparisonExtensions.IgnoreCase)
                || host.Equals(EnvironmentExtensions.MachineName, StringComparisonExtensions.IgnoreCase);

            string instanceName =
                dataSource.IndexOf("\\", StringComparison.Ordinal) < 0
                    ? null
                    : dataSource.Split('\\').LastOrDefault();

            if (isLocalService)
            {
                var serviceName = instanceName == null ? "MSSQLSERVER" : $"MSSQL${instanceName}";
                return new DataSourceStructured()
                {
                    IsLocalService = true,
                    IsLocalDb = false,
                    ServiceName = serviceName
                };
            }

            bool isLocalDb = 
                host.StartsWith("(LocalDB)", StringComparisonExtensions.IgnoreCase)
                && dataSource.StartsWith("(LocalDB)\\", StringComparisonExtensions.IgnoreCase);


            if (isLocalDb)
            {
                // tcp is not a 
                bool isProperProtocol =
                    protocol == null
                    || "lpc".Equals(protocol, StringComparison.OrdinalIgnoreCase)
                    || "np".Equals(protocol, StringComparison.OrdinalIgnoreCase);

                // instanceName is Mandatory
                if (instanceName != null && isProperProtocol)
                {
                    return new DataSourceStructured()
                    {
                        IsLocalDb = true,
                        IsLocalService = false,
                        ServiceName = null,
                        LocalDbInstance = instanceName ?? "MSSQLLocalDB"
                    };
                }
            }

            return null;
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