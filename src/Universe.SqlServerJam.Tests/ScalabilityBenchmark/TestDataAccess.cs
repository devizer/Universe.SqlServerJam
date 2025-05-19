using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Dapper;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark
{
    [TestFixture]
    public class TestDataAccess
    {
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetApp1Servers))]
        public void TestAll(SqlServerRef testCase)
        {
            if (!testCase.CanSimplyCreateDatabase()) return;

            string newDbName = $"Test of App1 {Guid.NewGuid():N}";
            var conMaster = testCase.CreateConnection();
            conMaster.Execute($"Create Database [{newDbName}]", commandTimeout: 90);

            IDbConnection NewConnection(bool open = true)
            {
                var ret = testCase.CreateConnection(pooling: true, initialCatalog: newDbName);
                if (open) ret.Open();
                return ret;
            }

            try
            {
                Migration migration = new Migration(() => NewConnection());
                migration.Migrate();

                DataAccess dataAccess = new DataAccess(() => NewConnection(open: true));
                
                Assert.That(
                    dataAccess.GetCategories(new[] { "1", "2" }),
                    Is.Empty);

                Assert.That(
                    dataAccess.GetCategory("3"),
                    Is.Null);

                dataAccess.UpdateCategorySummary("checkpoint1", 1, 4.5);
                dataAccess.UpdateCategorySummary("checkpoint7", 1, 4.5);
                var checkpoint1a = dataAccess.GetCategory("checkpoint1");
                Assert.That(checkpoint1a.Count, Is.EqualTo(1));

                dataAccess.UpdateCategorySummary("checkpoint1", 2, 10);
                var checkpoint1b = dataAccess.GetCategory("checkpoint1");
                Assert.That(checkpoint1b.Count, Is.EqualTo(1+2));

                DataSeeder seeder = new DataSeeder(dataAccess);
                seeder.Seed(100);
            }

            finally
            {
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            }


        }

    }
}
