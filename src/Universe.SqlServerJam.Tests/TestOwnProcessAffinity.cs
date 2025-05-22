using System;
using System.Diagnostics;
using System.Text;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests;

[TestFixture]
public class TestOwnProcessAffinity : NUnitTestsBase
{
    [Test]
    public void TestOnAllCores()
    {
        long originalAffinity = (long)Process.GetCurrentProcess().ProcessorAffinity;
        Console.WriteLine($"Current: {FormatAffinity(originalAffinity)}, {originalAffinity:X8}");

        var newA = 1;
        for (int c = 1; c <= Environment.ProcessorCount; c++)
        {
            Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(newA);
            long a = (long)Process.GetCurrentProcess().ProcessorAffinity;
            Console.WriteLine($"Set {newA:x8}: {FormatAffinity(a)}, {a:X8}");
            newA = newA << 1;
        }


    }

    static string FormatAffinity(long affinity)
    {
        StringBuilder ret = new StringBuilder();
        var procCount = Math.Min(64, Environment.ProcessorCount);
        int maxIndex = (procCount % 4 == 0) ? procCount : ((procCount + 3) / 4);
        for (int i = 0; i < maxIndex; i++)
        {
            bool bit = (affinity & 1) != 0;
            affinity >>= 1;
            ret.Append(bit ? '#' : '-');
            if (i > 0 && i < maxIndex - 1 && i % 4 == 3) ret.Append(' ');
        }

        return ret.ToString();
    }
}