using System;
using System.Collections.Generic;

namespace Universe.SqlServerJam;

public struct SqlCpuUsage
{
    // milliseconds
    public long UserMilliseconds { get; internal set; }
    public long KernelMilliseconds { get; internal set; }

    public SqlCpuUsage(long userMilliseconds, long kernelMilliseconds)
    {
        UserMilliseconds = userMilliseconds;
        KernelMilliseconds = kernelMilliseconds;
    }

    public override string ToString() =>
        $"{TotalMilliseconds/1000d:n3} = {UserMilliseconds/1000d:n3} (user) + {KernelMilliseconds/1000d:n3} (kernel) seconds";

    public long TotalMilliseconds => UserMilliseconds + KernelMilliseconds;

    public static bool IsSupportedBy(Version sqlServerVersion) =>
        sqlServerVersion.Major >= 11
        || (sqlServerVersion.Major == 10 && sqlServerVersion.Minor >= 50);

    public static SqlCpuUsage Zero => new SqlCpuUsage();

    public static SqlCpuUsage? operator -(SqlCpuUsage? one, SqlCpuUsage? two) =>
        one.HasValue || two.HasValue
            ? new SqlCpuUsage()
            {
                UserMilliseconds = one.GetValueOrDefault().UserMilliseconds - two.GetValueOrDefault().UserMilliseconds,
                KernelMilliseconds = one.GetValueOrDefault().KernelMilliseconds - two.GetValueOrDefault().KernelMilliseconds
            }
            : null;

    public static SqlCpuUsage? operator +(SqlCpuUsage? one, SqlCpuUsage? two) =>
        one.HasValue || two.HasValue
            ? new SqlCpuUsage()
            {
                UserMilliseconds = one.GetValueOrDefault().UserMilliseconds + two.GetValueOrDefault().UserMilliseconds,
                KernelMilliseconds = one.GetValueOrDefault().KernelMilliseconds + two.GetValueOrDefault().KernelMilliseconds
            }
            : null;

    public static SqlCpuUsage operator +(SqlCpuUsage one, SqlCpuUsage two) =>
        new SqlCpuUsage()
        {
            UserMilliseconds = one.UserMilliseconds + two.UserMilliseconds,
            KernelMilliseconds = one.KernelMilliseconds + two.KernelMilliseconds
        };
    public static SqlCpuUsage operator -(SqlCpuUsage one, SqlCpuUsage two) =>
        new SqlCpuUsage()
        {
            UserMilliseconds = one.UserMilliseconds - two.UserMilliseconds,
            KernelMilliseconds = one.KernelMilliseconds - two.KernelMilliseconds
        };

    public static SqlCpuUsage Sum(IEnumerable<SqlCpuUsage> list)
    {
        SqlCpuUsage ret = Zero;
        foreach (SqlCpuUsage item in list) ret += item;
        return ret;
    }

    public static SqlCpuUsage? Sum(IEnumerable<SqlCpuUsage?> list)
    {
        SqlCpuUsage? ret = null;
        foreach (SqlCpuUsage? item in list) ret += item;
        return ret;
    }

}

public static class SqlCpuUsageExtensions
{
    public static string Format(this SqlCpuUsage? sqlCpuUsage, double duration)
    {
        if (sqlCpuUsage == null || Math.Abs(duration) < Double.Epsilon) return null;

        string FormatAsPercents(long milliseconds) => $"{(100d * milliseconds / duration / 1000):n1}%";

        var meaningful =
             $"user = {FormatAsPercents(sqlCpuUsage.Value.UserMilliseconds)} + "
            + $"kernel = {FormatAsPercents(sqlCpuUsage.Value.KernelMilliseconds)}";

        return
            $"{FormatAsPercents(sqlCpuUsage.Value.TotalMilliseconds)}"
            + $" ({meaningful.Trim()})";

    }

    public static TimeSpan ToTimeSpan(this SqlCpuUsage sqlCpuUsage) =>
        TimeSpan.FromMilliseconds((double)sqlCpuUsage.TotalMilliseconds);

    public static TimeSpan? ToTimeSpan(this SqlCpuUsage? sqlCpuUsage) =>
        sqlCpuUsage == null ? TimeSpan.Zero : sqlCpuUsage.GetValueOrDefault().ToTimeSpan();
}