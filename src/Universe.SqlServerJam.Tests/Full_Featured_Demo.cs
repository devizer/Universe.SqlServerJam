using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class Full_Featured_Demo
    {
        const int TRANSPORT_PROBE_DURATION = 1000;

        Stopwatch _StartAt = Stopwatch.StartNew();

        [OneTimeSetUp]
        public void OneTimeSetUp()
        {
            NUnit3Logs.Bind();
        }


        // The root feature is SQL Discovery.
        // We will cache sql server list.
        // During Exam test we will populate sql server version
        private Lazy<List<SqlServerRef>> _SqlServers = new Lazy<List<SqlServerRef>>(() =>
        {
            return SqlDiscovery.GetLocalDbAndServerList();
        });


        private List<SqlServerRef> SqlServers => _SqlServers.Value;


        [Test]
        public void _1_Find_Local_Servers()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Debug.WriteLine($"Found {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");
        }

        [Test]
        public void _2_Start_Local_Services()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Debug.WriteLine($"Check services status {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");
            Debug.WriteLine("");

            IEnumerable<SqlServerRef> ordered = list.OrderByVersionDesc().ToList();
            List<SqlServerRef> stopped = new List<SqlServerRef>();
            var localOrdered = ordered.Where(x => SqlServiceExtentions.IsLocalService(x.DataSource)).ToList();
            if (localOrdered.Any())
            {
                Debug.WriteLine("State of corresponding services");
                foreach (var sqlRef in localOrdered)
                {
                    var serviceStatus = SqlServiceExtentions.CheckServiceStatus(sqlRef.DataSource);
                    if (serviceStatus.State != SqlServiceStatus.ServiceStatus.Running)
                        stopped.Add(sqlRef);

                    Debug.WriteLine(" {0} ({1}): {2}", sqlRef.DataSource, sqlRef.Version, serviceStatus);
                }
            }


            // LocalDB is awsays assumed to be stopped.
            var localDB = ordered.FirstOrDefault(x => SqlServiceExtentions.IsLocalDB(x.DataSource));
            if (localDB != null)
                stopped.Add(localDB);

            if (stopped.Any())
            {
                Debug.WriteLine("");
                Debug.WriteLine("Start stopped sql services");
                {
                    foreach (var sqlRef in stopped)
                    {
                        Stopwatch sw = Stopwatch.StartNew();
                        bool ok = SqlServiceExtentions.StartService(sqlRef.DataSource, TimeSpan.FromSeconds(30));
                        string action = SqlServiceExtentions.IsLocalDB(sqlRef.DataSource) ? "Checking" : "Starting";
                        Debug.WriteLine(" {3} {0}: {1} ({2:0.00} secs)",
                            sqlRef.DataSource, ok ? "OK" : "Fail", sw.ElapsedMilliseconds / 1000d, action);
                    }
                }
            }
        }



        [Test]
        public void _3_Exam_Servers()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Debug.WriteLine($"Exam {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");
            Debug.WriteLine("");

            int alive = 0, sysadmin = 0;
            Stopwatch startAt = Stopwatch.StartNew();
            StringBuilder timingReport = new StringBuilder();
            ConcurrentBag<string> errorServers = new ConcurrentBag<string>();
            ParallelOptions opts = new ParallelOptions() {MaxDegreeOfParallelism = Math.Max(list.Count,1)};
            Parallel.For(0, list.Count, opts, (i) =>
            {
                var sqlRef = list[i];
                if (Debugger.IsAttached && sqlRef.DataSource.IndexOf("Ubuntu-16.04-LTS", StringComparison.InvariantCultureIgnoreCase) >= 0) Debugger.Break();
                string cs = sqlRef.ConnectionString;
                string v = sqlRef.Version == null ? "N/A" : sqlRef.Version.ToString();
                StringBuilder report = new StringBuilder();
                report.AppendLine($"SERVER {sqlRef}");
                try
                {
                    using (SqlConnection con = new SqlConnection(cs))
                    {
                        var man = con.Manage();
                        var ver = man.ShortServerVersion;
                        if (sqlRef.Version == null) sqlRef.Version = ver;
                        alive++;
                        report.AppendLine("Version (32-bit) .........: " + ver);
                        report.AppendLine("Version (string) .........: " + man.ProductVersion);
                        report.AppendLine("Product Level ............: " + man.ProductLevel);
                        report.AppendLine("Update Level .............: " + man.ProductUpdateLevel);
                        report.AppendLine("Edition ..................: " + man.ServerEdition);
                        report.AppendLine("Engine Edition ...........: " + man.EngineEdition);
                        report.AppendLine("Host Platform ............: " + man.HostPlatform);
                        report.AppendLine("Security Mode ............: " + man.SecurityMode);
                        report.AppendLine("Is LocalDB ...............: " + man.IsLocalDB);
                        var transport = man.NetTransport;
                        transport += ", " + (man.IsConnectionEncrypted ? "Encrypted" : "Without Encryption");
                        report.AppendLine("Transport ................: " + transport);
                        report.AppendLine("Server Collation .........: " + man.ServerCollation);
                        var roles = man.FixedServerRoles;
                        var isSysAdmin = (roles & FixedServerRoles.SysAdmin) != 0;
                        var rolesString = isSysAdmin ? "Sys Admin" : roles.ToString();
                        report.AppendLine("Built-in Roles ...........: " + rolesString);
                        var dbList = man.DatabaseSizes;
                        report.AppendLine("Databases ................: " + dbList.Count + " ("+ dbList.Sum(x => x.Value) + " Kb)");
                        if (isSysAdmin) sysadmin++;
                        var paths = man.DefaultPaths;
                        report.AppendLine("Default Data .............: " + paths.DefaultData);
                        report.AppendLine("Default Log ..............: " + paths.DefaultLog);
                        report.AppendLine("Default Backup ...........: " + paths.DefaultBackup);

                        // DB Options demo
                        var currentDatabase = man.CurrentDatabaseName;
                        var dbOptions = man.Databases[currentDatabase];
                        report.Append("Connected DB Info ........: [" + currentDatabase + "]" + Environment.NewLine);
                        dbOptions.WriteDigest(report, intent: 1);

                        report.AppendLine("Long Version .............: " + man.LongServerVersion);


                        if (man.IsAzure && Debugger.IsAttached) Debugger.Break();
                        if (!man.IsAzure)
                        {
                            var prevRecovery = dbOptions.RecoveryMode;
                            DatabaseRecoveryMode newRecovery =
                                prevRecovery == DatabaseRecoveryMode.Bulk_Logged
                                    ? DatabaseRecoveryMode.Simple
                                    : DatabaseRecoveryMode.Bulk_Logged;

                            dbOptions.RecoveryMode = newRecovery;
                            dbOptions.RecoveryMode = prevRecovery;
                        }

                        man.IsFullTextSearchInstalled.ToString();
                    }
                }
                catch (Exception ex)
                {
                    report.AppendLine("Exception ................: " + ex.GetExeptionDigest());
                    errorServers.Add(sqlRef.DataSource);
                }

                lock (timingReport)
                    timingReport
                        .AppendFormat($" {sqlRef} examined in {(startAt.ElapsedMilliseconds / 1000m):0.00} secs")
                        .AppendLine();

                Debug.WriteLine(report);

            });

            Debug.WriteLine($"Done:{Environment.NewLine}{timingReport}");
            Debug.WriteLine($"Alive Servers: {alive}. SysAdmins Permissions: {sysadmin}.");
            if (errorServers.Count > 0)
                Debug.WriteLine(string.Format(
                    "Warning! Some sql servers have fails. See details above: {0}{1}",
                    Environment.NewLine,
                    string.Join(Environment.NewLine, errorServers.OrderBy(x => x).Select(x => " * " + x))
                    ));
        }

        [Test]
        public void _4_Meashure_Ping()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Debug.WriteLine($"Ping {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");

            Debug.WriteLine("");
            Debug.WriteLine("Ping Report (milliseconds)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in list)
            {
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMillisecs: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(supportedProtocol.ConnectionString);
                        decimal msec = test.GetPing(limitCount: 100000, milliSecondsLimit: TestEnvironment.SqlPingDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Debug.WriteLine($"{(msec.ToString("f2")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetExeptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Debug.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        [Test]
        public void _5_Meashure_Upload_Speed()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Console.WriteLine(list.AsBullets());
            Debug.WriteLine($"Upload speed test of {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");

            Debug.WriteLine("");
            Debug.WriteLine("Upload speed Report (KBytes per second)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in list)
            {
                var blockSize = SqlServiceExtentions.IsLocalDbOrLocalServer(sqlRef.ConnectionString) ? 1024 : 1024;
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMillisecs: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        // force packet size
                        var builder = new SqlConnectionStringBuilder(supportedProtocol.ConnectionString);
                        builder.PacketSize = 32768;
                        var connectionString = builder.ConnectionString;
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(connectionString);
                        decimal kbPerSec = test.GetUploadSpeed(limitIterations: 100000, blockSizeInKb: blockSize, limitMilliSeconds: TestEnvironment.SqlUploadDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Debug.WriteLine($"{(kbPerSec.ToString("f1")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetExeptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Debug.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        [Test]
        public void _6_Meashure_Download_Speed()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Debug.WriteLine($"Download speed test of {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");

            Debug.WriteLine("");
            Debug.WriteLine("Download speed Report (KB per second)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in list)
            {
                var blockSize = SqlServiceExtentions.IsLocalDbOrLocalServer(sqlRef.ConnectionString) ? 4096 : 1024;
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMillisecs: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(supportedProtocol.ConnectionString);
                        decimal kbPerSec = test.GetDownloadSpeed(limitIterations: 100000, blockSizeInKb: blockSize, limitMilliSeconds: TestEnvironment.SqlDownloadDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Debug.WriteLine($"{(kbPerSec.ToString("f1")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetExeptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Debug.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        static string GetTransportInfo(string connectionString)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                var transport = con.Manage().NetTransport;
                transport += ", " + (con.Manage().IsConnectionEncrypted ? "Encrypted" : "Without Encryption");
                var hostPlatform = con.Manage().HostPlatform;
                if (hostPlatform != "Windows") transport += ", " + hostPlatform;
                return transport;
            }
        }

        [SetUp]
        public void SetUp()
        {
            _StartAt = Stopwatch.StartNew();
        }

        [TearDown]
        public void TearDown()
        {
            Debug.WriteLine("");
            var secs = new DateTime(0L).AddSeconds(_StartAt.Elapsed.TotalSeconds).ToString("mm:ss.ff") + " secs";
            var mem = (Process.GetCurrentProcess().WorkingSet64 / 1024 / 1024).ToString("0") + " Mb";
            var pad = '-';
            var nl = Environment.NewLine;
            secs = $"> {secs} <".PadRight(12, pad);
            mem = $"> {mem} <".PadLeft(12, pad);
            Debug.WriteLine(nl + $"x--------{secs}--------{mem}--------x" + nl);
        }

    }
}