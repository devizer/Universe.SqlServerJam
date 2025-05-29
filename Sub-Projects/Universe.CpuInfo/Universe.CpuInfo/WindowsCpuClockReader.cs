using System.Diagnostics;
using System.Management;

namespace Universe.CpuInfo;

public class WindowsCpuClockReader
{
    private class State
    {
        internal double MaxClockSpeed;
        internal PerformanceCounter ProcessorPerformance;
    }

    private Lazy<State> _TheState;

    public static WindowsCpuClockReader Default = new WindowsCpuClockReader();

    public WindowsCpuClockReader()
    {
        ResetState();
    }

    private void ResetState()
    {
        if (_TheState?.IsValueCreated == true)
        {
            try
            {
                _TheState.Value.ProcessorPerformance?.Dispose();
            }
            catch
            {
            }
        }

        _TheState = new Lazy<State>(() =>
        {
            // Console.WriteLine($"VER: {typeof(PerformanceCounter).Assembly.GetName().Version}");
            var processorPerformance = new PerformanceCounter("Processor Information", "% Processor Performance", "_Total", true);
            processorPerformance.NextValue();
            return new State()
            {
                MaxClockSpeed = GetMaxClockSpeed(),
                ProcessorPerformance = processorPerformance
            };
        });
    }

    // Returns null on non-windows or not supported
    public ClockSpeed GetSpeed()
    {
        if (!TinyCrossInfo.IsWindows) return null!;
        for (int i = 1; i <= 2; i++) // paranoiac retry pattern
        {
            try
            {
                var state = _TheState.Value;
                double maxClockSpeed = state.MaxClockSpeed;
                PerformanceCounter cpuCounter = state.ProcessorPerformance;
                float processorPerformancePerCents = cpuCounter.NextValue();

                double clockSpeed = processorPerformancePerCents * maxClockSpeed / 100;
                var ret = new ClockSpeed()
                {
                    Current = (int)Math.Round(clockSpeed),
                    Max = (int)Math.Round(maxClockSpeed),
                };

                return ret;
            }
            catch
            {
                // Never goes here
                // TODO: For testing on Hibernation/Sleep
                ResetState();
            }
        }

        return null!;
    }

    double GetMaxClockSpeed()
    {
        foreach (ManagementObject obj in new ManagementObjectSearcher("SELECT MaxClockSpeed FROM Win32_Processor").Get())
        {
            double maxSpeed = Convert.ToDouble(obj["MaxClockSpeed"]) / 1d;
            return maxSpeed;
        }

        return 0;
    }
}