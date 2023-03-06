#if !NETSTANDARD1_3
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Win32;

namespace Universe.SqlServerJam
{
    public static class SqlDiscovery
    {

        public static List<SqlServerRef> GetLocalDbAndServerList()
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            ret.AddRange(GetServerList());
            ret.AddRange(GetLocalDbList());
            ret.AddRange(GetWellKnownServers());

            return ret;
        }

        public static List<SqlServerRef> GetWellKnownServers(string envPrefix = "SQLSERVER_WELLKNOWN_")
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            if (string.IsNullOrEmpty(envPrefix))
                envPrefix = "SQLSERVER_WELLKNOWN_";

            IDictionary allVars = Environment.GetEnvironmentVariables();
            foreach (object varRaw in allVars.Keys)
            {
                var var = varRaw.ToString();
                if (var.StartsWith(envPrefix))
                {
                    var value = Convert.ToString(allVars[var]);
                    if (string.IsNullOrEmpty(value)) continue;
                    ret.Add(new SqlServerRef()
                    {
                        Kind = SqlServerDiscoverySource.WellKnown,
                        Data = value,
                    });
                }
            }

            return ret;
        }

        // Always returns latest version only
        public static List<SqlServerRef> GetLocalDbList()
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            if (!TinyCrossInfo.IsWindows) return ret;
            using (RegistryKey lm = Registry.LocalMachine)
            {
                // default instance
                using (RegistryKey keyInstalledVersions = lm.OpenSubKey(@"SOFTWARE\Microsoft\Microsoft SQL Server Local DB\Installed Versions", false))
                {
                    if (keyInstalledVersions != null)
                        foreach (var subKeyName in keyInstalledVersions.GetSubKeyNames())
                        {
                            using (RegistryKey keyVersion = keyInstalledVersions.OpenSubKey(subKeyName))
                            {
                                if (keyVersion == null) continue;
                                try
                                {
                                    var version = new Version(subKeyName);
                                    var instance = version.Major == 11
                                        ? "(LocalDB)\\v11.0"
                                        : "(LocalDB)\\MSSqlLocalDB";

                                    ret.Add(new SqlServerRef()
                                    {
                                        Kind = SqlServerDiscoverySource.LocalDB,
                                        Data = instance,
                                        Version = version,
                                    });
                                }
                                catch
                                {
                                    // a subkey in the keyInstalledVersions
                                    // isn't a valid Version string.
                                }

                            }
                        }
                }
            }

            // ignore all the found!!!
            if (ret.Count > 0)
            {
                var top = ret.OrderByVersionDesc().FirstOrDefault();
                ret.Clear();
                ret.Add(top);
            }

            return ret;
        }

        public static List<SqlServerRef> GetServerList()
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            if (!TinyCrossInfo.IsWindows) return ret;
            using (RegistryKey lm = Registry.LocalMachine)
            {
                // default instance
                using (RegistryKey k0 = lm.OpenSubKey(@"SOFTWARE\Microsoft\MSSQLServer"))
                    if (k0 != null)
                        TryKey(k0, ret, string.Empty);

                // named instances
                using (RegistryKey k1 = lm.OpenSubKey(@"SOFTWARE\Microsoft\Microsoft SQL Server", false))
                    if (k1 != null)
                        foreach (string subKeyName in new List<string>(k1.GetSubKeyNames() ?? new string[0]))
                            using (RegistryKey candidate = k1.OpenSubKey(subKeyName))
                                if (candidate != null)
                                    TryKey(candidate, ret, subKeyName);
            }

            return ret;
        }



        private static void TryKey(RegistryKey k1, List<SqlServerRef> ret, string instanceName)
        {
            string rawVersion = null;
            using (RegistryKey rk = k1.OpenSubKey(@"MSSQLServer\CurrentVersion", false))
                if (rk != null)
                    rawVersion = rk.GetValue("CurrentVersion") as string;

            string serviceKey = string.IsNullOrEmpty(instanceName) ? "MSSQLSERVER" : "MSSQL$" + instanceName;
            using (RegistryKey key = Registry.LocalMachine.OpenSubKey(@"SYSTEM\CurrentControlSet\Services\" + serviceKey, false))
            {
                if (key == null)
                    return;
            }

            if (!string.IsNullOrEmpty(rawVersion) /* && rawPath != null && Directory.Exists(rawPath) */)
            {
                try
                {
                    Version ver = new Version(rawVersion);
                    string name = instanceName.Length == 0 ? "(local)" : ("(local)" + "\\" + instanceName);
                    ret.Add(new SqlServerRef()
                    {
                        Kind = SqlServerDiscoverySource.Local,
                        Data = name,
                        Version = ver,
                    });
                }
                catch
                {
                }
            }
        }

        public static IEnumerable<SqlServerRef> OrderByVersionDesc(this IEnumerable<SqlServerRef> list)
        {
            return list
                .OrderByDescending(x => x.Version == null ? new Version(0, 0, 0) : x.Version)
                .ThenByDescending(x => x.Data);
        }

        public static string AsBullets(this IEnumerable<SqlServerRef> list)
        {
            var sorted = OrderByVersionDesc(list);
            IEnumerable<string> strs = sorted.Select(x => " * " + x.DataSource + (x.Version == null ? "" : $" ({x.Version})"));
            return strs.JoinIntoString(Environment.NewLine); 
        }
    }


}
#endif