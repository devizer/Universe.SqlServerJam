using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using Dapper;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestResilientDbKiller : NUnitTestsBase
    {
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void KillNewDB(SqlServerRef testCase)
        {
            SqlJamLog.EnableDebugLog = true;
            if (!testCase.CanSimplyCreateDatabase()) return;
            // if (!testCase.IsNotAzure()) return;


            var enumerable =
                testCase.Manage(timeout: 90).IsAzure
                    ? new List<bool?>() { false }
                    : new List<bool?>() { null, true, false };

            foreach (bool? pooling in enumerable)
            {
                string newDbName = $"Test of ResilientDbKiller {Guid.NewGuid().ToString()}";
                Console.WriteLine($"TEST WITH POOLING = [{pooling}]");
                var conMaster = testCase.CreateConnection();
                conMaster.Execute($"Create Database [{newDbName}]", commandTimeout: 90);

                // Open 5 connections
                List<DbConnection> connections = new List<DbConnection>();
                for (int i = 1; i <= 1; i++)
                {
                    DbConnection conDb = testCase.CreateConnection(pooling: pooling, initialCatalog: newDbName);
                    conDb.Open();
                    conDb.Execute($"Create Table T{i}(id int)");
                    connections.Add(conDb);
                }

                Stopwatch sw = Stopwatch.StartNew();
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName, retryCount: 5);
                var milliseconds = sw.ElapsedMilliseconds;
                Console.WriteLine($"{milliseconds:n0} millisecs: ResilientDbKiller.Kill('{newDbName}')");
                Console.WriteLine();

                Assert.That(conMaster.Manage().IsDbExists(newDbName), Is.False);
            }
        }

        [Test]
        public void Z_Log()
        {
            Console.WriteLine(SqlJamLog.Log);
        }


    }
}
