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
            if (!testCase.CanSimplyCreateDatabase()) return;

            foreach (bool? pooling in new List<bool?>() { null, true, false })
            {
                string newDbName = $"Test of ResilientDbKiller {Guid.NewGuid().ToString()}";
                Console.WriteLine($"TEST WITH POOLING = [{pooling}]");
                var conMaster = testCase.CreateConnection();
                conMaster.Execute($"Create Database [{newDbName}]");

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
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
                var milliseconds = sw.ElapsedMilliseconds;
                Console.WriteLine($"{milliseconds:n0} millisecs: ResilientDbKiller.Kill('{newDbName}')");
                Console.WriteLine();

                Assert.That(conMaster.Manage().IsDbExists(newDbName), Is.False);
            }
        }

    }
}
