using System;
using System.Collections.Generic;
using System.Linq;

namespace Universe.SqlServerJam
{
    public static class SqlServerReferenceExtensions
    {
        public static string AsBullets(this IEnumerable<SqlServerRef> list)
        {
            var sorted = OrderByVersionDesc(list);
            IEnumerable<string> strs = sorted.Select(x => " * " + x.DataSource + (x.Version == null ? "" : $" ({x.Version})"));
            return strs.JoinIntoString(Environment.NewLine);
        }

        public static IEnumerable<SqlServerRef> OrderByVersionDesc(this IEnumerable<SqlServerRef> list)
        {
            return list
                .OrderByDescending(x => x.Version == null ? new Version(0, 0, 0) : x.Version)
                .ThenByDescending(x => x.Kind == SqlServerDiscoverySource.LocalDB ? 0 : 1)
                .ThenByDescending(x => x.Data);
        }

        public static bool StartLocalIfStoppedAndWarmUp(this SqlServerRef sqlServerRef, int timeout = 30)
        {
            return false;
        }

    }
}
