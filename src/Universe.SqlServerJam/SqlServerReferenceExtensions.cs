﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace Universe.SqlServerJam
{
    public static class SqlServerReferenceExtensions
    {
        public static string AsBullets(this IEnumerable<SqlServerRef> list)
        {
            var sorted = OrderByVersionDesc(list);
            IEnumerable<string> strs = sorted.Select(x => " * " + x.DataSource + (x.InstallerVersion == null ? "" : $" ({x.InstallerVersion})") + (x.ServiceStartup != LocalServiceStartup.Unknown ? $", {x.ServiceStartup}" : ""));
            return strs.JoinIntoString(Environment.NewLine);
        }

        public static IEnumerable<SqlServerRef> OrderByVersionDesc(this IEnumerable<SqlServerRef> list)
        {
            return list
                .OrderByDescending(x => x.InstallerVersion == null ? new Version(0, 0, 0) : x.InstallerVersion)
                .ThenByDescending(x => x.Kind == SqlServerDiscoverySource.LocalDB ? 0 : 1)
                .ThenByDescending(x => x.Data);
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
                    var shortServerVersion = con.Manage().GetShortServerVersion(5);
                    sqlServerRef.Version = shortServerVersion;
                    if (sqlServerRef.InstallerVersion == null) sqlServerRef.InstallerVersion = shortServerVersion;
                    return shortServerVersion;
                }
                catch(Exception ex)
                {
                    var s = ex.ToString();
                }

            } while(startAt.Elapsed < timeout);

            return null;
        }

        // Return true if action taken
        public static bool StartLocalIfStopped(this SqlServerRef sqlServerRef)
        {
            if (sqlServerRef.Kind == SqlServerDiscoverySource.Local)
            {
                SqlServiceStatus serviceStatus = SqlServiceExtentions.CheckLocalServiceStatus(sqlServerRef.DataSource);
                // Console.WriteLine($"[DEBUG] «{sqlServerRef}» Current Service status is '{serviceStatus?.State}'");
                if (serviceStatus?.State != SqlServiceStatus.ServiceStatus.Running)
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
