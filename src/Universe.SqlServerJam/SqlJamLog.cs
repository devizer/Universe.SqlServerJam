using System;
using System.Diagnostics;
using System.Text;

namespace Universe.SqlServerJam;

public static class SqlJamLog
{
    public static volatile bool EnableDebugLog = false;
    static StringBuilder DebuggerLog = new StringBuilder();
    private static readonly object SyncLog = new object();

    public static void DebugLog(Func<string> message)
    {
        if (true || EnableDebugLog) lock (SyncLog) DebuggerLog.AppendLine().AppendLine(message()).AppendLine();
    }

    public static string Log
    {
        get
        {
            lock (SyncLog) return DebuggerLog.ToString();
        }
    }

    static readonly Stopwatch GlobalStartAt = Stopwatch.StartNew();

    public static ActionLogger LogAction(string caption)
    {
        return new ActionLogger()
        {
            Caption = caption,
            Stopwatch = Stopwatch.StartNew(),
            StartedAt = GlobalStartAt.Elapsed,
        };
    }
}

public class ActionLogger : IDisposable
{
    public string Caption { get; set; }
    public Stopwatch Stopwatch { get; set; }
    public TimeSpan StartedAt { get; set; }
    public Exception Error { get; set; }

    public void Dispose()
    {
        SqlJamLog.DebugLog(() => $"{StartedAt.TotalMilliseconds:-20,n0} {Stopwatch.ElapsedMilliseconds:n0} {Caption}{(Error == null ? "" : Error.Message)}");
    }
}
