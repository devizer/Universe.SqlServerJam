using Dapper;
using NUnit.Framework;
using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

[TestFixture]
public class BusinessLogicScalabilityBenchmark
{
    private Action CleanUp;

    [Test]
    [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetApp1Servers))]
    public void StressScalability(SqlServerRef testCase)
    {
        if (!testCase.CanSimplyCreateDatabase()) return;

        var management = testCase.Manage();
        var sqlServerCpuCores = management.CpuCount;
        var conMaster = testCase.CreateConnection();
        string newDbName = $"Test of App1 {Guid.NewGuid():N}";
        conMaster.Execute($"Create Database [{newDbName}]", commandTimeout: 90);

        IDbConnection NewConnection(bool open = true)
        {
            var ret = testCase.CreateConnection(pooling: true, initialCatalog: newDbName);
            if (open) ret.Open();
            return ret;
        }

        CleanUp = () =>
        {
            ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            management.Configuration.AffinityCount = 0;
        };

        Migration migration = new Migration(() => NewConnection());
        migration.Migrate();
        DataAccess dataAccess = new DataAccess(() => NewConnection(open: true));
        DataSeeder seeder = new DataSeeder(dataAccess);
        seeder.Seed(20000, timeLimit: TimeSpan.FromSeconds(90));
        StressState.Categories = dataAccess.GetAllCategories().ToArray();
        Console.WriteLine($"Stress DB [{newDbName}] is ready");
        Console.WriteLine($"DB Size: {management.Databases[newDbName].Size:n0} KB");
        Console.WriteLine($"Categories Count: {StressState.Categories.Length:n0}");

        for (int sqlCores = 1; sqlCores <= sqlServerCpuCores; sqlCores++)
        {
            Console.WriteLine($"SQL CPU AFFINITY COUNT is {sqlCores}");
            management.Configuration.AffinityCount = (short)sqlCores;
            Console.WriteLine($"not implemented");
        }
    }

    TotalStressResult RunStress(int workerUpdaterCount, int workerReaderCount, DataAccess dataAccess, TimeSpan duration)
    {
        throw new NotImplementedException();
    }



    [TearDown]
    public void TearDown()
    {
        CleanUp?.Invoke();
    }
}