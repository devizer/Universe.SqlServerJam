using System;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests;

[TestFixture]
public class TestAffinityInLoop : NUnitTestsBase
{
    [Test]
    [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
    public void TestAllCpuCores(SqlServerRef testCase)
    {
        if (!testCase.IsNotAzure()) return; // SQL Azure FREE TIER (2 cores) is not supported. Always return 0 (all cores)


        var conMaster = testCase.CreateConnection();
        var manager = conMaster.Manage();
        if (manager.LongServerVersion.IndexOf("Express", StringComparison.OrdinalIgnoreCase) >= 0) return;

        var cpuCount = manager.CpuCount;
        Console.WriteLine($"CPU COUNT IS {cpuCount}");
        try
        {
            for (int i = 1; i <= cpuCount; i++)
            {
                Console.WriteLine($"Setting AffinityCount={i} of {cpuCount}");
                manager.Configuration.AffinityCount = (short)i;
                var actualCount = manager.Configuration.AffinityCount;
                // Console.WriteLine($"Set AffinityCount={i} of {cpuCount}") Stored value = [{actualCount}]");
                Console.WriteLine($"Stored Count=[{actualCount}] Mask=[{manager.Configuration.AffinityMask}]");
                var expectedCount = i;
                Assert.That(actualCount, Is.EqualTo(expectedCount));
                Console.WriteLine("--------------------");
            }
        }
        finally
        {
            manager.Configuration.AffinityMask = 0L;
        }
    }
}