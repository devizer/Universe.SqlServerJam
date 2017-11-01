using System;
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
        public static SqlServiceStatus CheckServiceStatus(string sqlServer)
        {
            SqlServiceStatus ret = null;
            try
            {
                ServiceController service = new ServiceController(GetServiceName(sqlServer));
                var status = (SqlServiceStatus.ServiceStatus) (int) service.Status;
                ret = new SqlServiceStatus(status);
            }
            catch (Exception e)
            {
                ret = new SqlServiceStatus(e);
            }

            return ret;
        }

        public static bool IsLocalService(string sqlServerInstance)
        {
            var instance = sqlServerInstance.Split(':').Last();
            var host = instance.Split('\\').First();
            return
                host.Equals(".", StringComparison.InvariantCultureIgnoreCase)
                || host.Equals("(local)", StringComparison.InvariantCultureIgnoreCase)
                || host.Equals("127.0.0.1", StringComparison.InvariantCultureIgnoreCase);

            // Before (rough)
            return sqlServerInstance.StartsWith("(local)", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsLocalDB(string sqlServerInstance)
        {
            var instance = sqlServerInstance.Split(':').Last();
            var host = instance.Split('\\').First();
            return
                host.Equals("(LocalDb)", StringComparison.InvariantCultureIgnoreCase);

            // Before (rough)
            // return sqlServerInstance.StartsWith("(localdb)", StringComparison.InvariantCultureIgnoreCase);
        }

        public static bool IsLocalDbOrLocalServer(string connectionString)
        {
            var ds = new SqlConnectionStringBuilder(connectionString).DataSource;
            var instance = ds.Split(':').Last();
            var host = instance.Split('\\').First();
            // Discovery always returns either (local) or (localdb) host only.
            return
                host.Equals(".", StringComparison.InvariantCultureIgnoreCase)
                || host.Equals("(local)", StringComparison.InvariantCultureIgnoreCase)
                || host.Equals("(LocalDb)", StringComparison.InvariantCultureIgnoreCase)
                || host.Equals("127.0.0.1", StringComparison.InvariantCultureIgnoreCase);
        }


        public static string GetServiceName(string sqlServer)
        {
            var invariant = StringComparison.InvariantCultureIgnoreCase;
            var c = StringComparer.InvariantCultureIgnoreCase;
            if (c.Equals("(local)", sqlServer))
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
            string instanceName = localDb.Split('\\').LastOrDefault() ?? "MSSQLLocalDB";
            Stopwatch sw = Stopwatch.StartNew();
            while (true)
            {
                try
                {
                    string cs = String.Format("Data Source={0};Integrated Security=True;Pooling=false;Timeout=1", localDb);
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlExtentions.GetServerShortVersion(con);
                        return true;
                    }
                }
                catch
                {
                    // try { StartLocalDB_Impl(instanceName, (int)timeout.TotalMilliseconds); } catch { }
                }

                Thread.Sleep(100);
                if (sw.Elapsed > timeout)
                    return false;
            }

        }

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
            si.WindowStyle = ProcessWindowStyle.Hidden;
            using (Process p = Process.Start(si))
            {
                p.WaitForExit(Math.Min(Math.Max(1, timeout), 60000));
            }
        }

        public static bool StartService(string sqlServer, TimeSpan timeout = default(TimeSpan))
        {
            if (IsLocalDB(sqlServer))
                return StartLocalDB(sqlServer, timeout);

            ServiceController service = new ServiceController(GetServiceName(sqlServer));
            if (service.Status == ServiceControllerStatus.Running)
                return true;


            if (timeout.Ticks == 0)
                timeout = TimeSpan.FromSeconds(30);

            Stopwatch sw = Stopwatch.StartNew();
            while (true)
            {
                try
                {
                    try { service.Start();} catch { }
                    string cs = String.Format("Data Source={0};Integrated Security=True;Pooling=false;Timeout=2", sqlServer);
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        SqlExtentions.GetServerShortVersion(con);
                        return true;
                    }
                }
                catch
                {
                }

                Thread.Sleep(100);
                if (sw.Elapsed > timeout)
                    return false;
            }

        }
    }

    public class SqlServiceStatus
    {
        public ServiceStatus State { get; set; }
        public Exception Ex { get; set; }
        public string AsString { get; set; }

        public SqlServiceStatus()
        {
            State = ServiceStatus.Unknown;
            Ex = null;
            AsString = State.ToString();
        }

        public SqlServiceStatus(Exception ex)
        {
            Ex = ex;
            State = ServiceStatus.Unknown;
            AsString = ex.GetExeptionDigest();
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