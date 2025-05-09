#if !NETSTANDARD1_4 || true
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.ServiceProcess;
using System.Threading;

namespace Universe.SqlServerJam
{
    public static class SqlServiceExtentions
    {

        public static SqlServiceStatus CheckLocalServiceStatus(string dataSource)
        {
            SqlServiceStatus ret = null;
            try
            {
                using (ServiceController service = new ServiceController(GetServiceName(dataSource)))
                {
                    var status = (SqlServiceStatus.ServiceStatus)(int)service.Status;
                    ret = new SqlServiceStatus(status);
                }
            }
            catch (Exception e)
            {
                ret = new SqlServiceStatus(e);
            }

            return ret;
        }

        public static bool IsLocalService(string dataSource)
        {
            var instanceWithoutProtocol = dataSource.Split(':').Last();
            var hostWithPort = instanceWithoutProtocol.Split('\\').First();
            var host = hostWithPort.Split(',').First();

            return
                host.Equals(".", StringComparisonExtensions.IgnoreCase)
                || host.Equals("(local)", StringComparisonExtensions.IgnoreCase)
                || host.Equals("::1", StringComparisonExtensions.IgnoreCase)
                || host.Equals("127.0.0.1", StringComparisonExtensions.IgnoreCase)
                || host.Equals(EnvironmentExtensions.MachineName, StringComparisonExtensions.IgnoreCase);

            // Before (rough)
            return dataSource.StartsWith("(local)", StringComparisonExtensions.IgnoreCase);
        }

        public static bool IsLocalDB(string sqlServerInstance)
        {
            var instance = sqlServerInstance.Split(':').Last();
            var host = instance.Split('\\').First();
            return
                host.Equals("(LocalDb)", StringComparisonExtensions.IgnoreCase);

            // Before (rough)
            // return dataSource.StartsWith("(localdb)", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsLocalDbOrLocalServer(string connectionString)
        {
            // var ds = new SqlConnectionStringBuilder(connectionString).DataSource;
            var ds = SqlServerJamConfigurationExtensions.GetDataSource(connectionString);
            var instance = ds.Split(':').Last();
            var host = instance.Split('\\').First();
            // Discovery always returns either (local) or (localdb) host only.
            return
                host.Equals(".", StringComparisonExtensions.IgnoreCase)
                || host.Equals("(local)", StringComparisonExtensions.IgnoreCase)
                || host.Equals("(LocalDb)", StringComparisonExtensions.IgnoreCase)
                || host.Equals("127.0.0.1", StringComparisonExtensions.IgnoreCase);
        }


        public static string GetServiceName(string sqlServer)
        {
            var invariant = StringComparisonExtensions.IgnoreCase;
            if ("(local)".Equals(sqlServer, StringComparison.Ordinal))
            {
                return "MSSQLServer";
            }

            const string prefix = "(local)\\";
            if (!sqlServer.StartsWith(prefix, invariant))
                throw new Exception("It is applicable for local sql servers");

            return "MSSQL$" + sqlServer.Substring(prefix.Length);
        }

        public static bool StartLocalDB(string localDb, TimeSpan timeout = default(TimeSpan))
        {
            if (timeout.Ticks == 0)
                timeout = TimeSpan.FromSeconds(30);

            if (!IsLocalDB(localDb)) return false;
            Stopwatch sw = Stopwatch.StartNew();
            while (true)
            {
                try
                {
                    string cs = String.Format("Data Source={0};Integrated Security=True;Pooling=false;Timeout=2", localDb);
                    using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(cs))
                    {
                        con.Manage().Ping(timeout: 2);
                        return true;
                    }
                }
                catch
                {
                    string instanceName = localDb.Split('\\').LastOrDefault() ?? "MSSQLLocalDB";
                    // try { StartLocalDB_Impl(instanceName, (int)timeout.TotalMilliseconds); } catch { }
                }

                Thread.Sleep(100);
                if (sw.Elapsed > timeout)
                    return false;
            }

        }

        // Incorrect
        static void StartLocalDB_Impl(string instanceName, int timeout)
        {
            string[] vers = new[] {"160", "150", "140", "130", "120"};
            string exePath = null;
            foreach (var ver in vers)
            {
                string candidate = Environment.ExpandEnvironmentVariables(
                    @"%ProgramFiles%\Microsoft SQL Server\" + ver + @"\Tools\Binn\SqlLocalDB.exe"
                );

                if (File.Exists(candidate))
                {
                    exePath = candidate;
                    break;
                }
            }

            ProcessStartInfo si = new ProcessStartInfo(exePath, "start " + instanceName);
            si.UseShellExecute = false;
#if !NETSTANDARD1_4
            si.WindowStyle = ProcessWindowStyle.Hidden;
#endif
            si.CreateNoWindow = true;
            using (Process p = Process.Start(si))
            {
                p.WaitForExit(Math.Min(Math.Max(1, timeout), 60000));
            }
        }

        public static LocalServiceStartup GetLocalServiceStartup(string dataSource)
        {
            if (!TinyCrossInfo.IsWindows) return LocalServiceStartup.Unknown;
            if (!IsLocalService(dataSource)) return LocalServiceStartup.Unknown;

            string serviceName = GetServiceName(dataSource);
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

        // Remove Warn Up
        public static bool StartService(string dataSource)
        {
            if (IsLocalDB(dataSource))
                return StartLocalDB(dataSource, TimeSpan.FromSeconds(30));

            if (!IsLocalService(dataSource)) return false;
            var serviceStatus = CheckLocalServiceStatus(dataSource);
            // ServiceController service = new ServiceController(GetServiceName(dataSource));
            // if (service.Status == ServiceControllerStatus.Running)
            if (serviceStatus?.State == SqlServiceStatus.ServiceStatus.Running)
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
        public ServiceStatus State { get; set; }
        public Exception StatusError { get; set; }
        public string AsString { get; set; }

        public SqlServiceStatus()
        {
            State = ServiceStatus.Unknown;
            StatusError = null;
            AsString = State.ToString();
        }

        public SqlServiceStatus(Exception ex)
        {
            StatusError = ex;
            State = ServiceStatus.Unknown;
            AsString = ex.GetLegacyExceptionDigest();
        }

        public SqlServiceStatus(ServiceStatus state)
        {
            State = state;
            AsString = State.ToString().Replace("_", " ");
        }

        public override string ToString()
        {
            return AsString;
        }

        public enum ServiceStatus
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