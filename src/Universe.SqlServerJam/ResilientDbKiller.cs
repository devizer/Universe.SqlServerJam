using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using Dapper;

namespace Universe.SqlServerJam
{
    public class ResilientDbKiller
    {
        public static void Kill(string sqlConnectionString, bool throwOnError = false, int retryCount = 1)
        {
            if (sqlConnectionString == null)
                throw new ArgumentNullException(nameof(sqlConnectionString));

            var master = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            master.ConnectionString = sqlConnectionString;

            // SqlConnectionStringBuilder master = new SqlConnectionStringBuilder(sqlConnectionString);
            string dbName = master["Initial Catalog"]?.ToString();
            if (string.IsNullOrEmpty(dbName))
            {
                string keys = string.Join(", ", master.Keys.OfType<object>().Select(x => Convert.ToString(x)).ToArray());
                throw new ArgumentException($"sqlConnectionString argument misses concrete database. Parameters are: [{keys}]", nameof(sqlConnectionString));
            }

            master.Remove("Initial Catalog");
            // master["Pooling"] = true.ToString();
            master["Pooling"] = true;

            string connectionString = master.ConnectionString;
            using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(connectionString))
            {
                var man = con.Manage();
                if (man.IsDbExists(dbName))
                {
                    int counter = retryCount;
                    while (--counter >= 0)
                    {
                        try
                        {
                            KillConnections(con, dbName);

                            // EF Behavior
                            string sql =
                                $"IF SERVERPROPERTY('EngineEdition') <> 5" +
                                $"   EXEC(N'ALTER DATABASE [{dbName}] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;')";

                            // Single User Mode is needless
                            // con.Execute(sql);
                            con.Execute($"Drop Database [{dbName}]");
                            return;
                        }
                        catch
                        {
                            if (counter == 0 && throwOnError)
                                throw;

                            Thread.Sleep(1);
                        }
                    }
                }
            }
        }

        // DbContext.Database.EnsureDeleted() behavior wait for few seconds before killing connections
        // It kills connections explicitly
        private static void KillConnections(DbConnection con, string dbName)
        {
            // int mySpid = con.ExecuteScalar<int>("Select @@SPID");
            int mySpid = con.ExecuteScalar<short>("Select @@SPID");
            List<sp_who> query = con.Query<sp_who>("exec sp_who").ToList();
            StringComparison comp = StringComparisonExtensions.IgnoreCase;
            List<int> dbConnectionIdList = query
                .Where(x => x.dbname != null && x.dbname.Equals(dbName, comp))
                .Where(x => x.spid != mySpid)
                .Select(x => (int) x.spid)
                .ToList();

            foreach (var id in dbConnectionIdList)
            {
                try
                {
                    con.Execute($"Kill {id}");
                }
                catch (Exception ex)
                {
                    Trace.WriteLine($"Warning! Failed to kill connection {id} to database {dbName}. No additional actions required. " +
                                    $"{ex.GetLegacyExceptionDigest()}");
                }
            }
        }

        class sp_who
        {
            public int spid { get; set; }
            public string dbname { get; set; }
            
        }
    }
}

