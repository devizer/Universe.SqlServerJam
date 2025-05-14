using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Data.Common;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Universe.SqlServerJam
{
    public static class SqlServerReferenceExtensions
    {
        public static string AsBullets(this IEnumerable<SqlServerRef> list)
        {
            var sorted = OrderByVersionDesc(list);
            IEnumerable<string> strs = sorted.Select(x =>
            {
                var ver = x.Version ?? x.InstallerVersion;
                return " * " + x.DataSource + (ver == null ? "" : $" ({ver})") + (x.ServiceStartup != LocalServiceStartup.Unknown ? $", {x.ServiceStartup}" : "");
            });
            return strs.JoinIntoString(Environment.NewLine);
        }

        public static IEnumerable<SqlServerRef> OrderByVersionDesc(this IEnumerable<SqlServerRef> list)
        {
            return list.ToArray()
                .OrderByDescending(x => x.InstallerVersion == null ? new Version(0, 0, 0) : x.InstallerVersion)
                .ThenByDescending(x => x.Kind == SqlServerDiscoverySource.LocalDB ? 0 : 1)
                .ThenByDescending(x => x.Data);
        }

        public static IEnumerable<SqlServerRef> WarmUp(this IEnumerable<SqlServerRef> sqlServerRefList, TimeSpan timeout = default(TimeSpan))
        {
            ConcurrentBag<SqlServerRef> ret = new ConcurrentBag<SqlServerRef>();
            Parallel.ForEach(sqlServerRefList.ToList(), sqlServerRef =>
            {
                var version = sqlServerRef.WarmUp(timeout);
                // Console.WriteLine($"[DEBUG] {Interlocked.Increment(ref count)} WarmUp: processed [{sqlServerRef}]");
                ret.Add(sqlServerRef);
            });
            return ret.ToArray();
        }

        public static DbConnection CreateConnection(this SqlServerRef sqlServerRef, bool? pooling = true, int? timeout = 30)
        {
            var cs1 = SqlServerJamConfigurationExtensions.ResetConnectionPooling(sqlServerRef.ConnectionString, pooling);
            var cs2 = SqlServerJamConfigurationExtensions.ResetConnectionTimeout(cs1, timeout);
            var con = SqlServerJamConfiguration.SqlProviderFactory.CreateConnection(cs2);
            return con;
        }

        public static SqlServerManagement Manage(this SqlServerRef sqlServerRef, bool? pooling = true, int? timeout = 30)
        {
            return CreateConnection(sqlServerRef, pooling, timeout).Manage();
        }

        public static Version WarmUp(this SqlServerRef sqlServerRef, TimeSpan timeout = default(TimeSpan))
        {
            if (sqlServerRef.ServiceStartup == LocalServiceStartup.Disabled) return null;
            Stopwatch startAt = Stopwatch.StartNew();
            if (timeout.Ticks == 0) timeout = TimeSpan.FromSeconds(30);
            do
            {
                var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
                b.ConnectionString = sqlServerRef.ConnectionString;
                b["Timeout"] = 4;
                b["Pooling"] = false;
                var cs = b.ConnectionString;

                try
                {
                    var con = SqlServerJamConfiguration.SqlProviderFactory.CreateConnection(cs);
                    var manager = con.Manage().UseCommandTimeout(4);
                    var version = manager.ProductVersion ?? manager.ShortServerVersion;
                    sqlServerRef.Version = version;
                    if (sqlServerRef.InstallerVersion == null) sqlServerRef.InstallerVersion = version;
                    return version;
                }
                catch(Exception ex)
                {
                    var s = ex.ToString();
                }

            } while(startAt.Elapsed < timeout);

            return null;
        }

        public static IEnumerable<SqlServerRef> StartLocalIfStopped(this IEnumerable<SqlServerRef> sqlServerRefList)
        {
            foreach (var sqlServerRef in sqlServerRefList.ToArray())
            {
                sqlServerRef.StartLocalIfStopped();
                yield return sqlServerRef;
            }
        }

        // Return true if action taken
        public static bool StartLocalIfStopped(this SqlServerRef sqlServerRef)
        {
            if (sqlServerRef.Kind == SqlServerDiscoverySource.Local)
            {
                SqlServiceStatus serviceStatus = SqlServiceExtentions.CheckLocalServiceStatus(sqlServerRef.DataSource);
                // Console.WriteLine($"[DEBUG] «{sqlServerRef}» Current Service status is '{serviceStatus?.State}'");
                if (serviceStatus?.State != SqlServiceStatus.ServiceState.Running)
                {
                    bool isStarted = SqlServiceExtentions.StartService(sqlServerRef.DataSource);
                    // Console.WriteLine($"[DEBUG] «{sqlServerRef}» Is Started: {isStarted}");
                    return isStarted;
                }

                return false;
            }

            else if (sqlServerRef.Kind == SqlServerDiscoverySource.LocalDB)
            {
                bool isStarted = SqlServiceExtentions.StartLocalDB(sqlServerRef.DataSource);
                return isStarted;
            }

            return false;
        }

    }
}
