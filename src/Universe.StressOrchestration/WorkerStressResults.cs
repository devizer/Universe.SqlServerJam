using System;
using System.Collections.Generic;

namespace Universe.StressOrchestration;

public class WorkerStressResults
{
    public string WorkerGroup { get; set; }
    public Type WorkerType { get; set; }
    public string WorkerTitle { get; set; }
    public double TotalDuration { get; set; }
    public double TotalDurationSquared { get; set; }
    public CpuUsage.CpuUsage TotalCpuUsage { get; set; }
    public long TotalCount { get; set; }
    public List<Exception> UpdateActionErrors { get; } = new List<Exception>();

    public double StdDevDuration => MathUtilities.GetStdDev(TotalCount, TotalDuration, TotalDurationSquared);

    public override string ToString()
    {
        var stdevString = TotalCount > 2 ? $" ± {1000 * StdDevDuration:n3}" : "";
        var avgString = TotalCount == 0 ? "" : $" (avg = {(1000*TotalDuration / TotalCount):n2}{stdevString})";
        var cpuPercents = 100d * TotalCpuUsage.TotalMicroSeconds / TotalDuration / 1000000;
        var type = $"Type: {WorkerType.Name}";
        return $"«{WorkerTitle}» * {TotalCount:n0}{avgString} ➛ CPU {cpuPercents:n2}% {TotalCpuUsage}, Errors: {UpdateActionErrors.Count:n0}";
    }
}