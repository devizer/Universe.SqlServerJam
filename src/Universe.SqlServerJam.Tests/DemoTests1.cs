using NUnit.Framework;
using System.Data.SqlClient;
using System.Data;
using System;
using Dapper;
using System.Collections.Generic;
using System.Linq;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class DemoTests1
    {

        [Test]
        [TestCaseSource(nameof(GetEnabledServers))]
        public void Demo1(SqlServerRef testCase)
        {
            string newDbName = $"Test DB {Guid.NewGuid():N}";
            IDbConnection cnn = new SqlConnection(testCase.ConnectionString);
            cnn.Manage().Configuration.MinServerMemory = 4000; // 4Gb
            cnn.Manage().Configuration.MaxServerMemory = 64000; // 64Gb
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