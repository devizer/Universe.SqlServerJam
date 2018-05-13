using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

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
            if (v != null && int.TryParse(v, out var ret))
                return ret;

            return 100;
        }
    }
}


