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
using Universe.StressOrchestration;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

[TestFixture]
public class SensorsAppScalabilityBenchmark : NUnitTestsBase
{
    // 1M - 2 minutes, 2.8Gb + 0.6Gb
    static int GetStressCategoriesCount()
    {
        if (!BuildServerInfo.IsBuildServer) return 100 * 1000;
        bool isDbOnRamDisk = !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("RAM_DISK"));
        if (!isDbOnRamDisk) return 1000 * 1000;
        bool isWindows = CrossInfo.ThePlatform == CrossInfo.Platform.Windows;
        return isWindows ? 100 * 1000 : 400 * 1000;
    }

    static bool KillTempDB = true;

    private Action CleanUp;

    [Test]
    [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetApp1DeveloperServers))]
    public void StressScalability(SqlServerRef testCase)
    {
        if (!testCase.CanSimplyCreateDatabase()) return;

        var management = testCase.Manage();
        var sqlServerCpuCores = management.CpuCount;
        var conMaster = testCase.CreateConnection();
        string newDbName = $"Test of Sensors {DateTime.Now:yyyy-MM-dd HH-mm-ss.ff} {Guid.NewGuid():N}";
        conMaster.Execute($"Create Database [{newDbName}]", commandTimeout: 90);

        IDbConnection NewConnection(bool pooling = true, bool open = true)
        {
            var ret = testCase.CreateConnection(pooling: pooling, initialCatalog: newDbName);
            if (open) ret.Open();
            return ret;
        }

        CleanUp = () =>
        {
            if (KillTempDB) ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            management.Configuration.AffinityCount = 0;
        };

        var dbManagement = management.Databases[newDbName];
        dbManagement.RecoveryMode = DatabaseRecoveryMode.Simple;
        dbManagement.PageVerify = DatabasePageVerify.None;
        dbManagement.AutoCreateStatistic = AutoCreateStatisticMode.Incremental;
        dbManagement.AutoUpdateStatistic = AutoUpdateStatisticMode.Async;
        dbManagement.IsAutoShrink = false;

        Migration migration = new Migration(() => NewConnection());
        migration.Migrate();
        DataAccess dataAccess = new DataAccess(() => NewConnection(open: true));
        DataAccess dataAccessWithoutPooling = new DataAccess(() => NewConnection(pooling: false, open: true));
        DataSeeder seeder = new DataSeeder(dataAccessWithoutPooling);
        Stopwatch startSeedAt = Stopwatch.StartNew();
        var categoriesCount = GetStressCategoriesCount();
        seeder.Seed(categoriesCount);
        Console.WriteLine($"Stress DB [{newDbName}] is ready{Environment.NewLine}Seed took {startSeedAt.Elapsed.TotalSeconds:n2} seconds");
        StressState.Categories = dataAccess.GetAllCategories().ToArray();

        Console.WriteLine($"DB Size: {dbManagement.Files.ToSizeString()}");
        Console.WriteLine($"Categories Count: {StressState.Categories.Length:n0}");

        StressWorkerReader reader = new StressWorkerReader(dataAccess);
        StressWorkerUpdater updater = new StressWorkerUpdater(dataAccess);

        StressOrchestrator preJit = new StressOrchestrator() { MaxDuration = TimeSpan.Zero };
        preJit.AddWorker("1", reader);
        preJit.AddWorker("2", updater);
        preJit.Run();

        var sqlCpuName = management.CpuName;
        Console.WriteLine($"SQL Server {testCase} CPU: '{sqlCpuName}'");
        Console.WriteLine("");
        List<int> sqlCoresList = Enumerable.Range(1, sqlServerCpuCores).ToList();
        foreach (var sqlCores in sqlCoresList)
        {
            management.Configuration.AffinityCount = (short)sqlCores;
            Console.WriteLine($"SQL CPU AFFINITY COUNT is {sqlCores}/{sqlServerCpuCores}. Affinity mask = {management.Configuration.AffinityMask}");
            var stressDuration = TimeSpan.FromSeconds(TestEnvironment.SQL_STRESS_DURATION_SECONDS ?? 2);
            StressOrchestrator stressOrchestrator = new StressOrchestrator() { MaxDuration = stressDuration };
            stressOrchestrator.AddWorker($"Merging", updater);
            stressOrchestrator.AddWorkers("Dashboard", Math.Max(1, sqlServerCpuCores - 1), reader);
            var sqlCpuUsageOnStart = management.CpuUsage;
            var totalResults = stressOrchestrator.Run();
            var sqlCpuUsage = management.CpuUsage - sqlCpuUsageOnStart;
            Console.WriteLine($"SQL Server CPU Usage: {sqlCpuUsage.Format(stressOrchestrator.MaxDuration.TotalSeconds)}; {sqlCpuUsage}");
            Console.WriteLine(totalResults);
            // TestContext.WriteLine(totalResults);
        }
    }


    [TearDown]
    public void TearDown()
    {
        CleanUp?.Invoke();
    }
}