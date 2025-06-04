using NUnit.Framework;
using System.Data.SqlClient;
using System.Data;
using System;
using Dapper;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class DemoTests1 : NUnitTestsBase
    {

        [Test]
        [TestCaseSource(nameof(GetEnabledServers))]
        public void TestResetDefaultFillFactor(SqlServerRef testCase)
        {
            if (!testCase.IsNotAzure()) return;

            IDbConnection cnn = testCase.CreateConnection(pooling: false, timeout: 30);

            // TEST RESTART for fill factor
            // IDbConnection cnn = new SqlConnection(testCase.ConnectionString);
            int targetFillFactor = 73;
            if (cnn.Manage().Configuration.FillFactor != targetFillFactor && testCase.CanStartStopService)
            {
                cnn.Manage().Configuration.FillFactor = targetFillFactor;
                Console.WriteLine($"RESTARTING {testCase} for configuration");
                Stopwatch sw = Stopwatch.StartNew();
                testCase.RestartLocalService(stopTimeout: 30, startTimeout: 30);
                Console.WriteLine($"RESTARTED {testCase} {sw.ElapsedMilliseconds:n0} milliseconds");
                Assert.That(cnn.Manage().Configuration.FillFactor, Is.EqualTo(targetFillFactor), () => "FillFactor does not match");
            }
            Console.WriteLine($"FillFactor: {cnn.Manage().Configuration.FillFactor}");

        }



        [Test]
        [TestCaseSource(nameof(GetEnabledServers))]
        public void Demo1(SqlServerRef testCase)
        {
            if (!testCase.IsNotAzure()) return;

            IDbConnection cnn = testCase.CreateConnection(pooling: false, timeout: 30);

            string newDbName = $"Test DB {Guid.NewGuid():N}";
            cnn = testCase.CreateConnection(pooling: true, timeout: 30);
            cnn.Manage().Configuration.MinServerMemory = 4000; // 4Gb
            Assert.That(cnn.Manage().Configuration.MinServerMemory, Is.EqualTo(4000));
            cnn.Manage().Configuration.MaxServerMemory = 64000; // 64Gb

            if (!testCase.CanSimplyCreateDatabase()) return;

            try
            {
                cnn.Execute($"Create Database [{newDbName}]");
                cnn.Manage().Databases[newDbName].RecoveryMode = DatabaseRecoveryMode.Full;
                cnn.Manage().Databases[newDbName].RecoveryMode = DatabaseRecoveryMode.BulkLogged;
                cnn.Manage().Databases[newDbName].RecoveryMode = DatabaseRecoveryMode.Simple;
                cnn.Manage().Databases[newDbName].IsAutoShrink = true;
                cnn.Manage().Databases[newDbName].IsAutoShrink = false;
                cnn.Manage().Databases[newDbName].PageVerify = DatabasePageVerify.None;
                cnn.Manage().Databases[newDbName].AutoCreateStatistic = AutoCreateStatisticMode.Complete;
                cnn.Manage().Databases[newDbName].AutoCreateStatistic = AutoCreateStatisticMode.Incremental;
                cnn.Manage().Databases[newDbName].AutoCreateStatistic = AutoCreateStatisticMode.Off;
                cnn.Manage().Databases[newDbName].AutoUpdateStatistic = AutoUpdateStatisticMode.Synchronously;
                cnn.Manage().Databases[newDbName].AutoUpdateStatistic = AutoUpdateStatisticMode.Async;
                cnn.Manage().Databases[newDbName].AutoUpdateStatistic = AutoUpdateStatisticMode.Off;
                Console.WriteLine($"Success: {cnn.Manage().MediumServerVersion}");
            }
            finally
            {
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            }

            Assert.That(cnn.Manage().IsDbExists(newDbName), Is.False);
        }

        static IEnumerable<SqlServerRef> GetEnabledServers()
        {
            return SqlDiscovery.GetLocalDbAndServerList()
                .Where(server => server.ServiceStartup != LocalServiceStartup.Disabled)
                .StartLocalIfStopped()
                .WarmUp(timeout: TimeSpan.FromSeconds(30))
                // .Where(server => server.Version != null)
                // .Where(server => server.Manage().EngineEdition == EngineEdition.Enterprise) // Developer|Enterprise
                // .Where(server => server.Manage().ShortServerVersion.Major >= 15) // 2019 or above
                .OrderByVersionDesc()
                .ToList();
        }



    }
}