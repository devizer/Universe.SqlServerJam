using System;
using BenchmarkDotNet;
using BenchmarkDotNet.Attributes;

namespace Universe.CpuInfo.Benchmark
{
    public class Benchmarks
    {
        [Benchmark]
        public int CpuClockSpeed()
        {
            return (WindowsCpuClockReader.Default.GetSpeed()?.Current).GetValueOrDefault();
        }

    }
}
