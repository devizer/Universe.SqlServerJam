namespace Universe.CpuInfo;

public class ClockSpeed
{
    public int Current { get; internal set; }
    public int Max { get; internal set; }

    public override string ToString()
    {
        return $"CPU Speed: {Current:n0} of {Max:n0} MHz";
    }
}