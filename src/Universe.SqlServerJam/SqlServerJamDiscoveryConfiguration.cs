using System;

namespace Universe.SqlServerJam
{
    public class SqlServerJamDiscoveryConfiguration
    {
        const string FormatLocalServerName = "LOCAL_SQLSERVER_DISCOVERY_CONNECTION_STRING_FORMAT";
        const string FormatLocalDbName =     "LOCALDB_DISCOVERY_CONNECTION_STRING_FORMAT";
        private const string DefaultLocalDbConnectionStringFormat = "Data Source={0};Integrated Security=SSPI;Encrypt=False";
        private const string DefaultLocalServerConnectionStringFormat = "Data Source={0};Integrated Security=SSPI;Encrypt=False";
        private static string _LocalServerConnectionStringFormat;
        private static string _LocalDbConnectionStringFormat;

        private static readonly object Sync = new object();

        public static string LocalServerConnectionStringFormat
        {
            get
            {
                if (_LocalServerConnectionStringFormat != null)
                    return _LocalServerConnectionStringFormat;

                lock (Sync)
                {
                    _LocalServerConnectionStringFormat = GetEnv(FormatLocalServerName, DefaultLocalServerConnectionStringFormat);
                    return _LocalServerConnectionStringFormat;
                }
            }
            set { lock (Sync) _LocalServerConnectionStringFormat = value; }
        }

        public static string LocalDbConnectionStringFormat
        {
            get
            {
                if (_LocalDbConnectionStringFormat != null)
                    return _LocalDbConnectionStringFormat;

                lock (Sync)
                {
                    _LocalDbConnectionStringFormat = GetEnv(FormatLocalDbName, DefaultLocalDbConnectionStringFormat);
                    return _LocalDbConnectionStringFormat;
                }
            }
            set { lock (Sync) _LocalDbConnectionStringFormat = value; }
        }

        private static string GetEnv(string name, string defaultValue)
        {
            var ret = Environment.GetEnvironmentVariable(name);
            return string.IsNullOrEmpty(ret) ? defaultValue : ret;
        }
    }
}