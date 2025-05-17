using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using Dapper;
using NUnit.Framework;
using Universe.NUnitTests;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestPageVerifyMode : NUnitTestsBase
    {
        [Test]
        [TestCaseSource(typeof(TestEnvironment), nameof(TestEnvironment.GetEnabledServers))]
        public void TestAllVerifyModes(SqlServerRef testCase)
        {
            if (!testCase.CanSimplyCreateDatabase()) return;
            if (!testCase.IsNotAzure()) return;

            string newDbName = $"Test of DB Page Verify {Guid.NewGuid():N}";
            var conMaster = testCase.CreateConnection();
            conMaster.Execute($"Create Database [{newDbName}]", commandTimeout: 90);
            var serverMan = conMaster.Manage();
            var dbMan = serverMan.Databases[newDbName];

            try
            {
                var verifyModes = new[]
                {
                    DatabasePageVerify.None, 
                    DatabasePageVerify.Checksum, 
                    DatabasePageVerify.TornPageDetection, 
                    DatabasePageVerify.Checksum, 
                    DatabasePageVerify.None,
                    DatabasePageVerify.TornPageDetection,
                    DatabasePageVerify.None,
                };



                Console.WriteLine($"Initial PageVerify = {dbMan.PageVerify}");
                if (!testCase.IsNotAzure()) return;

                foreach (var verifyMode in verifyModes)
                {
                    Console.WriteLine($"UPDATING PAGE VERIFY MODE as [{verifyMode}]");
                    dbMan.PageVerify = verifyMode;
                    var actual = dbMan.PageVerify;
                    Console.WriteLine($"UPDATED PAGE VERIFY MODE '{actual}'");
                    Assert.That(actual, Is.EqualTo(verifyMode));
                    Console.WriteLine("");
                }
            }
            finally
            {
                ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
            }

            Assert.That(testCase.Manage().IsDbExists(newDbName), Is.False);
        }


    }
}