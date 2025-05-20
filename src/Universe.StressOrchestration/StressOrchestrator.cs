using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using Universe.CpuUsage;

namespace Universe.StressOrchestration
{
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

        public void AddWorker(string title, IAsyncStressAction worker)
        {
            Workers.Add(new TitledWorker() { Group = title, Title = title, AsyncWorker = worker });
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
        public void AddAsyncWorkers(string group, int workersCount, IAsyncStressAction worker)
        {
            int formatLength = workersCount.ToString("0").Length;
            for (int i = 1; i <= workersCount; i++)
            {
                var title = group + " " + i.ToString("0").PadLeft(formatLength, ' ');
                Workers.Add(new TitledWorker() { Group = group, Title = title, AsyncWorker = worker });
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

        private class TitledWorker
        {
            public IAsyncStressAction AsyncWorker { get; set; }
            public IStressAction Worker { get; set; }
            public string Group { get; set; }
            public string Title { get; set; }
        }
    }
}
