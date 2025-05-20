using System;
using System.Collections.Generic;
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

        public bool Exists => _ServerManagement.IsDbExists(DatabaseName);

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
                
                string option = (value == AutoCreateStatisticMode.Off ? "OFF" : "ON");
                // Only off does not work on 2014+
                option +=
                    (IsIncrementalAutoStatisticCreationSupported && value != AutoCreateStatisticMode.Off
                        ? $" (INCREMENTAL = {(value == AutoCreateStatisticMode.Incremental ? "ON" : "OFF")})"
                        : string.Empty);

                string sql = string.Format("Alter Database [{0}] Set AUTO_CREATE_STATISTICS {1}",
                    DatabaseName,
                    option);

                // Console.WriteLine($"[DEBUG] AutoCreateStatistic={value}{Environment.NewLine}{sql}{Environment.NewLine}");
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

                // Console.WriteLine($"[DEBUG] AutoUpdateStatistic={value}{Environment.NewLine}{sql}{Environment.NewLine}");
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

        // Sum(size) of all files of the DB
        public long Size
        {
            get
            {
                string sql = $"Select Sum(Cast(size as bigint)) From [{this.DatabaseName}].sys.database_files";
                return 8L * _ServerManagement.SqlConnection.ExecuteScalar<long>(sql);
            }
        }

        public SqlDatabaseFiles Files
        {
            get
            {
                // size is 32-bit int in pages
                string sql = $"Select type_desc TypeName, state_desc StateName, name Name, size Size, physical_name PhysicalName, Cast((Case When (is_read_only = 1 or is_media_read_only = 1) Then 1 Else 0 End) as bit) IsReadOnly From [{this.DatabaseName}].sys.database_files";
                var files = _ServerManagement.SqlConnection.Query<SqlDatabaseFile>(sql).ToList();
                foreach (var file in files) file.Size *= 8 * 1024;
                return new SqlDatabaseFiles() { Files = files };
            }
        }

        public class SqlDatabaseFiles
        {
            public long Size => Files.Count == 0 ? 0 : Files.Sum(x => x.Size);
            public List<SqlDatabaseFile> Files { get; internal set; } = new List<SqlDatabaseFile>();

            public string ToSizeString()
            {
                StringBuilder typesString = new StringBuilder();
                var types = new[] { SqlDatabaseFileType.Data, SqlDatabaseFileType.Log, SqlDatabaseFileType.FullText, SqlDatabaseFileType.FileStream };
                foreach (var type in types)
                {
                    var files = Files.Where(x => x.Type == type).ToArray();
                    if (files.Length == 0) continue;
                    var detailsManyFiles = string.Join(" + ", files.Select(x => $"{x.Size / 1024:n0}").ToArray());
                    if (files.Length == 1)
                        typesString
                            .Append(typesString.Length == 0 ? "" : "; ")
                            .Append($"{type}: {files.Sum(x => x.Size)/1024:n0} KB");
                    else
                        typesString
                            .Append(typesString.Length == 0 ? "" : ", ")
                            .Append($"{type}: {files.Sum(x => x.Size):n0} = {detailsManyFiles} KB");
                }

                return $"{Size / 1024:n0} KB"
                       + (typesString.Length > 0 ? $" ({typesString})" : "");
            }
        }

        public class SqlDatabaseFile
        {
            // ROWS | LOG | FILESTREAM | FULLTEXT
            public string TypeName { get; internal set; }
            public string StateName { get; internal set; }
            public string Name { get; internal set; }
            public long Size { get; internal set; }
            public string PhysicalName { get; internal set; }
            public bool IsReadOnly { get; internal set; }

            public SqlDatabaseFileType Type =>
                "ROWS".Equals(TypeName, StringComparisonExtensions.IgnoreCase) ? SqlDatabaseFileType.Data
                : "LOG".Equals(TypeName, StringComparisonExtensions.IgnoreCase) ? SqlDatabaseFileType.Log
                : "FILESTREAM".Equals(TypeName, StringComparisonExtensions.IgnoreCase) ? SqlDatabaseFileType.FileStream
                : "FULLTEXT".Equals(TypeName, StringComparisonExtensions.IgnoreCase) ? SqlDatabaseFileType.FullText
                : SqlDatabaseFileType.Unknown;
        }

        public enum SqlDatabaseFileType
        {
            Unknown,
            Data,
            Log,
            FileStream,
            FullText,
        }

        // On Azure it is hardcoded as Checksum, update is not available
        public DatabasePageVerify PageVerify
        {
            get
            {
                if (this._ServerManagement.IsAzure) return DatabasePageVerify.Checksum;
                var rawRet = this.GetSysDatabasesColumn<byte>("page_verify_option");
                // Console.WriteLine($"[DEBUG] QUERY page_verify_option={rawRet} for {this.DatabaseName}");
                return (DatabasePageVerify)rawRet;
            }
            set
            {
                if (this._ServerManagement.IsAzure)
                    throw new InvalidOperationException("Azure SQL does not support for updating Page Verify mode");

                var verifyName = value == DatabasePageVerify.None ? "NONE" : value == DatabasePageVerify.Checksum ? "CHECKSUM" : value == DatabasePageVerify.TornPageDetection ? "TORN_PAGE_DETECTION" : null;
                if (verifyName == null) throw new ArgumentException($"Unknown DB Page Verify argument '{value}'");
                var sqlVerify = $"Alter Database [{this.DatabaseName}] Set PAGE_VERIFY {verifyName}";
                _ServerManagement.SqlConnection.Execute(sqlVerify);

                /*
                var tornName = value == DatabasePageVerify.TornPageDetection ? "ON" : "OFF";
                var sqlTorn = $"Alter Database [{this.DatabaseName}] Set TORN_PAGE_DETECTION {tornName}";
                sqlTorn = "-- none";

                var sqlCommands = value == DatabasePageVerify.TornPageDetection ? new[] { sqlTorn, sqlVerify } : new[] { sqlVerify, sqlTorn };

                foreach (var sqlCommand in sqlCommands)
                {
                    // Console.WriteLine($"[DEBUG] SQL: {sqlCommand}");
                    _ServerManagement.SqlConnection.Execute(sqlCommand);
                }
                */
            }
        }

        public DatabaseRecoveryMode RecoveryMode
        {
            get
            {
                var raw = GetSysDatabasesColumn<string>("recovery_model_desc");
                var all = Enum.GetValues(typeof(DatabaseRecoveryMode)).OfType<DatabaseRecoveryMode>().ToList();
                var ret = all.FirstOrDefault(x => x.ToString().Equals(raw, StringComparisonExtensions.IgnoreCase));
                if ("Bulk_Logged".Equals(raw, StringComparison.OrdinalIgnoreCase))
                    ret = DatabaseRecoveryMode.BulkLogged;

                if (ret == DatabaseRecoveryMode.Unknown)
                {
                    // var server = new SqlConnectionStringBuilder(_Connection.ConnectionString).DataSource;
                    var server = SqlServerJamConfigurationExtensions.GetDataSource(_Connection.ConnectionString);
                    Trace.WriteLine($"Unable to parse recovery model '{raw}' of DB [{DatabaseName}] on server {server}");
                }

                return ret;
            }
            set
            {
                if (value == DatabaseRecoveryMode.Unknown) throw new ArgumentOutOfRangeException();
                var mode = value == DatabaseRecoveryMode.BulkLogged ? "Bulk_Logged" : value.ToString();
                var sql = $"Alter Database [{DatabaseName}] Set Recovery {mode}";
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

        public string GetDigest(int indent = 4)
        {
            StringBuilder ret = new StringBuilder();
            WriteDigest(ret, indent);
            return ret.ToString();
        }

        public void WriteDigest(StringBuilder ret, int indent = 4)
        {
            string pre = indent > 0 ? new string(' ', indent) : "";
            ret.AppendLine($"{pre} - Auto Shrink ......... : {IsAutoShrink}");
            ret.AppendLine($"{pre} - Auto Create Statistic : {AutoCreateStatistic}");
            ret.AppendLine($"{pre} - Auto Update Statistic : {AutoUpdateStatistic}");
            ret.AppendLine($"{pre} - Page Verify ......... : {PageVerify}");
            ret.AppendLine($"{pre} - Recursive Triggers .. : {AreTriggersRecursive}");
            ret.AppendLine($"{pre} - Broker Enabled ...... : {IsBrokerEnabled}");
            ret.AppendLine($"{pre} - State ............... : {(IsOnline ? "Online" : StateDescription)}");
            ret.AppendLine($"{pre} - Is Readonly ......... : {IsReadOnly}");
            ret.AppendLine($"{pre} - Is Memory Optimized . : {HasMemoryOptimizedTableFileGroup}");
            var comparisionStyle = ComparisonStyle;
            ret.AppendLine($"{pre} - Default Collation ... : {DefaultCollationName} [{comparisionStyle}]");
            ret.AppendLine($"{pre} - Fulltext Search ..... : {(IsFullTextEnabled ? "Enabled" : "Not Enabled")}");
            ret.AppendLine($"{pre} - Size (KB) ........... : {Size}");
            ret.AppendLine($"{pre} - Size Detailed ....... : {this.Files.ToSizeString()}");
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
        BulkLogged,
        Full,
    }

    public enum DatabasePageVerify : byte
    {
        None = 0,
        TornPageDetection = 1,
        Checksum = 2,
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
