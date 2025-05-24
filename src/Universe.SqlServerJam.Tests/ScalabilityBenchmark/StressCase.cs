using System;
using System.Collections.Generic;
using System.Linq;
using Universe.GenericTreeTable;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

public class StressCase
{
    public int SqlCores;
    public long SqlAffinity;
    public int DashboardThreads;
    public int MergeThreads;
    public long AppCores;
    public long AppAffinity;
    public IDictionary<string, int> Workers = new Dictionary<string, int>(StringComparer.OrdinalIgnoreCase);

    public int AppProcessorCount; // same for the all
    public int SqlProcessorCount; // same for the all
}

public static class StressCaseExtensions
{
    public static string Format(this IEnumerable<StressCase> list)
    {
        var stressCases = list.ToArray();
        if (stressCases.Length == 0) return "";

        var header = new List<List<string>>
        {
            new List<string> { "Sql", "Cores" },
            new List<string> { "Sql", "Affinity" },
            new List<string> { "Sql", "Affinity" },
            new List<string> { "App", "Cores" },
            new List<string> { "App", "Affinity" },
            new List<string> { "App", "Affinity" },
            new List<string> { "Dashboard", "Threads" },
        };
        var ct = new ConsoleTable(header) { NeedUnicode = true };

        var sqlProcessorCount = stressCases.First().SqlProcessorCount;
        var appProcessorCount = stressCases.First().AppProcessorCount;
        foreach (var stressCase in stressCases)
        {
            ct.AddRow(
                stressCase.SqlCores,
                AffinityMask.FormatAffinity(sqlProcessorCount, stressCase.SqlAffinity),
                stressCase.SqlAffinity.ToString("X16"),
                stressCase.AppCores,
                AffinityMask.FormatAffinity(appProcessorCount, stressCase.AppAffinity),
                stressCase.AppAffinity.ToString("X16"),
                stressCase.DashboardThreads.ToString("0")
            );
        }

        return ct.ToString();
    }
}