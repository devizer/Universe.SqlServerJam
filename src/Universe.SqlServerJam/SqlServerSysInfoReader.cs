using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam
{
    public class SqlServerSysInfo
    {
        // TODO: Propagate IDbConnection here
        public SqlServerManagement Management { get; }

        internal SqlServerSysInfo(SqlServerManagement management)
        {
            Management = management;
            _SysInfoState = new Lazy<InternalSysInfoState>(BuildSysInfoState);
        }


        // Cache of * from sys.dm_os_sys_info
        private Lazy<InternalSysInfoState> _SysInfoState;
        internal IDictionary<string, InfoRow> Dictionary => _SysInfoState.Value.Dictionary;
        internal List<InfoRow> RawRows => _SysInfoState.Value.RawRows;

        public class InfoRow
        {
            public string Name { get; internal set; }
            public object Value { get; internal set; }
            public string Title { get; internal set; }
        }
        class InternalSysInfoState
        {
            public IDictionary<string, InfoRow> Dictionary { get; internal set; }
            public List<InfoRow> RawRows { get; internal set; }
        }

        public InfoRow GetRow(string name) => 
            Dictionary.TryGetValue(name, out var ret) ? ret : null;

        public long? GetNullableLong(string name)
        {
            var row = GetRow(name);
            return row == null ? (long?)null : Convert.ToInt64(row.Value);
        }

        public long GetLong(string name) => GetNullableLong(name).GetValueOrDefault();

        // Meaningful outcome
        public int GetCpuCount() => (int)this.GetLong("cpu_count");

        public int GetPhysicalMemoryKb()
        {
            var physical_memory_in_bytes = this.GetNullableLong("physical_memory_in_bytes");
            var physical_memory_kb = this.GetNullableLong("physical_memory_kb");
            long? memKb = physical_memory_kb ?? (physical_memory_in_bytes / 1024);
            return (int)memKb.GetValueOrDefault();
        }

        public long GetAvailableMemoryKb()
        {
            // Azure: process_memory_limit_mb from sys.dm_os_job_object
            if (Management.IsAzure)
            {
                var sql = "select process_memory_limit_mb from sys.dm_os_job_object";
                var ret = this.Management.SqlConnection.ExecuteScalar<long>(sql, null, commandTimeout: this.Management.CommandTimeout);
                return ret * 1024;
            }

            var sysInfo = this;

            // 2012+
            var committed_Target_Kb = sysInfo.GetNullableLong("Committed_Target_Kb");
            var visible_Target_Kb = sysInfo.GetNullableLong("Visible_Target_Kb");
            var visibleKbMemory = GetMin(committed_Target_Kb, visible_Target_Kb);
            if (visibleKbMemory.HasValue && visibleKbMemory.GetValueOrDefault() > 0) return visibleKbMemory.Value;

            // 2005...2008R2
            var bpool_Commit_Target = sysInfo.GetNullableLong("Bpool_Commit_Target");
            var bpool_Visible = sysInfo.GetNullableLong("Bpool_Visible");
            long? visibleKbLegacy = GetMin(bpool_Commit_Target, bpool_Visible);
            if (visibleKbLegacy.HasValue) return 8 * visibleKbLegacy.Value;

            return 0;
        }

        public long GetCommittedMemoryKb()
        {
            var sysInfo = this;

            // 2012+
            var Committed_Kb = sysInfo.GetNullableLong("Committed_Kb");
            if (Committed_Kb.HasValue) return Committed_Kb.Value;

            // 2005...2008R2
            var bpool_Committed = sysInfo.GetNullableLong("Bpool_Committed");
            if (bpool_Committed.HasValue) return 8 * bpool_Committed.Value;

            return 0;
        }

        static long? GetMin(params long?[] values)
        {
            var notNull = values.Where(x => x.HasValue).ToArray();
            return notNull.Length == 0 ? null : notNull.Min();
        }

        private InternalSysInfoState BuildSysInfoState()
        {
            List<InfoRow> sqlSysInfoList = QueryRaw(this.Management.SqlConnection).ToList();
            Dictionary<string, InfoRow> di = new Dictionary<string, InfoRow>(StringComparer.OrdinalIgnoreCase);
            foreach (InfoRow row in sqlSysInfoList)
                di[row.Name] = row;

            InternalSysInfoState state = new InternalSysInfoState()
            {
                RawRows = sqlSysInfoList,
                Dictionary = di,
            };

            return state;

        }

        private ICollection<InfoRow> QueryRaw(IDbConnection connection)
        {
            var con = connection;
            object osSysInfoRaw = con.Query<object>("Select * from sys.dm_os_sys_info", null).FirstOrDefault();
            IDictionary<string, object> osSysInfoRawDictionary = (IDictionary<string, object>)osSysInfoRaw;
            List<InfoRow> ret = new List<InfoRow>();
            foreach (var pair in osSysInfoRawDictionary)
            {
                var name = pair.Key;
                // var title = currentCultureTextInfo.ToTitleCase(name.Replace("_", " "));
                var title = TitleCaseString.Produce(name.Replace("_", " "));
                ret.Add(new InfoRow() { Name = name, Value = pair.Value, Title = title });
            }
            // var props2 = TypeDescriptor.GetProperties(osSysInfoRaw);

            return ret;
        }

    }

    public static class SqlServerSysInfoExtensions
    {
        public static string Format(this SqlServerSysInfo sqlServerSysInfo)
        {
            return Format(sqlServerSysInfo, "\t");
        }

        public static string Format(this SqlServerSysInfo sqlServerSysInfo, string padding)
        {
            StringBuilder ret = new StringBuilder();
            foreach (var info in sqlServerSysInfo.RawRows)
            {
                var val = info.Value is long l ? l.ToString("n0") : Convert.ToString(info.Value);
                ret.AppendLine($"{padding}{info.Title}: {val}");
            }

            return ret.ToString();
        }
    }
}