using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Universe.SqlServerJam
{
    public class SqlServerRef
    {
        public SqlServerDiscoverySource Kind { get; set; }

        // InstallerVersion is populated by Discovery, null for well known
        public Version InstallerVersion { get; set; }
        
        // Version is populated by WarmUp
        public Version Version { get; set; }
        public bool IsAlive => Version != null;
        public string Data { get; set; }

        // Not for LocalDB. LocalDB is Automatic
        public LocalServiceStartup ServiceStartup { get; set; }
        public bool IsNotDisabled => ServiceStartup != LocalServiceStartup.Disabled;

        public string ConnectionString
        {
            get
            {
                if (Kind == SqlServerDiscoverySource.Local)
                    // return string.Format("Data Source={0};Integrated Security=SSPI", Data);
                    return string.Format(SqlServerJamDiscoveryConfiguration.LocalServerConnectionStringFormat, Data);
                if (Kind == SqlServerDiscoverySource.LocalDB)
                    // return string.Format("Data Source={0};Integrated Security=SSPI", Data);
                    return string.Format(SqlServerJamDiscoveryConfiguration.LocalDbConnectionStringFormat, Data);
                else if (Kind == SqlServerDiscoverySource.WellKnown)
                    return Data;
                else
                    throw new NotSupportedException();
            }
        }

        public string DataSource
        {
            get
            {
                if (Kind == SqlServerDiscoverySource.Local || Kind == SqlServerDiscoverySource.LocalDB)
                    return Data;
                else if (Kind == SqlServerDiscoverySource.WellKnown)
                    // return new SqlConnectionStringBuilder(Data).DataSource;
                    return SqlServerJamConfigurationExtensions.GetDataSource(Data ?? "Data Source=Undefined");
                else
                    throw new NotSupportedException();
            }
        }

        public override string ToString()
        {
            var ver = Version ?? InstallerVersion;
            var startupInfo = ServiceStartup != LocalServiceStartup.Unknown ? $", {ServiceStartup}" : "";
            return $"'{DataSource}'" + (ver != null ? (" Ver " + ver) : "") /* + startupInfo*/;
        }

        public List<SqlServerRef> ProbeTransports(int timeoutMilliseconds = 30000)
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            if (this.Kind != SqlServerDiscoverySource.Local || this.Data.IndexOf(":") >= 0 || this.Data.IndexOf(",") >= 0 || !this.IsNotDisabled)
            {
                ret.Add(this);
                return ret;
            }

            // Only Local Services except of LocalDB
            string[] protocols = new[] {"lpc", "tcp", "np"};
            List<SqlServerRef> candidates = new List<SqlServerRef>();
            candidates.AddRange(protocols.Select(protocol => new SqlServerRef()
            {
                Kind = SqlServerDiscoverySource.Local,
                Data = protocol + ":" + this.Data,
                InstallerVersion = this.InstallerVersion,
                ServiceStartup = this.ServiceStartup,
            }));

            Parallel.ForEach(candidates, candidate =>
            {
                Stopwatch startAt = Stopwatch.StartNew();
                bool expired = false;
                do
                {
                    try
                    {

                        // string cs = $"Data Source={candidate.Data};Integrated Security=SSPI; Timeout=3";
                        var cs = SqlServerJamConfigurationExtensions.ResetConnectionTimeout(candidate.ConnectionString, 3);
                        using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(cs))
                            con.Manage().Ping(timeout: 3);

                        lock (ret) ret.Add(candidate);
                        break;
                    }
                    catch
                    {
                        // protocol is not supported
                    }

                    if (startAt.ElapsedMilliseconds > timeoutMilliseconds)
                        expired = true;

                } while (!expired);
            });

            ret = ret.OrderBy(x => x.DataSource).ToList();

            if (ret.Count == 0)
            {
                ret.Add(this);
            }

            return ret;
        }
    }
}