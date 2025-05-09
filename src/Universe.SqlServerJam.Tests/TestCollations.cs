using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestCollations
    {
        [Test]
        [TestCaseSource(nameof(GetAliveServers))]
        public void Has_Tons_of_Collations(SqlServerRef testCase)
        {
            SqlConnection con = new SqlConnection(testCase.ConnectionString);
            var allCollations = con.Manage().FindCollations();
            Console.WriteLine($"Found Collations Count = {allCollations.Count}");
            Assert.GreaterOrEqual(allCollations.Count, 42);
        }

        [Test]
        [TestCaseSource(nameof(GetAliveServers))]
        public void Has_Latin1_Collations(SqlServerRef testCase)
        {
            SqlConnection con = new SqlConnection(testCase.ConnectionString);
            var allCollations = con.Manage().FindCollations("%Latin1%");
            Console.WriteLine($"Found Collations Count = {allCollations.Count}");
            Console.WriteLine(string.Join(Environment.NewLine, allCollations.ToArray()));

            Assert.GreaterOrEqual(allCollations.Count, 1);
        }

        [Test]
        [TestCaseSource(nameof(GetAliveServers))]
        public void May_Have_Latin1_UTF8_Collations(SqlServerRef testCase)
        {
            SqlConnection con = new SqlConnection(testCase.ConnectionString);
            var allCollations = con.Manage().FindCollations("%Latin1%UTF%");
            Console.WriteLine($"Found Collations Count = {allCollations.Count}");
            Console.WriteLine(string.Join(Environment.NewLine, allCollations.ToArray()));

            var major = con.Manage().ShortServerVersion.Major;
            if (major >= 15)
                Assert.GreaterOrEqual(allCollations.Count, 1);
            else 
                Assert.AreEqual(0, allCollations.Count);
        }

        // 
        [Test]
        [TestCaseSource(nameof(GetAliveServers))]
        public void Hash_Latin1_General_CI_AS_Collations(SqlServerRef testCase)
        {
            SqlConnection con = new SqlConnection(testCase.ConnectionString);
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
                Assert.AreEqual(1, allCollations.Count);
            }
        }


        static List<SqlServerRef> GetAliveServers()
        {
            return TestEnvironment.SqlServers
                .OrderByVersionDesc()
                .Where(x => x.ServiceStartup != LocalServiceStartup.Disabled)
                .ToList();
        }

    }
}
