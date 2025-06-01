// See https://aka.ms/new-console-template for more information

using System.Diagnostics;
using System.Runtime.InteropServices;
using Universe.CpuInfo;


if (!RuntimeInformation.IsOSPlatform(OSPlatform.Windows))
{
    Console.WriteLine("CPU Frequency for Windows Only");
    return;
}

var noDelay = args.Contains("--no-delay", StringComparer.OrdinalIgnoreCase);

Console.WriteLine("CPU Frequency for Windows");
var errors = 0;
Stopwatch startAt = Stopwatch.StartNew();
int? min = null, max = null;
while (true)
{
    var speed = WindowsCpuClockReader.Default.GetSpeed();
    errors += speed == null ? 1 : 0;
    if (speed != null && speed.Current > 0) min = min == null ? speed.Current : Math.Min(min.Value, speed.Current);
    if (speed != null && speed.Current > 0) max = max == null ? speed.Current : Math.Max(max.Value, speed.Current);
    Console.Write($"{startAt.Elapsed.ToString(@"hh\:mm\:ss")}  {speed}  MIN={min:n0}  MAX={max:n0}  error(s)={errors}  \r");
    if (!noDelay) Thread.Sleep(1);
}

