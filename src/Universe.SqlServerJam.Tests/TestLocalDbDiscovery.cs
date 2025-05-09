﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;

namespace Universe.SqlServerJam.Tests
{
    [TestFixture]
    public class TestLocalDbDiscovery
    {
        public TestLocalDbDiscovery()
        {
            SqlLocalDbDiscovery.EnableDebugLog = true;
        }

        [Test]
        [TestCase("First")]
        [TestCase("Next")]
        public void Test1_Show_Versions(string idRunner)
        {
            var versions = SqlLocalDbDiscovery.GetVersionList();
            foreach (var v in versions)
            {
                Console.WriteLine($"{v.ShortVersion} {v.InstallerVersion,-15} {v.ParentInstance} {v.Exe}");
            }
        }

        [Test]
        [TestCase("First")]
        [TestCase("Next")]
        public void Test1_Show_Instances(string idRunner)
        {
            var instances = SqlLocalDbDiscovery.GetInstances();
            foreach (var v in instances)
            {
                Console.WriteLine($"{v.Kind} {v.InstallerVersion}:  {v.Data}");
            }
        }

        [Test]
        public void Z_Log()
        {
            Console.WriteLine(SqlLocalDbDiscovery.Log);
        }

    }
}
