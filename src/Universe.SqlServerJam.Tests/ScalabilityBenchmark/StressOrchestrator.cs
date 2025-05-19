using System;
using System.Collections;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using Universe.CpuUsage;

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
        public bool NeedCpuUsage { get; set; }

        public StressOrchestrator()
        {
        }

        public void AddWorker(string title, IStressAction worker)
        {
            Workers.Add(new TitledWorker() { Title = title, Worker = worker});
        }

        public TotalStressResult Run()
        {
            TotalStressResult ret = new TotalStressResult();

            List<Thread> threads = new List<Thread>();
            Stopwatch stressStartedAt = Stopwatch.StartNew();
            CountdownEvent countdownStart = new CountdownEvent(Workers.Count);
            foreach (var titledWorker in Workers)
            {
                var thread = new Thread(() =>
                {
                    WorkerStressResults workerResults = new WorkerStressResults()
                    {
                        WorkerType = titledWorker.Worker.GetType(),
                        WorkerTitle = titledWorker.Title
                    };

                    long totalCount = 0;
                    CpuUsage.CpuUsage? syncCpuUsageOnStart = CpuUsage.CpuUsage.GetByThread();
                    CpuUsageAsyncWatcher cpuUsageWatcher = new CpuUsageAsyncWatcher();
                    double workerTotalDurationSeconds = 0;
                    double workerTotalDurationSecondsSquared = 0;
                    countdownStart.Signal();
                    countdownStart.Wait();
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
                    workerResults.TotalCpuUsage = totalCpuUsage;

                    // std_dev = math.sqrt((s0 * s2 - s1 * s1) / (s0 * (s0 - 1)))
                    workerResults.StdDevDuration =
                        totalCount <= 1
                            ? 0
                            : Math.Sqrt((totalCount * workerTotalDurationSecondsSquared - workerTotalDurationSeconds * workerTotalDurationSeconds) / (totalCount * (totalCount - 1)));

                    lock (ret) ret.WorkerResults.Add(workerResults);
                });
                thread.IsBackground = true;
                thread.Start();
                threads.Add(thread);
            }

            foreach (var thread in threads) thread.Join();

            ret.TotalDuration = stressStartedAt.Elapsed;
            ret.WorkerResults = ret.WorkerResults.OrderBy(x => x.WorkerTitle).ToList();
            return ret;
        }

        public class TitledWorker
        {
            public IStressAction Worker { get; set; }
            public string Title { get; set; }
        }
    }

    public class TotalStressResult
    {
        public TimeSpan TotalDuration { get; set; } // Includes wait on countdown
        public List<WorkerStressResults> WorkerResults { get; internal set; } = new List<WorkerStressResults>();

        public override string ToString()
        {
            var r = string.Join(Environment.NewLine, WorkerResults.Select(x => $" • {x}").ToArray());
            long actionsCount = WorkerResults.Count == 0 ? 0 : WorkerResults.Sum(x => x.TotalCount);
            return $"Total Actions: {actionsCount:n0} in {TotalDuration.TotalSeconds:n2} seconds{Environment.NewLine}{r}";
        }
    }

    public class WorkerStressResults
    {
        public Type WorkerType { get; set; }
        public string WorkerTitle { get; set; }
        public double StdDevDuration { get; set; }
        public double TotalDuration { get; set; }
        public CpuUsage.CpuUsage TotalCpuUsage { get; set; }
        public long TotalCount { get; set; }
        public List<Exception> UpdateActionErrors { get; } = new List<Exception>();

        public override string ToString()
        {
            var avgString = TotalCount == 0 ? "" : $" Avg = {(1000*TotalDuration / TotalCount):n2} ± {1000*StdDevDuration:n3}";
            var cpuPercents = 100d * TotalCpuUsage.TotalMicroSeconds / TotalDuration / 1000000;
            return $"«{WorkerTitle}» * {TotalCount:n0}{avgString} ➛ CPU {cpuPercents:n2}% {TotalCpuUsage}, {nameof(UpdateActionErrors)}: {UpdateActionErrors.Count:n0}, Type: {WorkerType.Name}";
        }
    }
}
