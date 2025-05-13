using System;
using System.Collections.Generic;
using System.Data;
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


            string newDbName = $"Test of TestResilientDbKiller {Guid.NewGuid().ToString()}";
            foreach (bool? pooling in new List<bool?>() { null, true, false })
            {
                Console.WriteLine($"TEST WITH POOLING = [{pooling}]");
                var csMaster = SqlServerJamConfigurationExtensions.ResetConnectionPooling(testCase.ConnectionString, pooling);
                var csDb = SqlServerJamConfigurationExtensions.ResetConnectionDatabase(csMaster, newDbName);
                SqlConnection conMaster = new SqlConnection(csMaster);
                // Console.WriteLine($"MASTER:{Environment.NewLine}{csMaster}");
                // Console.WriteLine($"CONCRETE DB:{Environment.NewLine}{csDb}");

                conMaster.Execute($"Create Database [{newDbName}]");

                List<SqlConnection> connections = new List<SqlConnection>();
                for (int i = 1; i <= 5; i++)
                {
                    SqlConnection conDb = new SqlConnection(csDb);
                    conDb.Open();
                    conDb.Execute($"Create Table T{i}(id int)");
                    connections.Add(conDb);
                }

                Stopwatch sw = Stopwatch.StartNew();
                ResilientDbKiller.Kill(csDb);
                bool isExists = conMaster.Manage().IsDbExists(newDbName);
                Console.WriteLine($"{sw.ElapsedMilliseconds:n0} millisecs: ResilientDbKiller.Kill('{newDbName}')");
                Console.WriteLine();

                Assert.That(isExists, Is.False);
            }
        }

    }
}
