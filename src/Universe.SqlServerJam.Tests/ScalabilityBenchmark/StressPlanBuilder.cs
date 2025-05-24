using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

public class StressPlanBuilder
{
    public bool IsLocalServer { get; set; }
    public int SqlProcessorCount { get; set; }
    public int AppProcessorCount { get; set; }
    public string[] Workers { get; set; } = new string[0];


    public List<StressCase> GetStressCases()
    {
        List<StressCase> ret = new List<StressCase>();
        for (int sqlCores = 1; sqlCores <= SqlProcessorCount; sqlCores++)
        {
            // Adjust App Cores
            var appCoreCount = AppProcessorCount;
            if (IsLocalServer)
            {
                // 1 => 7
                appCoreCount = AppProcessorCount - sqlCores;
                var min1AppCores = AppProcessorCount - AppProcessorCount * 3 / 4;
                var min2AppCores = AppProcessorCount * 4 / 8;
                var minAppCores = Math.Max(min1AppCores, min2AppCores);
                var lowerAppCores = Math.Max(1, minAppCores);
                appCoreCount = Math.Max(lowerAppCores, appCoreCount);
                appCoreCount = Math.Min(appCoreCount, AppProcessorCount);
            }

            var dashboardWorkersCount = sqlCores + 1;
            var dashboardWorkersCountMax = AppProcessorCount;
            // 1: 1; 2: 2, 4: 2, 8: 4
            var dashboardWorkersCountMin1 = 4;
            dashboardWorkersCount = Math.Max(dashboardWorkersCountMin1, Math.Min(dashboardWorkersCountMax, dashboardWorkersCount));


            var appAffinityMask = new AffinityMask(AppProcessorCount, AffinityMask.Mode.App).CountToMask(appCoreCount);
            var sqlAffinityMask = new AffinityMask(SqlProcessorCount, AffinityMask.Mode.Sql).CountToMask(sqlCores);
            ret.Add(new StressCase()
            {
                SqlProcessorCount = SqlProcessorCount,
                AppProcessorCount = AppProcessorCount,
                AppCores = appCoreCount,
                AppAffinity = appAffinityMask,
                SqlCores = sqlCores,
                SqlAffinity = sqlAffinityMask,
                DashboardThreads = dashboardWorkersCount,
            });
        }

        ret.Add(new StressCase()
        {
            SqlProcessorCount = SqlProcessorCount,
            AppProcessorCount = AppProcessorCount,
            AppCores = AppProcessorCount,
            AppAffinity = new AffinityMask(AppProcessorCount, AffinityMask.Mode.App).CountToMask(AppProcessorCount),
            SqlCores = SqlProcessorCount,
            SqlAffinity = new AffinityMask(SqlProcessorCount, AffinityMask.Mode.Sql).CountToMask(SqlProcessorCount),
            DashboardThreads = AppProcessorCount,
        });

        return ret;
    }

}