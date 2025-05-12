using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Linq.Expressions;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class Full_Featured_Demo : NUnitTestsBase
    {
        const int TRANSPORT_PROBE_DURATION = 1000;

        Stopwatch _StartAt = Stopwatch.StartNew();


        private List<SqlServerRef> SqlServers => TestEnvironment.SqlServers;

        [Test]
        public void Test_Debug()
        {
            // if (Debugger.IsAttached) Debugger.Break();
        }

        [Test]
        public void _1_Find_Local_Servers()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Console.WriteLine($"Found {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");
        }

        [Test/*, Ignore("Test Only Sql@Linux")*/]
        public void _2_Start_Local_Services()
        {
            var list = SqlServers.OrderByVersionDesc().ToList();
            Console.WriteLine($"Check services status {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}{Environment.NewLine}");
            Stopwatch startAt = Stopwatch.StartNew();
            Parallel.ForEach(list, sql =>
            {
                bool isStarted = sql.StartLocalIfStopped();
                if (isStarted) Console.WriteLine($"{startAt.Elapsed.TotalSeconds,7:n2} Service Started: {sql}");

                var version = sql.WarmUp(TimeSpan.FromSeconds(30));
                bool isOk = version != null;
                Console.WriteLine($"{startAt.Elapsed.TotalSeconds,7:n2} {(isOk ? "Completed" : "In-completed")} start and warmup: {sql}");
            });
        }

        [Test]
        public void _7_Exam_Backup_Meta()
        {
            if (CrossInfo.ThePlatform != CrossInfo.Platform.Windows) return;
            var list = SqlServers.OrderByVersionDesc().Where(x => x.IsNotDisabled).ToList();
            foreach (var sqlRef in list)
            {
                string cs = sqlRef.ConnectionString;
                string v = sqlRef.InstallerVersion == null ? "N/A" : sqlRef.InstallerVersion.ToString();
                StringBuilder report = new StringBuilder();
                report.AppendLine();
                using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(cs))
                {
                    SqlBackupDescription backupDescr = con.Manage().GetBackupDescription(TestEnvironment.DbForTestsBak);
                    Console.WriteLine($"SERVER {sqlRef}{Environment.NewLine}{backupDescr}{Environment.NewLine}");
                }


            }

        }



        [Test]
        public void _3_Exam_Servers()
        {
            var listAll = SqlServers.OrderByVersionDesc().Where(x => x.IsNotDisabled).ToList();
            Console.WriteLine($"Exam {listAll.Count} sql servers:{Environment.NewLine}{listAll.AsBullets()}");
            var list = listAll.Where(x => x.IsNotDisabled).ToList();

            Console.WriteLine("");

            int alive = 0, sysadmin = 0;
            Stopwatch startAt = Stopwatch.StartNew();
            StringBuilder timingReport = new StringBuilder();
            ConcurrentBag<string> errorServers = new ConcurrentBag<string>();
            ParallelOptions opts = new ParallelOptions() {MaxDegreeOfParallelism = Math.Max(list.Count,2)};
            int completeCount = 0;
            Parallel.For(0, list.Count, opts, (i) =>
            {
                var sqlRef = list[i];
                // if (Debugger.IsAttached && sqlRef.DataSource.IndexOf("Ubuntu-16.04-LTS", StringComparison.InvariantCultureIgnoreCase) >= 0) Debugger.Break();
                string cs = sqlRef.ConnectionString;
                string v = sqlRef.InstallerVersion == null ? "N/A" : sqlRef.InstallerVersion.ToString();
                StringBuilder report = new StringBuilder();
                report.AppendLine($"«{{SERVER_INDEX}} of {list.Count}» SERVER {sqlRef}");

                using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(cs))
                {
                    // TryAndForget(() => con.Manage().ShortServerVersion?.ToString());
                    var warmUpError = WarmUp(cs, timeoutSeconds: 100);
                    if (warmUpError != null) Console.WriteLine($"WARNING! Warm up error {warmUpError.GetLegacyExceptionDigest()}{Environment.NewLine}{warmUpError}");
                    var man = con.Manage();
                    var ver = man.ShortServerVersion;
                    if (sqlRef.Version == null) sqlRef.Version = ver;
                    // alive++;
                    Interlocked.Increment(ref alive);
                    report.AppendLine("Version (4 bytes) ........: " + ver);
                    report.AppendLine("ProductVersion (string) ..: " + man.ProductVersion);
                    report.AppendLine("Product Level ............: " + man.ProductLevel);
                    report.AppendLine("Update Level .............: " + man.ProductUpdateLevel);
                    report.AppendLine("Edition Name .............: " + man.EngineEditionName);
                    report.AppendLine("Engine Edition ...........: " + man.EngineEdition);
                    report.AppendLine("Medium Version ...........: " + man.MediumServerVersion);
                    report.AppendLine("Long Version .............: " + man.LongServerVersion);

                    // report.AppendLine("Min Server Memory ........: " + man.ServerConfigurationSettings.MinServerMemory);
                    // report.AppendLine("Max Server Memory ........: " + man.ServerConfigurationSettings.MaxServerMemory);
                    // report.AppendLine("XpCmdShell ...............: " + man.ServerConfigurationSettings.XpCmdShell);
                    // report.AppendLine("BackupCompressionDefault .: " + man.ServerConfigurationSettings.BackupCompressionDefault);

                    report.AppendLine("Host Platform ............: " + man.HostPlatform);
                    report.AppendLine("Security Mode ............: " + man.SecurityMode);
                    report.AppendLine("Is LocalDB ...............: " + man.IsLocalDB);
                    report.AppendLine("Has Full Text Search .....: " + man.IsFullTextSearchInstalled);
                    report.AppendLine("Can Mem Optimized ........: " + man.IsMemoryOptimizedTableSupported);

                    var transport = man.NetTransport;
                    transport += ", " + (man.IsConnectionEncrypted ? "Encrypted" : "Without Encryption");
                    report.AppendLine("Transport ................: " + transport);
                    report.AppendLine("Server Collation .........: " + man.ServerCollation);

                    try
                    {

                        var roles = man.FixedServerRoles;
                        var isSysAdmin = (roles & FixedServerRoles.SysAdmin) != 0;
                        var rolesString = isSysAdmin ? "Sys Admin" : roles.ToString();
                        report.AppendLine("Built-in Roles ...........: " + rolesString);
                        var dbList = man.DatabaseSizes;
                        report.AppendLine("Databases ................: " + dbList.Count + " (" + dbList.Sum(x => x.Value) + " Kb)");
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

                        // Expression<Func<ServerConfigurationSettingsManager, object>>[] serverOptions = new Expression<Func<ServerConfigurationSettingsManager, object>>[]
                        Expression<Func<ServerConfigurationSettingsManager, object>>[] serverOptions = new Expression<Func<ServerConfigurationSettingsManager, object>>[]
                        {
                            x => x.BackupCompressionDefault,
                            x => x.MinServerMemory,
                            x => x.MaxServerMemory,
                            x => x.ShowAdvancedOption,
                            x => x.XpCmdShell,
                            x => x.ClrEnabled,
                            x => x.FileStreamAccessLevel,
                            x => x.ServerTriggerRecursion,
                        };

                        report.AppendLine("Server Configuration Settings [sp_configure]:");
                        foreach (var serverOption in serverOptions)
                        {
                            string title = ExpressionExtensions.GetTitle1(serverOption) + " ";
                            title = title.PadRight(52, '.');
                            object value = serverOption.Compile().Invoke(man.ServerConfigurationSettings);
                            if (value is int) value = string.Format("{0:n0}", value);
                            report.AppendLine($"   * {title}: " + value);
                        }


                        // if (man.IsAzure && Debugger.IsAttached) Debugger.Break();
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
                    catch (Exception ex)
                    {
                        report.AppendLine("Exception ................: " + ex.GetLegacyExceptionDigest());
                        errorServers.Add(sqlRef.DataSource);
                    }

                    Assert.That(man.ShortServerVersion, Is.Not.Null, "ShortServerVersion is null");
                    // Assert.IsNotNull(man.ShortServerVersion, "@@MICROSOFTVERSION");
                    Assert.That(man.ShortServerVersion.Major, Is.GreaterThanOrEqualTo(8), "Major ShortServerVersion is below 9");
                    // Assert.GreaterOrEqual(man.ShortServerVersion.Major, 8);
                    Assert.That(man.LongServerVersion, Is.Not.Null.And.Not.Empty, "LongServerVersion is null or empty");
                    // Assert.IsTrue(!string.IsNullOrEmpty(man.LongServerVersion), "@@VERSION");

                    Assert.That(man.CurrentSPID, Is.Not.Zero, "@@SPID is incorrect");
                    // Assert.IsTrue(man.CurrentSPID != 0, "@@SPID");
                    // TODO: Add more asserts
                }



                lock (timingReport)
                    timingReport
                        .AppendFormat($" {sqlRef} examined in {(startAt.ElapsedMilliseconds / 1000m):0.00} secs")
                        .AppendLine();


                var completeIndex = Interlocked.Increment(ref completeCount);
                var reportString = report.ToString().Replace("{SERVER_INDEX}", completeIndex.ToString("0"));
                Console.WriteLine(reportString);

            });

            Console.WriteLine($"Done:{Environment.NewLine}{timingReport}");
            Console.WriteLine($"Alive Servers: {alive}. SysAdmins Permissions: {sysadmin}.");
            if (errorServers.Count > 0)
                Console.WriteLine(string.Format(
                    "Warning! Some sql servers have fails. See details above: {0}{1}",
                    Environment.NewLine,
                    JoinToString(Environment.NewLine, errorServers.OrderBy(x => x).Select(x => " * " + x))
                    ));
        }

        static Exception WarmUp(string connectionString, int timeoutSeconds)
        {
            // var csb = new SqlConnectionStringBuilder(connectionString);
            var csb = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            csb.ConnectionString = connectionString;
            // csb.ConnectTimeout = 2;
            csb["Connect Timeout"] = 2;
            var cs = csb.ConnectionString;
            Stopwatch sw = Stopwatch.StartNew();
            Exception ret = null;
            do
            {
                try
                {
                    // using (SqlConnection con = new SqlConnection(connectionString))
                    using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(connectionString)) 
                    {
                        con.Open();
                        con.Manage().LongServerVersion?.ToString();
                        return null;
                    }
                }
                catch (Exception ex)
                {
                    ret = ex;
                }

            } while (sw.Elapsed.TotalSeconds <= timeoutSeconds);

            ret = new InvalidOperationException(
                $"Unable to warm up Sql Server or Local DB during {sw.Elapsed.TotalSeconds:n1} seconds [{connectionString}] ",
                ret);

            return ret;
        }
        private void TryAndForget(Action func)
        {
            try
            {
                func();
            }
            catch
            {
            }
        }

        [Test]
        public void _4_Meashure_Ping()
        {
            var list = SqlServers.OrderByVersionDesc().Where(x => x.IsNotDisabled).ToList();
            Console.WriteLine($"Ping {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");

            Console.WriteLine("");
            Console.WriteLine("Ping Report (milliseconds)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in list)
            {
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMilliseconds: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(supportedProtocol.ConnectionString);
                        decimal msec = test.GetPing(limitCount: 100000, milliSecondsLimit: TestEnvironment.SqlPingDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Console.WriteLine($"{(msec.ToString("f2")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetLegacyExceptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Console.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        [Test]
        public void _5_Meashure_Upload_Speed()
        {
            var list = SqlServers.OrderByVersionDesc().Where(x => x.IsNotDisabled).ToList();
            Console.WriteLine(list.AsBullets());
            Console.WriteLine($"Upload speed test of {list.Count} sql servers:{Environment.NewLine}{list.AsBullets()}");

            Console.WriteLine("");
            Console.WriteLine("Upload speed Report (KBytes per second)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in list)
            {
                var blockSize = SqlServiceExtentions.IsLocalDbOrLocalServer(sqlRef.ConnectionString) ? 1024 : 1024;
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMilliseconds: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        // force packet size
                        // var builder = new SqlConnectionStringBuilder(supportedProtocol.ConnectionString);
                        var builder = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
                        builder.ConnectionString = supportedProtocol.ConnectionString;
                        // builder.PacketSize = 32768;
                        builder["Packet Size"] = 32768;
                        builder["Pooling"] = true;
                        var connectionString = builder.ConnectionString;
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(connectionString);
                        decimal kbPerSec = test.GetUploadSpeed(limitIterations: 100000, blockSizeInKb: blockSize, limitMilliSeconds: TestEnvironment.SqlUploadDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Console.WriteLine($"{(kbPerSec.ToString("f1")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetLegacyExceptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Console.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        [Test]
        public void _6_Meashure_Download_Speed()
        {
            var listAll = SqlServers.OrderByVersionDesc().ToList();
            Console.WriteLine($"Download speed test of {listAll.Count} sql servers:{Environment.NewLine}{listAll.AsBullets()}");
            var list = listAll.Where(x => x.IsNotDisabled).ToList();

            Console.WriteLine("");
            Console.WriteLine("Download speed Report (KB per second)");
            StringBuilder errors = new StringBuilder();
            foreach (var sqlRef in listAll)
            {
                var blockSize = SqlServiceExtentions.IsLocalDbOrLocalServer(sqlRef.ConnectionString) ? 4096 : 1024;
                var supportedProtocols = sqlRef.ProbeTransports(timeoutMilliseconds: TRANSPORT_PROBE_DURATION);
                foreach (var supportedProtocol in supportedProtocols)
                {
                    try
                    {
                        var builder = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
                        builder.ConnectionString = supportedProtocol.ConnectionString;
                        // builder.PacketSize = 32768;
                        builder["Packet Size"] = 32768;
                        builder["Pooling"] = true;
                        var connectionString = builder.ConnectionString;
                        SqlSpeedMeasurement test = new SqlSpeedMeasurement(connectionString);
                        decimal kbPerSec = test.GetDownloadSpeed(limitIterations: 100000, blockSizeInKb: blockSize, limitMilliSeconds: TestEnvironment.SqlDownloadDuration);
                        var transport = GetTransportInfo(supportedProtocol.ConnectionString);
                        Console.WriteLine($"{(kbPerSec.ToString("f1")).PadLeft(9)} : {sqlRef.DataSource} ({transport})");
                    }
                    catch (Exception ex)
                    {
                        errors.AppendFormat("{0} {1}", supportedProtocol.DataSource, ex.GetLegacyExceptionDigest()).AppendLine();
                    }
                }
            }

            if (errors.Length > 0)
                Console.WriteLine(Environment.NewLine + "SpeedTest failed" + Environment.NewLine + errors);

        }

        static string GetTransportInfo(string connectionString)
        {
            // using (SqlConnection con = new SqlConnection(connectionString))
            using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(connectionString))
            {
                var transport = con.Manage().NetTransport;
                transport += ", " + (con.Manage().IsConnectionEncrypted ? "Encrypted" : "Without Encryption");
                var hostPlatform = con.Manage().HostPlatform;
                if (hostPlatform != "Windows") transport += ", " + hostPlatform;
                return transport;
            }
        }

        [Test]
        public void Z_Log()
        {
            Console.WriteLine(SqlLocalDbDiscovery.Log);
        }



    }
}