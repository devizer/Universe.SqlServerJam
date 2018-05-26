using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;

namespace Universe.SqlServerJam
{
    public class SqlServerRef
    {
        public SqlServerDiscoverySource Kind { get; set; }
        public Version Version { get; set; }
        public string Data { get; set; }

        public string ConnectionString
        {
            get
            {
                if (Kind == SqlServerDiscoverySource.Local)
                    return string.Format("Data Source={0};Integrated Security=SSPI", Data);
                if (Kind == SqlServerDiscoverySource.LocalDB)
                    return string.Format("Data Source={0};Integrated Security=SSPI", Data);
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
                    return new SqlConnectionStringBuilder(Data).DataSource;
                else
                    throw new NotSupportedException();
            }
        }

        public override string ToString()
        {
            return $"'{DataSource}'" + (Version != null ? (" Ver " + Version) : "");
        }

        public List<SqlServerRef> ProbeTransports(int timeoutMillisecs = 30000)
        {
            List<SqlServerRef> ret = new List<SqlServerRef>();
            if (this.Kind != SqlServerDiscoverySource.Local || this.Data.IndexOf(":") >= 0)
            {
                ret.Add(this);
                return ret;
            }

            string[] protocols = new[] {"lpc", "tcp", "np"};
            List<SqlServerRef> candidates = new List<SqlServerRef>();
            candidates.AddRange(protocols.Select(protocol => new SqlServerRef()
            {
                Kind = SqlServerDiscoverySource.Local,
                Data = protocol + ":" + this.Data,
                Version = this.Version,
            }));

            Parallel.ForEach(candidates, candidate =>
            {
                Stopwatch startAt = Stopwatch.StartNew();
                bool expired = false;
                do
                {
                    try
                    {
                        string cs = string.Format("Data Source={0};Integrated Security=SSPI; Timeout=3",
                            candidate.Data);
                        using (SqlConnection con = new SqlConnection(cs))
                            con.Manage().Ping(timeout: 3);

                        lock (ret) ret.Add(candidate);
                        break;
                    }
                    catch
                    {
                        // protocol is not supported
                    }

                    if (startAt.ElapsedMilliseconds > timeoutMillisecs)
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