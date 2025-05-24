using System.Collections.Generic;
using System.Linq;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

public class StressCaseSource
{
    public int TotalCores { get; set; }

    public override string ToString()
    {
        return $"{nameof(TotalCores)}: {TotalCores}";
    }

    public static List<StressCaseSource> Get()
    {
        var totalCores = new int[] { 1, 2, 3, 4, 6, 8, 12, 16, 24, 32, 48, 62, 63, 64 };
        return totalCores.Select(x => new StressCaseSource() { TotalCores = x }).ToList();
    }
}