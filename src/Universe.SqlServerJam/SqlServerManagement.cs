using System;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.Threading;
using Dapper;

namespace Universe.SqlServerJam
{
    public class SqlServerManagement
    {
        public IDbConnection SqlConnection { get; }
        public DatabaseSelector Databases { get; }
        readonly Lazy<Version> _ShortServerVersion;

        public SqlServerManagement(IDbConnection sqlConnection)
        {
            SqlConnection = sqlConnection ?? throw new ArgumentNullException(nameof(sqlConnection));

            _ShortServerVersion = new Lazy<Version>(() =>
            {
                int ver32Bit = SqlConnection.ExecuteScalar<int>("Select @@MICROSOFTVERSION");
                int v1 = ver32Bit >> 24;
                int v2 = ver32Bit >> 16 & 0xFF;
                int v3 = ver32Bit & 0xFFFF;
                return new Version(v1, v2, v3);
            }, LazyThreadSafetyMode.ExecutionAndPublication);

            Databases = new DatabaseSelector(this);
        }

        public T GetServerProperty<T>(string propertyName)
        {
            return SqlConnection.ExecuteScalar<T>($"Select SERVERPROPERTY('{propertyName}')");
        }

        public string ServerEdition => GetServerProperty<string>("Edition");

        public EngineEdition EngineEdition => (EngineEdition) GetServerProperty<int>("EngineEdition");

        public SecurityMode SecurityMode => (SecurityMode) GetServerProperty<int>("IsIntegratedSecurityOnly");

        // Returns either "Windows" or "Linux"
        public string HostPlatform => SqlConnection.ExecuteScalar<string>(SqlGetHostPlatform);

        public Version ShortServerVersion => _ShortServerVersion.Value;

        public bool IsLocalDB => ShortServerVersion.Major >= 11 && GetServerProperty<int>("IsLocalDB") == 1;

        public bool IsDbExists(string dbName)
        {
            if (dbName == null)
                throw new ArgumentNullException(nameof(dbName));

            string sql = "Select Cast(Case When Exists(Select 1 From sys.databases Where Name = @dbName) Then 1 Else 0 End As Bit)";
            return this.SqlConnection.ExecuteScalar<bool>(sql, new { dbName });
        }

        public FixedServerRoles FixedServerRoles
        {
            get
            {
                IEnumerable<FixedServerRoles> all = Enum.GetValues(typeof(FixedServerRoles)).OfType<FixedServerRoles>();
                FixedServerRoles ret = FixedServerRoles.None;
                foreach (var i in all)
                {
                    int? isMember = SqlConnection.ExecuteScalar<int?>($"Select IS_SRVROLEMEMBER('{i}')");
                    if (isMember.HasValue && isMember.Value != 0)
                        ret |= i;
                }

                return ret;
            }
        }

        public bool IsFullTextSearchInstalled =>
            1 == SqlConnection.ExecuteScalar<int?>("SELECT FULLTEXTSERVICEPROPERTY('IsFullTextInstalled')");

        public bool IsConnectionEncrypted
        {
            get
            {
                const string sql = "SELECT encrypt_option FROM sys.dm_exec_connections WHERE session_id = @@SPID;";
                return SqlConnection.ExecuteScalar<bool>(sql);
            }
        }

        public string NetTransport
        {
            get
            {
                const string sql = "SELECT net_transport FROM sys.dm_exec_connections WHERE session_id = @@SPID;";
                return SqlConnection.ExecuteScalar<string>(sql);
            }
        }

        public bool IsCompressedBackupSupported => 
            this.EngineEdition == EngineEdition.Enterprise 
            && this.ShortServerVersion.Major >= 10;

        public Dictionary<string, int> DatabaseSizes
        {
            get
            {
                if (!IsAzure)
                {
                    var query = SqlConnection.Query("exec sp_databases");
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
                    var sql = "Select Sum(CAST(FileProperty(name, 'SpaceUsed') AS Bigint) * 8192.) From sys.database_files";
                    decimal size = SqlConnection.ExecuteScalar<decimal>(sql);
                    return new Dictionary<string, int>
                    {
                        {CurrentDatabaseName, (int) (size / 1024m)}
                    };
                }
            }
        }

        public bool IsAzure
        {
            get
            {
                if ("SQL Azure".Equals(ServerEdition, StringComparison.InvariantCultureIgnoreCase))
                    return true;

                var so = GetDatabaseProperty<string>("ServiceObjective");
                return !string.IsNullOrEmpty(so);
            }
        }

        internal T GetDatabaseProperty<T>(string propertyName, string databaseName = null)
        {
            return SqlConnection.ExecuteScalar<T>("Select DatabasePropertyEx(@db, @property)", new
            {
                db = databaseName ?? CurrentDatabaseName,
                property = propertyName
            });
        }

        public string ProductVersion
        {
            get
            {
                var ret = GetServerProperty<string>("ProductVersion");
                if (string.IsNullOrEmpty(ret)) ret = ShortServerVersion?.ToString();
                return ret;
            }
        }

        public string LongServerVersion
        {
            get
            {
                var ret = SqlConnection.ExecuteScalar<string>("Select @@VERSION");
                ret = ret.Replace("\r", " ").Replace("\n", " ").Replace("\t", " ");
                while (ret.IndexOf("  ", StringComparison.InvariantCultureIgnoreCase) >= 0)
                    ret = ret.Replace("  ", " ");

                return ret;
            }
        }


        public string ServerCollation => GetServerProperty<string>("Collation");

        // If connection is closed this property is useless
        public int CurrentSPID => SqlConnection.ExecuteScalar<int>("Select @@SPID");

        public string CurrentDatabaseName => SqlConnection.ExecuteScalar<string>("Select DB_NAME()");

        public DatabaseOptionsManagement CurrentDatabase => this.Databases[CurrentDatabaseName];

        public string ProductUpdateLevel => GetServerProperty<string>("ProductUpdateLevel");

        public string ProductLevel => GetServerProperty<string>("ProductLevel");

        // timeout in seconds
        public double Ping(int timeout = 20)
        {
            Stopwatch sw = Stopwatch.StartNew();
            SqlConnection.Execute("-- ping", commandTimeout: Math.Max(1, timeout));
            return sw.ElapsedTicks / (double) Stopwatch.Frequency;
        }

        public SqlDefaultPaths DefaultPaths
        {
            get
            {
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
                    IEnumerable<SqlDefaultPaths> query = SqlConnection.Query<SqlDefaultPaths>(sql);
                    ret = query.First();
                }
                catch
                {
                    // Oops. Its an Azure...
                }


                if (ShortServerVersion.Major >= 11)
                {
                    var dataPath = GetServerProperty<string>("InstanceDefaultDataPath");
                    var logPath = GetServerProperty<string>("InstanceDefaultLogPath");
                    if (!string.IsNullOrEmpty(dataPath)) ret.DefaultData = dataPath;
                    if (!string.IsNullOrEmpty(logPath)) ret.DefaultLog = logPath;
                }

                return ret;
            }
        }


        public class DatabaseSelector
        {
            readonly SqlServerManagement Owner;

            public DatabaseSelector(SqlServerManagement owner)
            {
                Owner = owner;
            }

            public DatabaseOptionsManagement this[string databaseName] => 
                new DatabaseOptionsManagement(Owner, databaseName);

        }

        private const string SqlGetHostPlatform = @"
if exists (select 1 from sys.all_objects where name = 'dm_os_host_info' and type = 'V' and is_ms_shipped = 1)
begin
    select host_platform from sys.dm_os_host_info
end
else 
    select N'Windows' as host_platform
";

    }
}