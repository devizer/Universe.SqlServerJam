namespace Universe.CpuInfo;

public class CpuClockReader
{
    public static ClockSpeed GetClockSpeed()
    {
        // TODO: Add linux and mac os support
        return WindowsCpuClockReader.Default.GetSpeed();
    }
}