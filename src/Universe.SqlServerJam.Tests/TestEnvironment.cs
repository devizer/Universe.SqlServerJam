using System;
using System.IO;
using System.IO.Compression;
using System.Security;
using System.Threading;
#if NET40
[assembly: SecurityRules(SecurityRuleSet.Level1, SkipVerificationInFullTrust = true)] 
#endif

namespace Universe.SqlServerJam.Tests
{
    class TestEnvironment
    {
        public static int SqlPingDuration => GetVar("Ping");
        public static int SqlUploadDuration => GetVar("Upload");
        public static int SqlDownloadDuration => GetVar("Download");

        private static Lazy<string> _DbForTestsBak = new Lazy<string>(ExtractDbForTestsBak, LazyThreadSafetyMode.ExecutionAndPublication);
        public static string DbForTestsBak => _DbForTestsBak.Value;

        static int GetVar(string varSuffix)
        {
            var v = Environment.GetEnvironmentVariable("TEST_SQL_NET_DURATION_OF_" + varSuffix);
            int ret;
            if (v != null && int.TryParse(v, out ret))
                return ret;

            return 100;
        }

        static string ExtractDbForTestsBak()
        {
            string localPath = Path.Combine("Assets", "DB For Tests.bak.gz");
            string fullPath = Path.GetFullPath(localPath);
            var tmpFolderRoot = CrossInfo.ThePlatform == CrossInfo.Platform.Windows
                ? Environment.GetFolderPath(Environment.SpecialFolder.ApplicationData)
                : "/tmp/sql-backups";

            var tmpFile = Path.Combine(tmpFolderRoot, "Temp" + Path.DirectorySeparatorChar + "DB For Tests.bak");
            if (!Directory.Exists(Path.GetDirectoryName(tmpFile))) Directory.CreateDirectory(Path.GetDirectoryName(tmpFile));
            Console.WriteLine($"Extracting {fullPath} --> {tmpFile}");
            using(FileStream fs = new FileStream(fullPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
            using(GZipStream gzip = new GZipStream(fs, CompressionMode.Decompress, false))
            using (FileStream plain = new FileStream(tmpFile, FileMode.Create, FileAccess.Write, FileShare.ReadWrite))
            {
                gzip.CopyTo(plain);
            }

            return tmpFile;
        }
    }
}


