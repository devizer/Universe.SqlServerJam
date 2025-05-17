using System;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestCollations : NUnitTestsBase
    {
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void Has_Tons_of_Collations(SqlServerRef testCase)
        {
            // SqlConnection con = new SqlConnection(testCase.ConnectionString);
            var con = testCase.CreateConnection(pooling: true, timeout: 60);
            var allCollations = con.Manage().FindCollations();
            Console.WriteLine($"Found Collations Count = {allCollations.Count}");
            // Assert.GreaterOrEqual(allCollations.Count, 42);
            Assert.That(allCollations.Count, Is.GreaterThanOrEqualTo(42));
        }

        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void Has_Latin1_Collations(SqlServerRef testCase)
        {
            var con = testCase.CreateConnection(pooling: true, timeout: 60);
            var allCollations = con.Manage().FindCollations("%Latin1%");
            Console.WriteLine($"Found Collations Count = {allCollations.Count}");
            Console.WriteLine(string.Join(Environment.NewLine, allCollations.ToArray()));

            // Assert.GreaterOrEqual(allCollations.Count, 1);
            Assert.That(allCollations.Count, Is.GreaterThanOrEqualTo(1));
        }

        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void May_Have_Latin1_UTF8_Collations(SqlServerRef testCase)
        {
            var con = testCase.CreateConnection(pooling: true, timeout: 60);
            var foundUtfCollations = con.Manage().FindCollations("%Latin1%UTF%");
            Console.WriteLine($"Found Collations Count = {foundUtfCollations.Count}");
            Console.WriteLine(string.Join(Environment.NewLine, foundUtfCollations.ToArray()));

            var major = con.Manage().ShortServerVersion.Major;
            // SQL Server 2019 and above?
            if (major >= 15)
                // SQL Server 2019 and 2022 does have UTF8 collation
                Assert.That(foundUtfCollations.Count, Is.GreaterThanOrEqualTo(1));
            else
                // Does not have UTF8 collation
                Assert.That(foundUtfCollations.Count, Is.Zero);
        }

        // 
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void Hash_Latin1_General_CI_AS_Collations(SqlServerRef testCase)
        {
            var con = testCase.CreateConnection(pooling: true, timeout: 60);
            var none = "No Such Collation";
            for (int n = 0; n <= 4; n++)
            {
                var arg = new[] { "Latin1_General_CI_AS" }.Concat(Enumerable.Repeat(none, n));
                if (n == 4) arg = arg.Concat(new [] { "% No Such Collation %"});
                // arg = arg.ToArray();
                Console.WriteLine($"ARG: [{string.Join(";", arg.ToArray())}]");
                var allCollations = con.Manage().FindCollations(arg);
                Console.WriteLine($"Found Collations Count = {allCollations.Count}");
                Console.WriteLine(string.Join(Environment.NewLine, allCollations.ToArray()));
                // Assert.AreEqual(1, allCollations.Count);
                Assert.That(allCollations.Count, Is.EqualTo(1));
            }
        }
    }
}
