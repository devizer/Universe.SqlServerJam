using System;
using System.Data.SqlClient;
using Dapper;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestSqlStatisticsMode : NUnitTestsBase
    {
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void TestUpdateStatisticOptions(SqlServerRef testCase)
        {
            if (!testCase.CanSimplyCreateDatabase()) return;
            if (!testCase.IsNotAzure()) return;

            string newDbName = $"Test of Update Statistics {Guid.NewGuid():N}";
            var conMaster = testCase.CreateConnection();
            conMaster.Execute($"Create Database [{newDbName}]");
            var dbMan = conMaster.Manage().Databases[newDbName];

            try
            {
                var updateStatisticsOptions = new[]
                {
                    AutoUpdateStatisticMode.Off,
                    AutoUpdateStatisticMode.Async, 
                    AutoUpdateStatisticMode.Synchronously, 
                    AutoUpdateStatisticMode.Off, 
                    AutoUpdateStatisticMode.Synchronously, 
                    AutoUpdateStatisticMode.Async, 
                    AutoUpdateStatisticMode.Off, 
                };

                foreach (var updateStatisticMode in updateStatisticsOptions)
                {
                    Console.WriteLine($"UPDATING AutoUpdateStatistic = [{updateStatisticMode}]");
                    dbMan.AutoUpdateStatistic = updateStatisticMode;
                    AutoUpdateStatisticMode actual = dbMan.AutoUpdateStatistic;
                    AutoUpdateStatisticMode expected = updateStatisticMode;
                    Console.WriteLine($"UPDATED AutoUpdateStatistic = '{actual}'");
                    Assert.That(actual, Is.EqualTo(expected));
                    Console.WriteLine("");
                }
            }
            finally
            {
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            }

            Assert.That(testCase.Manage().IsDbExists(newDbName), Is.False);
        }


        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void TestCreateStatisticOptions(SqlServerRef testCase)
        {
            if (!testCase.CanSimplyCreateDatabase()) return;
            if (!testCase.IsNotAzure()) return;

            var conMaster = testCase.CreateConnection();
            string newDbName = $"Test of Create Statistics {Guid.NewGuid().ToString()}";
            conMaster.Execute($"Create Database [{newDbName}]");
            var dbMan = conMaster.Manage().Databases[newDbName];


            try
            {
                var createStatisticsOptions = new[]
                {
                    AutoCreateStatisticMode.Off,
                    AutoCreateStatisticMode.Incremental, 
                    AutoCreateStatisticMode.Complete, 
                    AutoCreateStatisticMode.Incremental, 
                    AutoCreateStatisticMode.Off, 
                    AutoCreateStatisticMode.Complete, 
                    AutoCreateStatisticMode.Off, 
                };

                foreach (var createStatisticMode in createStatisticsOptions)
                {
                    Console.WriteLine($"UPDATING AutoCreateStatistic = [{createStatisticMode}]");
                    dbMan.AutoCreateStatistic = createStatisticMode;
                    AutoCreateStatisticMode actual = dbMan.AutoCreateStatistic;
                    AutoCreateStatisticMode expected =
                        !dbMan.IsIncrementalAutoStatisticCreationSupported && createStatisticMode == AutoCreateStatisticMode.Incremental
                            ? AutoCreateStatisticMode.Complete
                            : createStatisticMode;

                    Console.WriteLine($"UPDATED AutoCreateStatistic = '{actual}'");


                    Assert.That(actual, Is.EqualTo(expected));
                    Console.WriteLine("");
                }
            }
            finally
            {
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            }

            Assert.That(testCase.Manage().IsDbExists(newDbName), Is.False);
        }
    }
}