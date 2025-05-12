using System;
using AssemblyPublicApiReporter;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class ShowAPI : NUnitTestsBase
    {
        [Test]
        public void Show_All()
        {
            string x = PublicApiReporter.GenerateReport(typeof(SqlServerManagement).Assembly);
            Console.WriteLine(x);
        }

        [Test]
        public void Show_Core_Only()
        {
            Type[] types = new Type[]
            {
                typeof(SqlServerManagement),
                typeof(ServerConfigurationSettingsManager),
                typeof(DatabaseOptionsManagement),
            };
            string x = PublicApiReporter.GenerateReport(types);
            Console.WriteLine(x);
        }

    }
}