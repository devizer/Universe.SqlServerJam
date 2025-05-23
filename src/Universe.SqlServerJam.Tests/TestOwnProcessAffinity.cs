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
        Console.WriteLine($"Current: {FormatAppAffinityMask(originalAffinity)}, {originalAffinity:X16}");

        var newA = 1;
        for (int c = 1; c <= Environment.ProcessorCount; c++)
        {
            Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(newA);
            long a = (long)Process.GetCurrentProcess().ProcessorAffinity;
            Console.WriteLine($"Set {newA:x8}: {FormatAppAffinityMask(a)}, {a:X6}");
            newA <<= 1;
        }

        Process.GetCurrentProcess().ProcessorAffinity = new IntPtr(originalAffinity);
    }

    static string FormatAppAffinityMask(long affinityMask) =>
        AffinityMask.FormatAffinity(Environment.ProcessorCount, affinityMask);

}