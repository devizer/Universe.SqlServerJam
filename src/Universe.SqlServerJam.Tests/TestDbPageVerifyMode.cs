using System;
using System.CodeDom;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
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

            string newDbName = $"Test of DB Page Verify {Guid.NewGuid():N}";
            var conMaster = testCase.CreateConnection();
            conMaster.Execute($"Create Database [{newDbName}]");
            var dbMan = conMaster.Manage().Databases[newDbName];

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