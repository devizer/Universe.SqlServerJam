using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Universe.GenericTreeTable;

namespace Universe.StressOrchestration;

public class TotalStressResult
{
    public TimeSpan TotalDuration { get; internal set; } // Includes wait on countdown and join
    public TimeSpan PayloadDuration => TimeSpan.FromSeconds(WorkerResults.Count == 0 ? 0 : WorkerResults.Max(x => x.TotalDuration));
    public List<WorkerStressResults> WorkerResults { get; internal set; } = new List<WorkerStressResults>();

    public override string ToString()
    {
        string[] groups = WorkerResults.Select(x => x.WorkerGroup).OrderBy(x => x).Distinct(StringComparer.OrdinalIgnoreCase).ToArray();
        if (groups.Length == 0) return string.Empty;
        int maxGroupNameLength = groups.Max(x => x.Length);
        StringBuilder ret = new StringBuilder();

        long actionsCount = WorkerResults.Count == 0 ? 0 : WorkerResults.Sum(x => x.TotalCount);
        var totalRow = $"Total Actions: {actionsCount:n0} in {TotalDuration.TotalSeconds:n2} seconds";

        ConsoleTable mainTable = new ConsoleTable("●", "C", "*", "-N", "A", "➛", "-%", "%", "!")
        {
            HideColumnBorders = true,
            HideHeader = true
        };

        string FirstColumnBorder() => mainTable.LineCount == 0 ? "╶┬╴ " : " │ ";

        string FormatShortCpuUsage(CpuUsage.CpuUsage cpuUsage, double duration)
        {
            return (Math.Abs(duration) <= Double.Epsilon)
                ? ""
                : $"{(100d * cpuUsage.TotalMicroSeconds / duration / 1000000):n1}";
        }

        string FormatAsPercents(long microseconds, double duration)
        {
            var ret = $"{(100d * microseconds / duration / 1000000):n1}%";
            return $"{ret,-5}";
        }
            
        string FormatLongCpuUsage(CpuUsage.CpuUsage cpuUsage, double duration)
        {
            if (Math.Abs(duration) <= Double.Epsilon) return "";
            var meaningful =
                $"user = {FormatAsPercents(cpuUsage.UserUsage.TotalMicroSeconds, duration)} + "
                + $"kernel = {FormatAsPercents(cpuUsage.KernelUsage.TotalMicroSeconds, duration)}";

            return $"{{{meaningful.Trim()}}}";
        }


        foreach (var group in groups)
        {
            var workersOfGroup = WorkerResults.Where(x => x.WorkerGroup.Equals(group, StringComparison.OrdinalIgnoreCase)).ToArray();
            var countOfGroup = workersOfGroup.Length;
            var sumActionCount = workersOfGroup.Sum(x => x.TotalCount);
            var sumDuration = workersOfGroup.Sum(x => x.TotalDuration);
            var sumDurationSquared = workersOfGroup.Sum(x => x.TotalDurationSquared);
            var sumCpuUsage = new CpuUsage.CpuUsage();
            foreach (var w in workersOfGroup) sumCpuUsage += w.TotalCpuUsage;
            double sumStdev = MathUtilities.GetStdDev(sumActionCount, sumDuration, sumDurationSquared);
            var stdevString = sumActionCount > 2 ? $" ± {1000 * sumStdev:n3}" : "";
            var avgString = sumActionCount == 0 ? "" : $" (avg = {(1000 * sumDuration / sumActionCount):n2}{stdevString})";
            var cpuPercentsString = FormatShortCpuUsage(sumCpuUsage, sumDuration);
            var cpuLong = FormatLongCpuUsage(sumCpuUsage, sumDuration);
            var groupErrorsCount = workersOfGroup.Sum(x => x.UpdateActionErrors.Count);
            var groupErrorsString = groupErrorsCount == 0 ? "no errors" : $"{groupErrorsCount} {(groupErrorsCount == 1 ? "error" : "errors")}";
            mainTable.AddRow("", $"«{group}»", $"{FirstColumnBorder()}", $"{sumActionCount:n0}", avgString, " ➛", $" {cpuPercentsString}% ", cpuLong, " " + groupErrorsString);

            if (workersOfGroup.Length >= 2)
            {
                var index = 1;
                foreach (var worker in workersOfGroup)
                {
                    var stdevString_ = worker.TotalCount > 2 ? $" ± {1000 * worker.StdDevDuration:n3}" : "";
                    var avgString_ = worker.TotalCount == 0 ? "" : $" (avg = {(1000 * worker.TotalDuration / worker.TotalCount):n2}{stdevString_})";
                    var cpuPercentsString_ = FormatShortCpuUsage(worker.TotalCpuUsage, worker.TotalDuration);
                    var cpuLong_ = FormatLongCpuUsage(worker.TotalCpuUsage, worker.TotalDuration);
                    var indexString = $"{index:0}{MathUtilities.GetOrdinalSuffix(index)}";
                    indexString = indexString.PadLeft(maxGroupNameLength + 2);
                    mainTable.AddRow("", $"{indexString}", $"{FirstColumnBorder()}", $"{worker.TotalCount:n0}", avgString_, " ➛", $" {cpuPercentsString_}% ", cpuLong_, " " + groupErrorsString);
                    index++;
                }
            }
        }

        if (mainTable.LineCount >= 2)
            mainTable.Cells[mainTable.LineCount - 1, 2] = " ╵ ";
        else if (mainTable.LineCount >= 1)
            mainTable.Cells[mainTable.LineCount - 1, 2] = " | ";

        var r = string.Join(Environment.NewLine, WorkerResults.Select(x => $" • {x}").ToArray());
        return $"{totalRow}{Environment.NewLine}{mainTable}";
    }


    public string ToStringLegacy()
    {
        var r = string.Join(Environment.NewLine, WorkerResults.Select(x => $" • {x}").ToArray());
        long actionsCount = WorkerResults.Count == 0 ? 0 : WorkerResults.Sum(x => x.TotalCount);
        return $"Total Actions: {actionsCount:n0} in {TotalDuration.TotalSeconds:n2} seconds{Environment.NewLine}{r}";
    }
}