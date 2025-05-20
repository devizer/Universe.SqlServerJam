using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using Universe.CpuUsage;
using Universe.GenericTreeTable;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark
{
    public interface IStressAction
    {
        void Act();
    }

    public class StressOrchestrator
    {
        private List<TitledWorker> Workers = new List<TitledWorker>();
        public TimeSpan MaxDuration { get; set; }
        // public bool NeedCpuUsage { get; set; }

        public StressOrchestrator()
        {
        }

        public void AddWorker(string title, IStressAction worker)
        {
            Workers.Add(new TitledWorker() { Group = title, Title = title, Worker = worker });
        }

        public void AddWorkers(string group, int workersCount, IStressAction worker)
        {
            int formatLength = workersCount.ToString("0").Length;
            for (int i = 1; i <= workersCount; i++)
            {
                var title = group + " " + i.ToString("0").PadLeft(formatLength, ' ');
                Workers.Add(new TitledWorker() { Group = group, Title = title, Worker = worker });
            }
        }

        public TotalStressResult Run()
        {
            TotalStressResult ret = new TotalStressResult();

            List<Thread> threads = new List<Thread>();
            // Stopwatch stressStartedAt = Stopwatch.StartNew();
            CountdownEvent countdownStart = new CountdownEvent(Workers.Count);
            Stopwatch countdownStartedAt = null;
            foreach (var titledWorker in Workers)
            {
                var thread = new Thread(() =>
                {
                    WorkerStressResults workerResults = new WorkerStressResults()
                    {
                        WorkerType = titledWorker.Worker.GetType(),
                        WorkerTitle = titledWorker.Title,
                        WorkerGroup = titledWorker.Group
                    };

                    long totalCount = 0;
                    CpuUsage.CpuUsage? syncCpuUsageOnStart = CpuUsage.CpuUsage.GetByThread();
                    CpuUsageAsyncWatcher cpuUsageWatcher = new CpuUsageAsyncWatcher();
                    double workerTotalDurationSeconds = 0;
                    double workerTotalDurationSecondsSquared = 0;
                    countdownStart.Signal();
                    countdownStart.Wait();
                    Interlocked.CompareExchange(ref countdownStartedAt, Stopwatch.StartNew(), null);
                    Stopwatch workerStartedAt = Stopwatch.StartNew();
                    do
                    {
                        Stopwatch actStartedAt = Stopwatch.StartNew();
                        try
                        {
                            titledWorker.Worker.Act();
                        }
                        catch (Exception ex)
                        {
                            workerResults.UpdateActionErrors.Add(ex);
                        }

                        double actDurationSeconds = (double)actStartedAt.ElapsedTicks / Stopwatch.Frequency;
                        workerTotalDurationSeconds += actDurationSeconds;
                        workerTotalDurationSecondsSquared += actDurationSeconds * actDurationSeconds;
                        totalCount++;
                    } while (workerStartedAt.Elapsed <= MaxDuration);

                    var workerTotalDuration = (double)workerStartedAt.ElapsedTicks / Stopwatch.Frequency;
                    CpuUsage.CpuUsage? syncCpuUsageOnEnd = CpuUsage.CpuUsage.GetByThread();
                    CpuUsage.CpuUsage? syncCpuUsage = syncCpuUsageOnEnd - syncCpuUsageOnStart;
                    CpuUsage.CpuUsage asyncCpuUsage = cpuUsageWatcher.GetSummaryCpuUsage();
                    var totalCpuUsage = syncCpuUsage.GetValueOrDefault() + asyncCpuUsage;
                    workerResults.TotalCount = totalCount;
                    workerResults.TotalDuration = workerTotalDuration;
                    workerResults.TotalDurationSquared = workerTotalDurationSecondsSquared;
                    workerResults.TotalCpuUsage = totalCpuUsage;
                    lock (ret) ret.WorkerResults.Add(workerResults);
                });
                thread.IsBackground = true;
                thread.Start();
                threads.Add(thread);
            }

            foreach (var thread in threads) thread.Join();

            ret.TotalDuration = (countdownStartedAt ?? Stopwatch.StartNew()).Elapsed;
            ret.WorkerResults = ret.WorkerResults.OrderBy(x => x.WorkerTitle).ToList();
            return ret;
        }

        public class TitledWorker
        {
            public IStressAction Worker { get; set; }
            public string Group { get; set; }
            public string Title { get; set; }
        }
    }

    public class TotalStressResult
    {
        public TimeSpan TotalDuration { get; set; } // Includes wait on countdown
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
                var meaningful = $"user = {FormatAsPercents(cpuUsage.UserUsage.TotalMicroSeconds, duration)} + " +
                       $"kernel = {FormatAsPercents(cpuUsage.KernelUsage.TotalMicroSeconds, duration)}";
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
                double sumStdev = WorkerStressResults.GetStdDev(sumActionCount, sumDuration, sumDurationSquared);
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
                        var indexString = $"{index:0}{GetOrdinalSuffix(index)}";
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

        private static string GetOrdinalSuffix(int num)
        {
            string number = num.ToString("0");
            if (number.EndsWith("11")) return "th";
            if (number.EndsWith("12")) return "th";
            if (number.EndsWith("13")) return "th";
            if (number.EndsWith("1")) return "st";
            if (number.EndsWith("2")) return "nd";
            if (number.EndsWith("3")) return "rd";
            return "th";
        }

        public string ToStringLegacy()
        {
            var r = string.Join(Environment.NewLine, WorkerResults.Select(x => $" • {x}").ToArray());
            long actionsCount = WorkerResults.Count == 0 ? 0 : WorkerResults.Sum(x => x.TotalCount);
            return $"Total Actions: {actionsCount:n0} in {TotalDuration.TotalSeconds:n2} seconds{Environment.NewLine}{r}";
        }
    }

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

        public double StdDevDuration => GetStdDev(TotalCount, TotalDuration, TotalDurationSquared);

        // std_dev = math.sqrt((s0 * s2 - s1 * s1) / (s0 * (s0 - 1)))
        internal static double GetStdDev(long s0, double s1, double s2)
        {
            return s0 <= 1
                ? 0
                : Math.Sqrt((s0 * s2 - s1 * s1) / (s0 * (s0 - 1)));
        }


        public override string ToString()
        {
            var stdevString = TotalCount > 2 ? $" ± {1000 * StdDevDuration:n3}" : "";
            var avgString = TotalCount == 0 ? "" : $" (avg = {(1000*TotalDuration / TotalCount):n2}{stdevString})";
            var cpuPercents = 100d * TotalCpuUsage.TotalMicroSeconds / TotalDuration / 1000000;
            var type = $"Type: {WorkerType.Name}";
            return $"«{WorkerTitle}» * {TotalCount:n0}{avgString} ➛ CPU {cpuPercents:n2}% {TotalCpuUsage}, Errors: {UpdateActionErrors.Count:n0}";
        }
    }
}
