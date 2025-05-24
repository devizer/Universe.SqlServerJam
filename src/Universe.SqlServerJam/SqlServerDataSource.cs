#if !NETSTANDARD1_4 || true
using System;
using System.Linq;

namespace Universe.SqlServerJam
{
    // Only Local Service or LocalDB
    // TODO: Rename to SqlServerDataSource
    // Start, Stop, Restart, Check Startup Mode
    public class SqlServerDataSource
    {
        public string Original { get; set; }
        public bool IsLocalService { get; set; }
        public bool IsLocalDb { get; set; }

        public bool IsLocal => IsLocalDb || IsLocalService;

        // Not Null if IsLocalService
        public string ServiceName { get; set; }

        public string LocalDbInstance { get; set; }

        public override string ToString()
        {
            if (IsLocalDb)
                return $"LocalDb '{LocalDbInstance}'";

            if (IsLocalService)
                return $" Local Service '{ServiceName}'";

            return "Non-local or null service, e.g. neither SQL Server nor LocalDB";
        }

        public static SqlServerDataSource ParseConnectionString(string connectionString)
        {
            var dataSource = SqlServerJamConfigurationExtensions.GetDataSource(connectionString);
            return ParseDataSource(dataSource);
        }

        public static SqlServerDataSource ParseDataSource(string dataSource)
        {
            var arrWithProtocol = dataSource.Split(':');
            var instanceWithoutProtocol = arrWithProtocol.Last();
            var protocol = arrWithProtocol.Length >= 2 ? arrWithProtocol[0] : null; // null | lpc | tcp | np
            var hostWithPort = instanceWithoutProtocol.Split('\\').First();
            var host = hostWithPort.Split(',').First();

            // TODO: if Port or Protocol tcp or named pipe then NOT a LocalDB
            bool isLocalService =
                host.Equals("(local)", StringComparisonExtensions.IgnoreCase)
                || host.Equals(".", StringComparisonExtensions.IgnoreCase)
                || host.Equals("::1", StringComparisonExtensions.IgnoreCase)
                || host.Equals("127.0.0.1", StringComparisonExtensions.IgnoreCase)
                || host.Equals(EnvironmentExtensions.MachineName, StringComparisonExtensions.IgnoreCase);

            string instanceName =
                dataSource.IndexOf("\\", StringComparison.Ordinal) < 0
                    ? null
                    : dataSource.Split('\\').LastOrDefault();

            if (isLocalService)
            {
                var serviceName = instanceName == null ? "MSSQLSERVER" : $"MSSQL${instanceName}";
                return new SqlServerDataSource()
                {
                    IsLocalService = true,
                    IsLocalDb = false,
                    ServiceName = serviceName,
                    Original = dataSource
                };
            }

            bool isLocalDb = 
                host.StartsWith("(LocalDB)", StringComparisonExtensions.IgnoreCase)
                && dataSource.StartsWith("(LocalDB)\\", StringComparisonExtensions.IgnoreCase);


            if (isLocalDb)
            {
                // tcp is not a 
                bool isProperProtocol =
                    protocol == null
                    || "lpc".Equals(protocol, StringComparison.OrdinalIgnoreCase)
                    || "np".Equals(protocol, StringComparison.OrdinalIgnoreCase);

                // instanceName is Mandatory
                if (instanceName != null && isProperProtocol)
                {
                    return new SqlServerDataSource()
                    {
                        IsLocalDb = true,
                        IsLocalService = false,
                        ServiceName = null,
                        LocalDbInstance = instanceName ?? "MSSQLLocalDB",
                        Original = dataSource
                    };
                }
            }

            return new SqlServerDataSource()
            {
                Original = dataSource,
            };
            return null;
        }

    }
}
#endif