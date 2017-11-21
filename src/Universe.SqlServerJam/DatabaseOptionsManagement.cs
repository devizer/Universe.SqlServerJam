using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Linq;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam
{
    public class DatabaseOptionsManagement
    {
        private readonly SqlConnection _Connection;
        private readonly string _DatabaseName;
        readonly object _Sync = new object();
        private Version _ServerVersion;

        Version ServerVersion
        {
            get
            {
                if (_ServerVersion == null)
                    lock (_Sync)
                        if (_ServerVersion == null) _ServerVersion = _Connection.GetServerShortVersion();

                return _ServerVersion;
            }
        }

        public DatabaseOptionsManagement(SqlConnection connection, string databaseName)
        {
            _Connection = connection;
            _DatabaseName = databaseName;
        }

        public bool IsBrokerEnabled
        {
            get { return _Connection.OpenIfClosed().GetSysDatabasesColumn<bool>("is_broker_enabled", _DatabaseName); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set {1}_BROKER",
                    _DatabaseName,
                    value ? "ENABLE" : "DISABLE");

                _Connection.OpenIfClosed().Execute(sql);
            }
        }

        public bool IsReadOnly
        {
            get { return _Connection.OpenIfClosed().GetSysDatabasesColumn<bool>("is_read_only", _DatabaseName); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set {1}",
                    _DatabaseName,
                    value ? "READ_ONLY" : "READ_WRITE");

                _Connection.OpenIfClosed().Execute(sql);
            }
        }

        public bool IsAutoShrink
        {
            get { return _Connection.OpenIfClosed().GetSysDatabasesColumn<bool>("is_auto_shrink_on", _DatabaseName); }
            set
            {
                string sql = string.Format("Alter Database [{0}] Set AUTO_SHRINK {1}",
                    _DatabaseName,
                    value ? "ON" : "OFF");

                _Connection.OpenIfClosed().Execute(sql);
            }
        }

        public void SetState(TargetDatabaseState newState)
        {
            string sql = string.Format("Alter Database [{0}] Set {1}",
                _DatabaseName,
                newState);

            _Connection.OpenIfClosed().Execute(sql);
        }

        public string StateDescription
        {
            get { return _Connection.OpenIfClosed().GetSysDatabasesColumn<string>("state_desc", _DatabaseName); }
        }

        public bool IsOnline
        {
            get { return "ONLINE".Equals(StateDescription, StringComparison.InvariantCultureIgnoreCase); }
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
                var c = _Connection.OpenIfClosed();
                bool isOn = c.GetSysDatabasesColumn<bool>("is_auto_create_stats_on");
                bool isIncremental = IsIncrementalAutoStatisticCreationSupported
                                     && c.GetSysDatabasesColumn<bool>("is_auto_create_stats_incremental_on");

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
                    _DatabaseName,
                    option);

                _Connection.OpenIfClosed().Execute(sql);

            }
        }

        public AutoUpdateStatisticMode AutoUpdateStatistic
        {
            get
            {
                var c = _Connection.OpenIfClosed();
                bool isOn = c.GetSysDatabasesColumn<bool>("is_auto_update_stats_on");
                bool isAsync = c.GetSysDatabasesColumn<bool>("is_auto_update_stats_async_on");
                return !isOn ? AutoUpdateStatisticMode.Off
                    : (isAsync ? AutoUpdateStatisticMode.Async : AutoUpdateStatisticMode.Syncly);
            }
            set
            {
                string option = "AUTO_UPDATE_STATISTICS OFF";
                if (value == AutoUpdateStatisticMode.Syncly)
                    option = "AUTO_UPDATE_STATISTICS ON, AUTO_UPDATE_STATISTICS_ASYNC OFF";
                else if (value == AutoUpdateStatisticMode.Async)
                    option = "AUTO_UPDATE_STATISTICS ON, AUTO_UPDATE_STATISTICS_ASYNC ON";

                string sql = string.Format("Alter Database [{0}] Set {1}",
                    _DatabaseName,
                    option);

                _Connection.OpenIfClosed().Execute(sql);

            }
        }

        public string DefaultCollationName
        {
            get
            {
                return _Connection.OpenIfClosed().GetSysDatabasesColumn<string>("collation_name", _DatabaseName);
            }
            set
            {
                if (new[] { '\'', ';', '"', ' ', '\r', '\n'}.Any(x => value.IndexOf(x.ToString()) >= 0))
                    throw new ArgumentException();

                string sql = string.Format("Alter Database [{0}] COLLATE {1}",
                    _DatabaseName,
                    value);

                _Connection.OpenIfClosed().Execute(sql);
            }
        }

        public DatabaseComparisonStyle ComparisonStyle
        {
            get
            {
                return (DatabaseComparisonStyle)_Connection.OpenIfClosed()
                    .GetDatabaseProperty<int>("ComparisonStyle", _DatabaseName);
            }
        }

        public bool IsClone
        {
            get
            {
                return _Connection.OpenIfClosed()
                    .GetDatabaseProperty<bool>("IsClone", _DatabaseName);
            }
        }

        public long? Size
        {
            get
            {
                int size;
                if (!_Connection.GetDatabases().TryGetValue(_DatabaseName, out size))
                    return null;
                else
                    return size;
            }
        }

        public DatabaseRecoveryMode RecoveryMode
        {
            get
            {
                var raw = _Connection.OpenIfClosed().GetSysDatabasesColumn<string>("recovery_model_desc");
                var all = Enum.GetValues(typeof(DatabaseRecoveryMode)).OfType<DatabaseRecoveryMode>().ToList();
                var ret = all.FirstOrDefault(x => x.ToString().Equals(raw, StringComparison.InvariantCultureIgnoreCase));


                if (ret == DatabaseRecoveryMode.Unknown)
                {
                    var server = new SqlConnectionStringBuilder(_Connection.ConnectionString).DataSource;
                    Debug.WriteLine($"Unable to parse recovery model {raw} of DB [{_DatabaseName}] on server {server}");
                }

                return ret;
            }
            set
            {
                if (value == DatabaseRecoveryMode.Unknown) throw new ArgumentOutOfRangeException();
                var sql = $"Alter Database [{_DatabaseName}] Set Recovery {value}";
                _Connection.OpenIfClosed().Execute(sql);
            }

        }

        public bool AreTriggersRecursive
        {
            get
            {
                return _Connection.OpenIfClosed().GetSysDatabasesColumn<bool>("is_recursive_triggers_on");
            }
            set
            {
                var sql = $"Alter Database [{_DatabaseName}] Set RECURSIVE_TRIGGERS {(value ? "ON" : "OFF")}";
                _Connection.OpenIfClosed().Execute(sql);
            }
        }

        public bool IsFullTextEnabled
        {
            get
            {
                return _Connection.OpenIfClosed().GetSysDatabasesColumn<bool>("is_fulltext_enabled");
            }
        }



        public void Shrink(ShrinkOptions options = ShrinkOptions.ShinkAndTruncate)
        {

            string so = "";
            if (options == ShrinkOptions.ShrinkOnly)
                so = ", NOTRUNCATE";
            else if (options == ShrinkOptions.TruncateOnly)
                so = ", TRUNCATEONLY";

            string sql = string.Format(
                @"DBCC SHRINKDATABASE ('{0}' {1}) WITH NO_INFOMSGS",
                _DatabaseName.Replace("'", "''"),
                so);

            _Connection.Execute(sql);
        }


        public string GetDigest(int intent = 4)
        {
            StringBuilder ret = new StringBuilder();
            string pre = intent > 0 ? new string(' ', intent) : "";
            ret.AppendLine($"{pre} - Auto Shrink ......... : {IsAutoShrink}");
            ret.AppendLine($"{pre} - Auto Create Statistic : {AutoCreateStatistic}");
            ret.AppendLine($"{pre} - Auto Update Statistic : {AutoUpdateStatistic}");
            ret.AppendLine($"{pre} - Recursive Triggers .. : {AreTriggersRecursive}");
            ret.AppendLine($"{pre} - Broker Enabled ...... : {IsBrokerEnabled}");
            ret.AppendLine($"{pre} - State ............... : {(IsOnline ? "Online" : StateDescription)}");
            ret.AppendLine($"{pre} - Is Readonly ......... : {IsReadOnly}");
            var comparisionStyle = ComparisonStyle;
            ret.AppendLine($"{pre} - Default Collation ... : {DefaultCollationName} [{comparisionStyle}]");
            ret.AppendLine($"{pre} - Size (KB) ........... : {Size}");
            ret.AppendLine($"{pre} - Recovery Mode ....... : {RecoveryMode}");
            var isFullText = IsFullTextEnabled;
            var isClone = IsClone;
            return ret.ToString();
        }

        /*
                                bool IsBrokerEnabled
                                enum RecoveryModel: 3 Kinds
                                bool IsReadOnly,
                                enum State: N Kinds
                                enum AutoCreateStatistic: 3 kinds (Off, Sync, Incremental)
                                enum AutoUpdateStatisctic: Off, Syncly, Async
                                bool AreTriggersRecursive
                                IsFullTextEnabled
                                bool IsAutoShrink
                                string Collation
                        */
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
        Syncly,
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
