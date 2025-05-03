using System;
using Microsoft.Win32;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;

namespace Universe.SqlServerJam
{
    // DONE: Exception of Exec and timeouts
    public static class SqlLocalDbDiscovery
    {
        private static int ExecInfoTimeout = 60*1000;

        public class LocalDbVersion
        {
            public string ShortVersion { get; set; }
            public string InstallerVersion { get; set; }
            public string ParentInstance { get; set; }
            public string Exe { get; set; }
        };

        public class LocalDBInstance
        {
            public string Name { get; set; }
            public string Version { get; set; }
            public string SharedName { get; set; }
            public string Owner { get; set; }
            public string PipeName { get; set; }
        }

        public static List<SqlServerRef> GetInstances()
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            Dictionary<string,object> added = new Dictionary<string,object>();
            foreach (var localDbVersion in GetVersionList())
            {
                IEnumerable<string> instanceNames;
                try
                {
                    instanceNames = ParseInstances(localDbVersion.Exe);
                }
                catch
                {
                    continue;
                }

                foreach (var instanceName in instanceNames)
                {
                    if (added.ContainsKey(instanceName)) continue;
                    var sqlServerRef = new SqlServerRef()
                    {
                        Kind = SqlServerDiscoverySource.LocalDB,
                        Data = $"(LocalDB)\\{instanceName}",
                    };

                    try
                    {
                        var localDbInfo = GetLocalDbInstanceInfo(localDbVersion.Exe, instanceName);
                        sqlServerRef.Version = TryParseVersion(localDbInfo.Version);
                    }
                    catch (Exception ex)
                    {
                        Debug.WriteLine($"Unable to get LocalDB Instance Version '{instanceName}' info{Environment.NewLine}{ex}");
                    }

                    ret.Add(sqlServerRef);
                    added[instanceName] = null;
                }
            }

            return ret;
        }

        // net 3.5 does not see "SOFTWARE\Microsoft\Microsoft SQL Server\MSSQL11E.LOCALDB", 12, 13, ...
        public static List<SqlLocalDbDiscovery.LocalDbVersion> GetVersionList()
        {
            List<SqlLocalDbDiscovery.LocalDbVersion> ret = new List<SqlLocalDbDiscovery.LocalDbVersion>();
            if (!TinyCrossInfo.IsWindows) return ret;
            using (RegistryKey lm = Registry.LocalMachine)
            {
                if (lm == null) return ret;

                var parentKeyPath = "SOFTWARE\\Microsoft\\Microsoft SQL Server Local DB\\Installed Versions";
                using (var parentKey = lm.OpenSubKey(parentKeyPath, false))
                {
                    var subNames = parentKey?.GetSubKeyNames();
                    if (subNames == null) return ret;
                    foreach (var subName in subNames)
                    {
                        var parentInstance = ReadRegValue(lm, $"{parentKeyPath}\\{subName}", "ParentInstance");
                        if (parentInstance == null) continue;

                        var version1 = ReadRegValue(lm, $"SOFTWARE\\Microsoft\\Microsoft SQL Server\\{parentInstance}\\Setup", "Version");
                        var version2 = ReadRegValue(lm, $"SOFTWARE\\Microsoft\\Microsoft SQL Server\\{parentInstance}\\MSSQLServer\\CurrentVersion", "CurrentVersion");
                        var version = version1 ?? version2;
                        if (version == null) continue;

                        var verInternal = subName.Replace(".", "");
                        var pathTools = ReadRegValue(lm, $"SOFTWARE\\Microsoft\\Microsoft SQL Server\\{verInternal}\\Tools\\ClientSetup", "Path");
                        if (pathTools == null) continue;
                        var exe = Path.Combine(pathTools, "SQLLocalDB.exe");
                        if (!File.Exists(exe)) continue;

                        ret.Add(new LocalDbVersion()
                        {
                            ShortVersion = subName,
                            InstallerVersion = version,
                            Exe = exe,
                            ParentInstance = parentInstance
                        });
                    }
                }
            }

            ret.Reverse();
            return ret;
        }

        static string ReadRegValue(RegistryKey lm, string lmPath, string keyName)
        {
#if NETSTANDARD2_0_OR_GREATER && false
            var arr = lmPath.Split('\\');
            for (int i = 0; i < arr.Length; i++)
            {
                string p = "";
                for(int j=0; j<=i;j++) p += (p=="" ? "" : "\\") + arr[j];
                var k = Registry.LocalMachine?.OpenSubKey(p, false);
                Console.WriteLine($"PATH '{p}' Exists: {k != null}");
            }
#endif
            using (var r = lm.OpenSubKey(lmPath, false))
            {
                if (r == null) return null;
                var value = r.GetValue(keyName);
                if (value == null) return null;
                return value.ToString();
            }
        }


        static IEnumerable<string> ParseInstances(string exe)
        {
            return ParseNonEmptyLines(TinyHiddenExec(exe, "i", ExecInfoTimeout));
        }

        static IEnumerable<string> ParseNonEmptyLines(string lines)
        {
            StringReader rdr = new StringReader(lines);
            string line = null;
            while ((line = rdr.ReadLine()) != null)
            {
                if (line.Length > 0) yield return line.Trim();
            }
        }

        static Version TryParseVersion(string v)
        {
            StringBuilder cleanVersion = new StringBuilder();
            foreach (var c in v)
            {
                if (c == '.' || (c >= '0' && c <= '9')) cleanVersion.Append(c);
            }

            try
            {
                return new Version(cleanVersion.ToString());
            }
            catch
            {
                return null;
            }
        }

        static LocalDBInstance GetLocalDbInstanceInfo(string exe, string instanceName)
        {
            var nonEmptyLines = ParseNonEmptyLines(TinyHiddenExec(exe, $"i \"{instanceName}\"", ExecInfoTimeout))
                .Where(x => x.IndexOf(":") > 1)
                .ToArray();

            string GetValue(string raw)
            {
                int p = raw.IndexOf(":");
                if (p < 0) return null;
                if (p == raw.Length - 1) return "";
                return raw.Substring(p + 1).Trim();
            }
            if (nonEmptyLines.Length >= 5)
            {
                var version = GetValue(nonEmptyLines[1]);
                var sharedName = GetValue(nonEmptyLines[2]);
                var owner = GetValue(nonEmptyLines[3]);
                var pipeName = GetValue(nonEmptyLines[nonEmptyLines.Length - 1]);
                if (version != null)
                    return new LocalDBInstance()
                    {
                        Name = instanceName,
                        Version = version,
                        Owner = owner,
                        PipeName = pipeName,
                        SharedName = sharedName,
                    };

            }

            return null;
        }

        static string TinyHiddenExec(string exe, string args, int timeout)
        {
            if (timeout == 0) timeout = 10*60*1000;
            ProcessStartInfo si = new ProcessStartInfo(exe, args)
            {
                CreateNoWindow = true,
                UseShellExecute = false,
                RedirectStandardOutput = true,
            };
            using (Process p = Process.Start(si))
            {
                bool isOk = p.WaitForExit(timeout);
                if (!isOk)
                    throw new Exception("Process timed out");

                var exitCode = p.ExitCode;
                if (exitCode != 0)
                    throw new Exception($"Process failed. Exit Code {exitCode}");

                var output = p.StandardOutput.ReadToEnd();
                output.TrimEnd('\r', '\n');
                return output;
            }
        }
    }
}
