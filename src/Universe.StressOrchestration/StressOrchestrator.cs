using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using Universe.CpuUsage;

namespace Universe.StressOrchestration;

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

    public void AddAsyncWorker(string title, IAsyncStressAction worker)
    {
        Workers.Add(new TitledWorker() { Group = title, Title = title, AsyncWorker = worker });
    }

    public void AddWorkers(string group, int workersCount, IStressAction worker)
    {
        for (int i = 1; i <= workersCount; i++)
        {
            Workers.Add(new TitledWorker() { Group = group, Title = FormatWorkerIndex(group, workersCount, i), Worker = worker });
        }
    }
    public void AddAsyncWorkers(string group, int workersCount, IAsyncStressAction worker)
    {
        for (int i = 1; i <= workersCount; i++)
        {
            Workers.Add(new TitledWorker() { Group = group, Title = FormatWorkerIndex(group, workersCount, i), AsyncWorker = worker });
        }
    }

    static string FormatWorkerIndex(string groupName, int count, int index)
    {
        int formatLength = count.ToString("0").Length;
        return groupName + " " + index.ToString("0").PadLeft(formatLength, ' ');
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
            Func<Task> asyncThreadBody = async () =>
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
                var theAsyncWorker = titledWorker.AsyncWorker;
                var theSyncWorker = titledWorker.Worker;
                countdownStart.Signal();
                countdownStart.Wait();
                Interlocked.CompareExchange(ref countdownStartedAt, Stopwatch.StartNew(), null);
                Stopwatch workerStartedAt = Stopwatch.StartNew();
                do
                {
                    Stopwatch actStartedAt = Stopwatch.StartNew();
                    try
                    {
                        if (theAsyncWorker != null)
                        {
                            await theAsyncWorker.ActAsync();
                        }
                        else if (theSyncWorker != null)
                        {
                            theSyncWorker.Act();
                        }
                        else
                        {
                            throw new InvalidOperationException($"Worker '{titledWorker.Title}' is not supplied by Worker or AsyncWorker");
                        }
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
                // Console.WriteLine($"[DEBUG] Worker '{titledWorker.Title}'{Environment.NewLine}  - SYNC CPU USAGE {syncCpuUsage}{Environment.NewLine}  - A-SYNC Cpu Usage {asyncCpuUsage}");
                workerResults.TotalCount = totalCount;
                workerResults.TotalDuration = workerTotalDuration;
                workerResults.TotalDurationSquared = workerTotalDurationSecondsSquared;
                workerResults.TotalCpuUsage = totalCpuUsage;
                lock (ret) ret.WorkerResults.Add(workerResults);
            }; // end of async thread body

            var thread = new Thread(() =>
            {
                asyncThreadBody().ConfigureAwait(false).GetAwaiter().GetResult();
            });

            thread.IsBackground = true;
            thread.Start();
            threads.Add(thread);
        }

        foreach (var thread in threads) thread.Join();
        countdownStart.Dispose();

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