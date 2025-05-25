using Dapper;
using NUnit.Framework;
using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using Universe.GenericTreeTable;
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
        Stopwatch getCategoriesStartAt = Stopwatch.StartNew();
        StressState.Categories = dataAccess.GetAllCategories().ToArray();
        getCategoriesStartAt.Stop();

        Console.WriteLine($"DB Size: {dbManagement.Files.ToSizeString()}");
        Console.WriteLine($"Categories Count: {StressState.Categories.Length:n0}, took {getCategoriesStartAt.Elapsed.TotalSeconds:n2} seconds");

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
        TotalStressResult baseLine = null;
        var stressCases = GetStressCases(testCase);
        foreach (var stressCase in stressCases)
        {

            Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(stressCase.AppAffinity);
            Console.WriteLine($"App Cores: {stressCase.AppCores}/{Environment.ProcessorCount}, {AffinityMask.FormatAffinity(Environment.ProcessorCount, stressCase.AppAffinity)}, {stressCase.AppAffinity:X16}");

            management.Configuration.AffinityCount = stressCase.SqlCores;
            Console.WriteLine($"SQL Cores: {stressCase.SqlCores}/{sqlServerCpuCores}, {AffinityMask.FormatAffinity(Environment.ProcessorCount, management.Configuration.AffinityMask)}, {management.Configuration.AffinityMask:X16}");
            
            var stressDuration = TimeSpan.FromMilliseconds(SensorsAppStressSettings.StressDuration ?? 2000);
            StressOrchestrator stressOrchestrator = new StressOrchestrator() { MaxDuration = stressDuration };
            stressOrchestrator.AddWorker($"Merging", updater);
            stressOrchestrator.AddWorkers("Dashboard", stressCase.DashboardThreads, reader);
            var sqlCpuUsageOnStart = management.CpuUsage;
            TotalStressResult totalResults = stressOrchestrator.Run();
            baseLine ??= totalResults;
            var sqlCpuUsage = management.CpuUsage - sqlCpuUsageOnStart;
            Console.WriteLine($"SQL Server CPU Usage: {sqlCpuUsage.Format(stressOrchestrator.MaxDuration.TotalSeconds)}; {sqlCpuUsage}");
            Console.WriteLine(totalResults.ToString(baseLine));
        }
    }

    List<StressCase> GetStressCases(SqlServerRef sqlServerRef)
    {
        var management = sqlServerRef.Manage();
        var sqlCpuName = management.CpuName;
        var sqlCpuCount = management.CpuCount;
        bool isLocalServer = sqlServerRef.ToSqlServerDataSource().IsLocal;
        StressPlanBuilder stressPlanBuilder = new StressPlanBuilder()
        {
            IsLocalServer = isLocalServer,
            AppProcessorCount = Environment.ProcessorCount,
            SqlProcessorCount = sqlCpuCount,
            Workers = new string[] { "Dashboard", "Merging" }
        };

        var ret = stressPlanBuilder.GetStressCases();
        return ret;
    }

    List<StressCase> GetStressCases_KillIt(bool isLocalServer, int sqlProcessorCount, int appProcessorCount, string[] workers)
    {
        List<StressCase> ret = new List<StressCase>();
        for (int sqlCores = 1; sqlCores <= sqlProcessorCount; sqlCores++)
        {
            // Adjust App Cores
            var appCoreCount = appProcessorCount;
            if (isLocalServer)
            {
                // 1 => 7
                appCoreCount = appProcessorCount - sqlCores;
                var min1AppCores = appProcessorCount - appProcessorCount * 3 / 4;
                var min2AppCores = appProcessorCount * 4 / 8;
                var minAppCores = Math.Max(min1AppCores, min2AppCores);
                var lowerAppCores = Math.Max(1, minAppCores);
                appCoreCount = Math.Max(lowerAppCores, appCoreCount);
                appCoreCount = Math.Min(appCoreCount, appProcessorCount);
            }

            var dashboardWorkersCount = sqlCores + 1;
            var dashboardWorkersCountMax = appProcessorCount;
            // 1: 1; 2: 2, 4: 2, 8: 4
            var dashboardWorkersCountMin1 = 4;
            dashboardWorkersCount = Math.Max(dashboardWorkersCountMin1, Math.Min(dashboardWorkersCountMax, dashboardWorkersCount));


            var appAffinityMask = new AffinityMask(appProcessorCount, AffinityMask.Mode.App).CountToMask(appCoreCount);
            var sqlAffinityMask = new AffinityMask(sqlProcessorCount, AffinityMask.Mode.Sql).CountToMask(sqlCores);
            ret.Add(new StressCase()
            {
                SqlProcessorCount = sqlProcessorCount,
                AppProcessorCount = appProcessorCount,
                AppCores = appCoreCount,
                AppAffinity = appAffinityMask,
                SqlCores = sqlCores,
                SqlAffinity = sqlAffinityMask,
                DashboardThreads = dashboardWorkersCount,
            });
        }

        ret.Add(new StressCase()
        {
            SqlProcessorCount = sqlProcessorCount,
            AppProcessorCount = appProcessorCount,
            AppCores = appProcessorCount,
            AppAffinity = new AffinityMask(appProcessorCount, AffinityMask.Mode.App).CountToMask(appProcessorCount),
            SqlCores = sqlProcessorCount,
            SqlAffinity = new AffinityMask(sqlProcessorCount, AffinityMask.Mode.Sql).CountToMask(sqlProcessorCount),
            DashboardThreads = appProcessorCount,
        });

        return ret;
    }

    [Test]
    [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetApp1DeveloperServers))]
    public void ShowStressCases(SqlServerRef testCase)
    {
        var stressCases = GetStressCases(testCase);
        Console.WriteLine(stressCases.Format());
    }




    [TearDown]
    public void TearDown()
    {
        CleanUp?.Invoke();
    }
}