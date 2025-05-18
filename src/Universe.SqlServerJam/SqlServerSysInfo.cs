using System;
using System.Collections.Generic;
using System.Linq;
using Dapper;

namespace Universe.SqlServerJam
{
    public class SqlServerSysInfo
    {
        // DONE: Propagate IDbConnection here
        public SqlServerManagement Management { get; }

        internal SqlServerSysInfo(SqlServerManagement management)
        {
            Management = management;
            _SysInfoBag = new Lazy<SingleRowResultSet>(BuildSysInfoBag);
            _AzureProcessMemoryLimitKb = new Lazy<long>(GetAzureProcessMemoryLimitKb);
        }

        // Cache of * from sys.dm_os_sys_info
        private Lazy<SingleRowResultSet> _SysInfoBag;
        internal SingleRowResultSet SysInfoBag => _SysInfoBag.Value;


        // Meaningful outcome
        public int GetCpuCount() => (int)SysInfoBag.GetLong("cpu_count");

        public int GetPhysicalMemoryKb()
        {
            var bag = this._SysInfoBag.Value;
            var physical_memory_in_bytes = bag.GetNullableLong("physical_memory_in_bytes");
            var physical_memory_kb = bag.GetNullableLong("physical_memory_kb");
            long? memKb = physical_memory_kb ?? (physical_memory_in_bytes / 1024);
            return (int)memKb.GetValueOrDefault();
        }

        public long GetAvailableMemoryKb()
        {
            // Azure: process_memory_limit_mb from sys.dm_os_job_object
            if (Management.IsAzure) return _AzureProcessMemoryLimitKb.Value;

            var bag = this._SysInfoBag.Value;

            // 2012+
            var committed_Target_Kb = bag.GetNullableLong("Committed_Target_Kb");
            var visible_Target_Kb = bag.GetNullableLong("Visible_Target_Kb");
            var visibleKbMemory = GetMin(committed_Target_Kb, visible_Target_Kb);
            if (visibleKbMemory.HasValue && visibleKbMemory.GetValueOrDefault() > 0) return visibleKbMemory.Value;

            // 2005...2008R2
            var bpool_Commit_Target = bag.GetNullableLong("Bpool_Commit_Target");
            var bpool_Visible = bag.GetNullableLong("Bpool_Visible");
            long? visibleKbLegacy = GetMin(bpool_Commit_Target, bpool_Visible);
            if (visibleKbLegacy.HasValue) return 8 * visibleKbLegacy.Value;

            return 0;
        }

        public long GetCommittedMemoryKb()
        {
            var bag = this._SysInfoBag.Value;

            // 2012+
            var Committed_Kb = bag.GetNullableLong("Committed_Kb");
            if (Committed_Kb.HasValue) return Committed_Kb.Value;

            // 2005...2008R2
            var bpool_Committed = bag.GetNullableLong("Bpool_Committed");
            if (bpool_Committed.HasValue) return 8 * bpool_Committed.Value;

            return 0;
        }

        private Lazy<long> _AzureProcessMemoryLimitKb;
        private long GetAzureProcessMemoryLimitKb()
        {
            var sql = "select process_memory_limit_mb from sys.dm_os_job_object";
            var ret = this.Management.SqlConnection.ExecuteScalar<long>(sql, null, commandTimeout: this.Management.CommandTimeout);
            return ret * 1024;
        }

        private SingleRowResultSet BuildSysInfoBag()
        {
            var con = this.Management.SqlConnection;
            object osSysInfoRaw = con.Query<object>("Select * from sys.dm_os_sys_info", null).FirstOrDefault();
            IDictionary<string, object> di = (IDictionary<string, object>)osSysInfoRaw;
            return new SingleRowResultSet(di);
        }

        static long? GetMin(params long?[] values)
        {
            var notNull = values.Where(x => x.HasValue).ToArray();
            return notNull.Length == 0 ? null : notNull.Min();
        }
    }
}