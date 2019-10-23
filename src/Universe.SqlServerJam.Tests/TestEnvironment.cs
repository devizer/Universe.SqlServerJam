using System;
using System.Collections.Generic;
using System.Linq;
using System.Security;
using System.Text;
[assembly: SecurityRules(SecurityRuleSet.Level1, SkipVerificationInFullTrust = true)]

namespace Universe.SqlServerJam.Tests
{
    class TestEnvironment
    {
        public static int SqlPingDuration => GetVar("Ping");
        public static int SqlUploadDuration => GetVar("Upload");
        public static int SqlDownloadDuration => GetVar("Download");

        static int GetVar(string varSuffix)
        {
            var v = Environment.GetEnvironmentVariable("TEST_SQL_NET_DURATION_OF_" + varSuffix);
            int ret;
            if (v != null && int.TryParse(v, out ret))
                return ret;

            return 100;
        }

    }
}


