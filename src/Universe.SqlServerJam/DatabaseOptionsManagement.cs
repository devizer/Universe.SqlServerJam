using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading;
using Dapper;

namespace Universe.SqlServerJam
{
    public class DatabaseOptionsManagement
    {
        private readonly SqlServerManagement _ServerManagement;
        private readonly Lazy<string> _DatabaseName;
        private string DatabaseName => _DatabaseName.Value;

        private IDbConnection _Connection => _ServerManagement.SqlConnection;

        Version ServerVersion => _ServerManagement.ShortServerVersion;

        // CTOR should not throw exception except of ArgumentException;
        public DatabaseOptionsManagement(SqlServerManagement serverManagement, string databaseName = null)
        {
            if (serverManagement == null) throw new ArgumentNullException(nameof(serverManagement));

            _ServerManagement = serverManagement;

            // As comment above said,
            // serverManagement.CurrentDatabaseName can be lazy only
            _DatabaseName = new Lazy<string>(
                () => databaseName ?? serverManagement.CurrentDatabaseName,
                LazyThreadSafetyMode.ExecutionAndPublication
            );
        }

        internal T GetSysDatabasesColumn<T>(string propertyName)
        {
            return _ServerManagement.SqlConnection.ExecuteScalar<T>($"Select {propertyName} from sys.databases where name=@name", new { name = DatabaseName });
        }

        public bool IsBrokerEnabled
        {
            get { return GetSysDatabasesColumn<bool>("is_broker_enabled"); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set {1}_BROKER",
                    DatabaseName,
                    value ? "ENABLE" : "DISABLE");

                _Connection.Execute(sql);
            }
        }

        public bool IsReadOnly
        {
            get { return GetSysDatabasesColumn<bool>("is_read_only"); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set {1}",
                    DatabaseName,
                    value ? "READ_ONLY" : "READ_WRITE");

                _Connection.Execute(sql);
            }
        }

        public bool IsAutoShrink
        {
            get { return GetSysDatabasesColumn<bool>("is_auto_shrink_on"); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set AUTO_SHRINK {1}",
                    DatabaseName,
                    value ? "ON" : "OFF");

                _Connection.Execute(sql);
            }
        }

        public void SetState(TargetDatabaseState newState)
        {
            string sql = string.Format("Alter Database [{0}] Set {1}",
                DatabaseName,
                newState);

            _Connection.Execute(sql);
        }

        public string StateDescription
        {
            get { return GetSysDatabasesColumn<string>("state_desc"); }
        }

        public bool IsOnline
        {
            get { return "ONLINE".Equals(StateDescription, StringComparisonExtensions.IgnoreCase); }
        }

        public bool IsIncrementalAutoStatisticCreationSupported
        {
            get { return ServerVersion.Major >= 12; }
        }

        // For SQL Servers below 2014 Incremental mode downgrades to regular one.
        public AutoCreateStatisticMode AutoCreateStatistic
        {
            get
            {
                bool isOn = GetSysDatabasesColumn<bool>("is_auto_create_stats_on");
                bool isIncremental = IsIncrementalAutoStatisticCreationSupported
                                     && GetSysDatabasesColumn<bool>("is_auto_create_stats_incremental_on");

                return !isOn ? AutoCreateStatisticMode.Off
                    : (isIncremental ? AutoCreateStatisticMode.Incremental : AutoCreateStatisticMode.Complete);
            }
            set
            {
                string option =
                    (value == AutoCreateStatisticMode.Off ? "OFF" : "ON")
                    + (IsIncrementalAutoStatisticCreationSupported
                        ? $" (INCREMENTAL = {(value == AutoCreateStatisticMode.Incremental ? "ON" : "OFF")})"
                        : string.Empty);

                string sql = string.Format("Alter Database [{0}] Set AUTO_CREATE_STATISTICS {1}",
                    DatabaseName,
                    option);

                _Connection.Execute(sql);
            }
        }

        public AutoUpdateStatisticMode AutoUpdateStatistic
        {
            get
            {
                var c = _Connection;
                bool isOn = GetSysDatabasesColumn<bool>("is_auto_update_stats_on");
                bool isAsync = GetSysDatabasesColumn<bool>("is_auto_update_stats_async_on");
                return !isOn ? AutoUpdateStatisticMode.Off
                    : (isAsync ? AutoUpdateStatisticMode.Async : AutoUpdateStatisticMode.Synchronously);
            }
            set
            {
                string option = "AUTO_UPDATE_STATISTICS OFF";
                if (value == AutoUpdateStatisticMode.Synchronously)
                    option = "AUTO_UPDATE_STATISTICS ON, AUTO_UPDATE_STATISTICS_ASYNC OFF";
                else if (value == AutoUpdateStatisticMode.Async)
                    option = "AUTO_UPDATE_STATISTICS ON, AUTO_UPDATE_STATISTICS_ASYNC ON";

                string sql = string.Format("Alter Database [{0}] Set {1}",
                    DatabaseName,
                    option);

                _Connection.Execute(sql);

            }
        }

        public string DefaultCollationName
        {
            get
            {
                return GetSysDatabasesColumn<string>("collation_name");
            }
            set
            {
                if (new[] { '\'', ';', '"', ' ', '\r', '\n'}.Any(x => value.IndexOf(x.ToString()) >= 0))
                    throw new ArgumentException();

                string sql = string.Format("Alter Database [{0}] COLLATE {1}",
                    DatabaseName,
                    value);

                _Connection.Execute(sql);
            }
        }

        public DatabaseComparisonStyle ComparisonStyle
        {
            get
            {
                return (DatabaseComparisonStyle)_ServerManagement.GetDatabaseProperty<int>("ComparisonStyle", DatabaseName);
            }
        }

        public bool IsClone
        {
            get
            {
                return _ServerManagement.GetDatabaseProperty<bool>("IsClone", DatabaseName);
            }
        }

        /// <summary>
        /// /// Shared (for Web/Business editions)
        /// Basic
        /// S0 | S1 | S2 | S3
        /// P1 | P2 | P3
        /// ElasticPool
        /// System (for master DB)
        /// </summary>
        public string AzureServiceObjective => _ServerManagement.GetDatabaseProperty<string>("ServiceObjective", DatabaseName);


        /// <summary>
        /// Web = Web Edition Database
        /// Business = Business Edition Database
        /// Basic
        /// Standard
        /// Premium
        /// System (for master database)
        /// </summary>
        public string AzureEdition => _ServerManagement.GetDatabaseProperty<string>("Edition", DatabaseName);

        public string AzureElasticPool
        {
            get
            {
                if (string.IsNullOrEmpty(AzureEdition))
                    return null;
                
                string sql = @"
SELECT slo.elastic_pool_name FROM 
  sys.databases d
  JOIN sys.database_service_objectives slo
ON d.database_id = slo.database_id
WHERE d.name = @name
";

                return _Connection.ExecuteScalar<string>(sql, new { name = DatabaseName });
            }
        }

        // Sum(size) of all files of CURRENT DB :(
        public long? Size
        {
            get
            {
                const string sql = "Select Sum(Cast(size as bigint)) From sys.database_files";
                return 8L * _ServerManagement.SqlConnection.ExecuteScalar<long>(sql);
                int size;
                if (!_ServerManagement.DatabaseSizes.TryGetValue(DatabaseName, out size))
                    return null;
                else
                    return size;
            }
        }

        public DatabaseRecoveryMode RecoveryMode
        {
            get
            {
                var raw = GetSysDatabasesColumn<string>("recovery_model_desc");
                var all = Enum.GetValues(typeof(DatabaseRecoveryMode)).OfType<DatabaseRecoveryMode>().ToList();
                var ret = all.FirstOrDefault(x => x.ToString().Equals(raw, StringComparisonExtensions.IgnoreCase));

                if (ret == DatabaseRecoveryMode.Unknown)
                {
                    var server = new SqlConnectionStringBuilder(_Connection.ConnectionString).DataSource;
                    Trace.WriteLine($"Unable to parse recovery model '{raw}' of DB [{DatabaseName}] on server {server}");
                }

                return ret;
            }
            set
            {
                if (value == DatabaseRecoveryMode.Unknown) throw new ArgumentOutOfRangeException();
                var sql = $"Alter Database [{DatabaseName}] Set Recovery {value}";
                _Connection.Execute(sql);
            }

        }

        public bool AreTriggersRecursive
        {
            get
            {
                return GetSysDatabasesColumn<bool>("is_recursive_triggers_on");
            }
            set
            {
                var sql = $"Alter Database [{DatabaseName}] Set RECURSIVE_TRIGGERS {(value ? "ON" : "OFF")}";
                _Connection.Execute(sql);
            }
        }

        public bool IsFullTextEnabled => GetSysDatabasesColumn<bool>("is_fulltext_enabled");

        public string OwnerName
        {
            get
            {
                if (_ServerManagement.IsAzure)
                    return "Not Applicable";

                string sql = "select suser_sname(owner_sid) from sys.databases where name = @name";
                return _Connection.ExecuteScalar<string>(sql, new {name = DatabaseName});

            }
        }



        public void Shrink(ShrinkOptions options = ShrinkOptions.ShinkAndTruncate, int? commandTimeout = null)
        {

            string so = "";
            if (options == ShrinkOptions.ShrinkOnly)
                so = ", NOTRUNCATE";
            else if (options == ShrinkOptions.TruncateOnly)
                so = ", TRUNCATEONLY";

            string sql = string.Format(
                @"DBCC SHRINKDATABASE ('{0}' {1}) WITH NO_INFOMSGS",
                DatabaseName.Replace("'", "''"),
                so);

            _Connection.Execute(sql, commandTimeout.GetValueOrDefault());
        }

        public bool HasMemoryOptimizedTableFileGroup
        {
            get
            {
                if (_ServerManagement.IsMemoryOptimizedTableSupported)
                {
                    // string motFileGroup = _Connection.ExecuteScalar2<string>("Select Top 1 name from sys.filegroups where type = 'FX'");
                    var sql = "Select Top 1 name from sys.filegroups where type = 'FX'";
                    string motFileGroup = _Connection.Query<string>(sql).FirstOrDefault();
                    return motFileGroup != null;
                }

                return false;
            }
        }

        public string GetDigest(int intent = 4)
        {
            StringBuilder ret = new StringBuilder();
            WriteDigest(ret, intent);
            return ret.ToString();
        }

        public void WriteDigest(StringBuilder ret, int intent = 4)
        {
            string pre = intent > 0 ? new string(' ', intent) : "";
            ret.AppendLine($"{pre} - Auto Shrink ......... : {IsAutoShrink}");
            ret.AppendLine($"{pre} - Auto Create Statistic : {AutoCreateStatistic}");
            ret.AppendLine($"{pre} - Auto Update Statistic : {AutoUpdateStatistic}");
            ret.AppendLine($"{pre} - Recursive Triggers .. : {AreTriggersRecursive}");
            ret.AppendLine($"{pre} - Broker Enabled ...... : {IsBrokerEnabled}");
            ret.AppendLine($"{pre} - State ............... : {(IsOnline ? "Online" : StateDescription)}");
            ret.AppendLine($"{pre} - Is Readonly ......... : {IsReadOnly}");
            ret.AppendLine($"{pre} - Is Memory Optimized . : {HasMemoryOptimizedTableFileGroup}");
            var comparisionStyle = ComparisonStyle;
            ret.AppendLine($"{pre} - Default Collation ... : {DefaultCollationName} [{comparisionStyle}]");
            ret.AppendLine($"{pre} - Fulltext Search ..... : {(IsFullTextEnabled ? "Enabled" : "Not Enabled")}");
            ret.AppendLine($"{pre} - Size (KB) ........... : {Size}");
            ret.AppendLine($"{pre} - Recovery Mode ....... : {RecoveryMode}");
            ret.AppendLine($"{pre} - Owner ............... : {OwnerName}");
            ret.AppendLine($"{pre} - AZ Edition .......... : {AzureEdition}");
            ret.AppendLine($"{pre} - AZ Service Objective. : {AzureServiceObjective}");
            ret.AppendLine($"{pre} - AZ Elastic Pool ..... : {AzureElasticPool}");
            var isFullText = IsFullTextEnabled;
            var isClone = IsClone;
        }

    }

    public enum TargetDatabaseState
    {
        Online,
        Offline,
        Emergency
    }

    public enum AutoCreateStatisticMode
    {
        Off,
        Complete,
        Incremental,
    }

    public enum AutoUpdateStatisticMode
    {
        Off,
        Synchronously,
        Async,
    }

    public enum ShrinkOptions
    {
        ShinkAndTruncate,
        ShrinkOnly,
        TruncateOnly,
    }

    public enum DatabaseRecoveryMode
    {
        Unknown = 0,
        Simple,
        Bulk_Logged,
        Full,
    }

    [Flags]
    public enum DatabaseComparisonStyle
    {
        IgnoreCase = 1,
        IgnoreAccent = 2,
        IgnoreKana = 65536,
        IgnoreWidth = 131072,
    }


}
