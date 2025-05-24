using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

[TestFixture]
internal class TestStressPlans
{
    [Test]
    [TestCaseSource(typeof(StressCaseSource), nameof(StressCaseSource.Get))]
    public void Test1(StressCaseSource src)
    {
        StressPlanBuilder stressPlanBuilder = new StressPlanBuilder()
        {
            IsLocalServer = true,
            AppProcessorCount = src.TotalCores,
            SqlProcessorCount = src.TotalCores,
            Workers = new string[] { "Dashboard", "Merging" }
        };

        var ret = stressPlanBuilder.GetStressCases();
        Console.WriteLine(ret.Format());

    }
}