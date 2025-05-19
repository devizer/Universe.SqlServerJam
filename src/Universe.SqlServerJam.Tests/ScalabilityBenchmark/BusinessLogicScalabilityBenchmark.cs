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
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

[TestFixture]
public class BusinessLogicScalabilityBenchmark : NUnitTestsBase
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
        Stopwatch startSeedAt = Stopwatch.StartNew();
        seeder.Seed(20000, timeLimit: TimeSpan.FromSeconds(90));
        Console.WriteLine($"Stress DB [{newDbName}] is ready. Seed took {startSeedAt.Elapsed.TotalSeconds:n2} seconds");
        StressState.Categories = dataAccess.GetAllCategories().ToArray();
        Console.WriteLine($"DB Size: {management.Databases[newDbName].Size:n0} KB");
        Console.WriteLine($"Categories Count: {StressState.Categories.Length:n0}");

        StressWorkerReader reader = new StressWorkerReader(dataAccess);
        StressWorkerUpdater updater = new StressWorkerUpdater(dataAccess);

        StressOrchestrator preJit = new StressOrchestrator() { MaxDuration = TimeSpan.Zero };
        preJit.AddWorker("1", reader);
        preJit.AddWorker("2", updater);
        preJit.Run();

        var sqlCpuName = management.CpuName;
        for (int sqlCores = 1; sqlCores <= sqlServerCpuCores; sqlCores++)
        {
            Console.WriteLine($"SQL CPU AFFINITY COUNT is {sqlCores}/{sqlServerCpuCores} on \"{sqlCpuName}\"");
            management.Configuration.AffinityCount = (short)sqlCores;
            var stressDuration = TimeSpan.FromSeconds(TestEnvironment.SQL_STRESS_DURATION_SECONDS ?? 2);
            StressOrchestrator stressOrchestrator = new StressOrchestrator() { MaxDuration = stressDuration };
            stressOrchestrator.AddWorker($"Updater", updater);
            stressOrchestrator.AddWorkers("Dashboard", sqlCores, reader);
            var totalResults = stressOrchestrator.Run();
            Console.WriteLine(totalResults + Environment.NewLine);
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