using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using Dapper;

namespace Universe.SqlServerJam
{
    public static class SqlExtentions
    {

        public static IDbConnection OpenIfClosed(this IDbConnection connection)
        {
            if (connection == null)
                throw new ArgumentNullException(nameof(connection));

            if (connection.State == ConnectionState.Closed) connection.Open();
            return connection;
        }

        public static SqlConnection AsSqlConnection(this IDbConnection connection)
        {
            if (connection == null)
                throw new ArgumentNullException(nameof(connection));

            if (connection is SqlConnection)
                return (SqlConnection) connection;

            throw new ArgumentException(
                $"SqlConnection instance is expected. Fact type is {connection.GetType()}");
        }

        // Returns @@microsoftversion as System.Version
        public static Version GetServerShortVersion(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            int v = con.ExecuteScalar<int>("Select @@MICROSOFTVERSION");
            int v1 = v >> 24;
            int v2 = v >> 16 & 0xFF;
            int v3 = v & 0xFFFF;
            return new Version(v1, v2, v3);
        }

        public static string GetProductVersion(this IDbConnection connection)
        {
            var ret = connection.GetServerProperty<string>("ProductVersion");
            if (string.IsNullOrEmpty(ret)) ret = GetServerShortVersion(connection)?.ToString();
            return ret;
        }

        public static string GetServerCollation(this IDbConnection connection)
        {
            return connection.GetServerProperty<string>("Collation");
        }

        // Returns @@VERSION
        public static string GetServerVersionAsString(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            var ret = con.ExecuteScalar<string>("Select @@VERSION");
            ret = ret.Replace("\r", " ").Replace("\n", " ").Replace("\t", " ");
            while (ret.IndexOf("  ", StringComparison.InvariantCultureIgnoreCase) >= 0)
                ret = ret.Replace("  ", " ");

            return ret;
        }

        public static T GetServerProperty<T>(this IDbConnection connection, string propertyName)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            return con.ExecuteScalar<T>($"Select SERVERPROPERTY('{propertyName}')");
        }

        public static T GetSysDatabasesColumn<T>(this IDbConnection connection, string propertyName, string databaseName = null)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            if (databaseName == null)
                databaseName = GetCurrentDatabaseName(con);

            return con.ExecuteScalar<T>($"Select {propertyName} from sys.databases where name=@name", new { name = databaseName });
        }

        public static T GetDatabaseProperty<T>(this IDbConnection connection, string propertyName, string databaseName = null)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            if (databaseName == null)
                databaseName = GetCurrentDatabaseName(con);

            return con.ExecuteScalar<T>($"Select DatabasePropertyEx(@db, @property)", new { db = databaseName, property = propertyName });
        }

        public static string GetServerEdition(this IDbConnection connection)
        {
            return GetServerProperty<string>(connection, "Edition");
        }

        public static EngineEdition GetServerEngineEdition(this IDbConnection connection)
        {
            return (EngineEdition) GetServerProperty<int>(connection, "EngineEdition");
        }

        public enum EngineEdition
        {
            [Description("Personal or Desktop Engine (Not available in SQL Server 2005 and later versions.)")]
            Personal = 1,

            [Description("Standard (This is returned for Standard, Web, and Business Intelligence.)")]
            Standard = 2,

            [Description("Enterprise (This is returned for Evaluation, Developer, and both Enterprise editions.)")]
            Enterprise = 3,

            [Description("Express (This is returned for Express, Express with Tools and Express with Advanced Services)")]
            Express = 4,

            [Description("SQL Database")]
            SQL_Database = 5,

            [Description("SQL Data Warehouse")]
            SQL_Data_Warehouse = 6,

        }


        public static SecurityMode GetServerSecurityMode(this IDbConnection connection)
        {
            return (SecurityMode) connection.GetServerProperty<int>("IsIntegratedSecurityOnly");
        }


        public enum SecurityMode
        {
            [Description("Integrated security (Windows Authentication) only")]
            IntegratedOnly = 1,

            [Description("Both Windows Authentication and SQL Server Authentication")]
            Both = 0,
        }

        public static bool IsLocalDB(this IDbConnection connection)
        {
            if (connection.GetServerShortVersion().Major < 11)
                return false;

            return GetServerProperty<int>(connection, "IsLocalDB") == 1;
        }

        public static FixedServerRoles IsInFixedRoles(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            IEnumerable<FixedServerRoles> all = Enum.GetValues(typeof (FixedServerRoles)).OfType<FixedServerRoles>();
            FixedServerRoles ret = FixedServerRoles.None;
            foreach (var i in all)
            {
                int? @is = con.ExecuteScalar<int?>($"Select IS_SRVROLEMEMBER('{i}')");
                if (@is.HasValue && @is.Value != 0)
                    ret |= i;
            }

            return ret;
        }

        [Flags]
        public enum FixedServerRoles
        {
            None = 0,
            BulkAdmin = 128,
            BbCreator = 64,
            DiskAdmin = 32,
            ProcessAdmin = 16,
            SecurityAdmin = 8,
            ServerAdmin = 4,
            SetupAdmin = 2,
            SysAdmin = 1,
        }

        public static string GetServerProductLevel(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            return GetServerProperty<string>(con, "ProductLevel");
        }

        public static string GetServerProductUpdateLevel(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            return GetServerProperty<string>(con, "ProductUpdateLevel");
        }

        public static string GetCurrentDatabaseName(this IDbConnection connection, int? id = null)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            if (id.HasValue)
                return (string)con.ExecuteScalar("Select DB_NAME(@id)", new { id = id.Value });
            else
                return (string)con.ExecuteScalar("Select DB_NAME()");
        }

        public static DatabaseOptionsManagement GetDatabaseOptionsManager(this IDbConnection connection, string databaseName = null)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);

            if (databaseName == null)
                databaseName = GetCurrentDatabaseName(con);

            return new DatabaseOptionsManagement(con, databaseName);
        }

        public static string GetConnectionTransportAsString(this IDbConnection connection)
        {
            const string sql = "SELECT net_transport FROM sys.dm_exec_connections WHERE session_id = @@SPID;";
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            return con.ExecuteScalar<string>(sql);
        }

        // encrypt_option
        public static bool GetConnectionEncryption(this IDbConnection connection)
        {
            const string sql = "SELECT encrypt_option FROM sys.dm_exec_connections WHERE session_id = @@SPID;";
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            return con.ExecuteScalar<bool>(sql);
        }

        public static Dictionary<string, int> GetDatabases(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            if (!IsAzure(connection))
            {
                var query = con.Query("exec sp_databases");
                Dictionary<string, int> ret = new Dictionary<string, int>();
                foreach (var o in query)
                {
                    string name = o.DATABASE_NAME;
                    int size = o.DATABASE_SIZE;
                    ret[name] = size;
                }
                return ret;
            }
            else
            {
                var sql = "select sum(CAST(FILEPROPERTY(name, 'SpaceUsed') AS bigint) * 8192.) from sys.database_files";
                decimal size = con.ExecuteScalar<decimal>(sql);
                Dictionary<string, int> ret = new Dictionary<string, int>();
                ret[con.GetCurrentDatabaseName()] = (int) (size / 1024m);
                return ret;
            }

        }

        // SQL Azure
        public static bool IsAzure(this IDbConnection connection)
        {
            if ("SQL Azure".Equals(connection.GetServerEdition(), StringComparison.InvariantCultureIgnoreCase))
                return true;

            var so = connection.OpenIfClosed().GetDatabaseProperty<string>("ServiceObjective");
            return !string.IsNullOrEmpty(so);
        }

        public static int GetSPID(this IDbConnection connection)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);
            return con.ExecuteScalar<int>("Select @@SPID");
        }

        public static List<int> ListConnections(this IDbConnection connection, string databaseName)
        {
            var con = connection.AsSqlConnection();
            OpenIfClosed(con);

            if (databaseName == null)
                databaseName = GetCurrentDatabaseName(con);

            var query = con.Query<SP_WhoItem>("exec sp_who");
            const StringComparison comp = StringComparison.InvariantCultureIgnoreCase;
            return query
                .Where(x => x.dbname != null && x.dbname.Equals(databaseName, comp))
                .Select(x => x.spid)
                .ToList();
        }

        class SP_WhoItem
        {
            public int spid;
            public string dbname;
        }

        public static void DropDatabase_And_CloseConnections(string connectionString, string databseName, bool throwOnError = true)
        {
            KillConnections(connectionString, databseName);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                try
                {
                    con.Execute($"Drop Database [{databseName}]");
                }
                catch (Exception ex)
                {
                    Debug.WriteLine(
                        "Warning! Failed to drop database {0} on server {1}. {2}",
                        databseName,
                        new SqlConnectionStringBuilder(connectionString).DataSource,
                        ex.GetExeptionDigest()
                    );

                    if (throwOnError)
                        throw;
                }
            }
        }

        public static void KillConnections(string connectionString, string databaseName)
        {
            if (string.IsNullOrEmpty(connectionString))
                throw new ArgumentException("connectionString is null or empty", nameof(connectionString));

            if (string.IsNullOrEmpty(connectionString))
                throw new ArgumentException("databaseName is null or empty", nameof(databaseName));

            SqlConnectionStringBuilder b = new SqlConnectionStringBuilder(connectionString);
            b.Pooling = false;
            using (SqlConnection con = new SqlConnection(b.ConnectionString))
            {
                con.Open();
                var mySpid = con.GetSPID();
                var ids = con
                    .ListConnections(databaseName)
                    .Where(id => id != mySpid);

                foreach (var id in ids)
                {
                    try
                    {
                        con.Execute($"Kill {id}");
                    }
                    catch(Exception ex)
                    {
                        Debug.WriteLine(
                            $"Warning! Failed to kill connection {id} to database {databaseName}. {ex.GetExeptionDigest()}"
                        );
                    }
                }
            }
        }

        public static SqlDefaultPaths GetDefaultPaths(this IDbConnection connection)
        {

            var con = connection.AsSqlConnection();
            OpenIfClosed(con);

            const string sql = @"
declare @DefaultData nvarchar(1024)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultData', @DefaultData output

declare @DefaultLog nvarchar(1024)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'DefaultLog', @DefaultLog output

declare @DefaultBackup nvarchar(1024)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer', N'BackupDirectory', @DefaultBackup output

declare @MasterData nvarchar(512)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg0', @MasterData output
select @MasterData=substring(@MasterData, 3, 255)
select @MasterData=substring(@MasterData, 1, len(@MasterData) - charindex('\', reverse(@MasterData)))

declare @MasterLog nvarchar(512)
exec master.dbo.xp_instance_regread N'HKEY_LOCAL_MACHINE', N'Software\Microsoft\MSSQLServer\MSSQLServer\Parameters', N'SqlArg2', @MasterLog output
select @MasterLog=substring(@MasterLog, 3, 255)
select @MasterLog=substring(@MasterLog, 1, len(@MasterLog) - charindex('\', reverse(@MasterLog)))

select 
    isnull(@DefaultData, @MasterData) DefaultData, 
    isnull(@DefaultLog, @MasterLog) DefaultLog,
    isnull(@DefaultBackup, @MasterLog) DefaultBackup";


            SqlDefaultPaths ret = new SqlDefaultPaths();
            // Azure doesn't allow master.dbo.xp_instance_regread
            try
            {
                IEnumerable<SqlDefaultPaths> query = con.Query<SqlDefaultPaths>(sql);
                SqlDefaultPaths try1 = query.FirstOrDefault();
                ret = try1;
            }
            catch
            {
            }


            if (con.GetServerShortVersion().Major >= 11)
            {
                var dataPath = con.GetServerProperty<string>("InstanceDefaultDataPath");
                var logPath = con.GetServerProperty<string>("InstanceDefaultLogPath");
                if (!string.IsNullOrEmpty(dataPath)) ret.DefaultData = dataPath;
                if (!string.IsNullOrEmpty(logPath)) ret.DefaultLog = logPath;
            }

            return ret;
        }

        public static string GetHostPlatform(this IDbConnection connection)
        {

            var con = connection.AsSqlConnection();
            OpenIfClosed(con);

            const string sql = @"
if exists (select 1 from sys.all_objects where name = 'dm_os_host_info' and type = 'V' and is_ms_shipped = 1)
begin
    select host_platform from sys.dm_os_host_info
end
else 
    select N'Windows' as host_platform
";

            return con.ExecuteScalar<string>(sql);
        }


    }

}
