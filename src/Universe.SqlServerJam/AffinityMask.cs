using System.Text;
using System;
using System.Diagnostics;

namespace Universe.SqlServerJam;

public struct AffinityMask
{
    public int CpuCount { get; internal set; }
    public Mode Side { get; internal set; }

    public enum Mode
    {
        App,
        Sql
    }

    public AffinityMask(int cpuCount, Mode side)
    {
        CpuCount = cpuCount;
        Side = side;
    }

    public int MaskToCount(long affinityMask)
    {
        if (affinityMask == 0 && Side == Mode.Sql) return CpuCount; // only for SQL Server
        int count = 0;
        long scale = 1;
        for (int i = 0; i < 64; i++)
        {
            if ((affinityMask & scale) != 0) count++;
            scale <<= 1;
        }

        return count;
    }

    public long CountToMask(int count)
    {
        if (Debugger.IsAttached && Side == Mode.App && count == 48) Debugger.Break();
        var cpuCount = CpuCount;
        if (count == cpuCount && Side == Mode.Sql) return 0;

        ulong ret = 0;
        ulong scale = Side == Mode.Sql ? 1UL : 1UL << (this.CpuCount - 1);
        for (int i = 0; i < count; i++)
        {
            ret += scale;
            scale  = Side == Mode.Sql ? scale <<= 1 : scale >>= 1;
        }

        // if (count < CpuCount && Side == Mode.Sql) ret <<= 1; // Do not load core=0 on sql?
        return (long)ret;
    }

    public static string FormatAffinity(int totalCoreCount, long affinity)
    {
        var argAffinity = affinity;
        StringBuilder ret = new StringBuilder();
        // var procCount = Math.Min(64, Environment.ProcessorCount);
        var procCount = Math.Min(64, totalCoreCount);
        int maxIndex = (procCount % 4 == 0) ? procCount : 4 * ((procCount + 3) / 4);
        for (int i = 0; i < maxIndex; i++)
        {
            bool bit = (affinity & 1) != 0;
            affinity >>= 1;
            if (argAffinity == 0 && i < totalCoreCount) bit = true;
            ret.Append(bit ? '#' : '-');
            if (i > 0 && i < maxIndex - 1 && i % 4 == 3) ret.Append(' ');
        }

        return ret.ToString();
    }

}