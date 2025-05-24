using Dapper;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using Universe.NUnitTests;
using Universe.StressOrchestration;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

[TestFixture]
public class SensorsAppScalabilityBenchmark : NUnitTestsBase
{
    // 1M - 2 minutes, 2.8Gb + 0.6Gb
    static int GetStressCategoriesCount()
    {
        var envValue = SensorsAppStressSettings.WorkingSetRows;
        if (!BuildServerInfo.IsBuildServer) return envValue.GetValueOrDefault(100 * 1000);
        bool isDbOnRamDisk = !string.IsNullOrEmpty(Environment.GetEnvironmentVariable("RAM_DISK"));
        if (!isDbOnRamDisk) return 1000 * 1000;
        bool isWindows = CrossInfo.ThePlatform == CrossInfo.Platform.Windows;
        return isWindows ? 100 * 1000 : 400 * 1000;
    }

    static bool KillTempDB = false;

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
            // Adjust App Cores
            var appCoreCount = Environment.ProcessorCount;
            if (testCase.ToSqlServerDataSource()?.IsLocal == true)
            {
                appCoreCount = Environment.ProcessorCount - sqlCores;
                var lowerAppCores = Math.Max(1, Environment.ProcessorCount * 3 / 4);
                appCoreCount = Math.Max(lowerAppCores, appCoreCount);
            }

            var appAffinity = new AffinityMask(Environment.ProcessorCount, AffinityMask.Mode.App);
            var appAffinityMask = appAffinity.CountToMask(appCoreCount);
            Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(appAffinityMask);
            Console.WriteLine($"App Cores: {appCoreCount}/{Environment.ProcessorCount}, {AffinityMask.FormatAffinity(Environment.ProcessorCount, appAffinityMask)}");

            management.Configuration.AffinityCount = sqlCores;
            Console.WriteLine($"SQL Cores: {sqlCores}/{sqlServerCpuCores}, {AffinityMask.FormatAffinity(Environment.ProcessorCount, management.Configuration.AffinityMask)}");
            var stressDuration = TimeSpan.FromMilliseconds(SensorsAppStressSettings.StressDuration ?? 2000);
            StressOrchestrator stressOrchestrator = new StressOrchestrator() { MaxDuration = stressDuration };
            stressOrchestrator.AddWorker($"Merging", updater);
            var dashboardWorkersCount = Math.Min(Environment.ProcessorCount, Math.Max(1, sqlCores + 1));
            stressOrchestrator.AddWorkers("Dashboard", dashboardWorkersCount, reader);
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