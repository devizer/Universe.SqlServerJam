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
        public int CpuCount { get; set; }
        public int PhysicalMemoryKb { get; set; }

        public IDictionary<string, InfoRow> Dictionary { get; set; }
        public List<InfoRow> RawRows { get; set; }

        public InfoRow GetRow(string name) => 
            Dictionary.TryGetValue(name, out var ret) ? ret : null;

        public long? GetNullableLong(string name)
        {
            var row = GetRow(name);
            return row == null ? (long?)null : Convert.ToInt64(row.Value);
        }

        public long GetLong(string name) => GetNullableLong(name).GetValueOrDefault();

        public class InfoRow
        {
            public string Name;
            public object Value;
            public string Title;

            private sealed class NameEqualityComparer : IEqualityComparer<InfoRow>
            {
                public bool Equals(InfoRow x, InfoRow y)
                {
                    if (ReferenceEquals(x, y)) return true;
                    if (ReferenceEquals(x, null)) return false;
                    if (ReferenceEquals(y, null)) return false;
                    if (x.GetType() != y.GetType()) return false;
                    return x.Name == y.Name;
                }

                public int GetHashCode(InfoRow obj)
                {
                    return (obj.Name != null ? obj.Name.GetHashCode() : 0);
                }
            }

            public static IEqualityComparer<InfoRow> NameComparer { get; } = new NameEqualityComparer();
        }

        public static SqlServerSysInfo Query(IDbConnection connection)
        {
            List<InfoRow> sqlSysInfoList = QueryRaw(connection).ToList();
            Dictionary<string, InfoRow> di = new Dictionary<string, InfoRow>(StringComparer.OrdinalIgnoreCase);
            foreach (InfoRow row in sqlSysInfoList)
                di[row.Name] = row;

            SqlServerSysInfo ret = new SqlServerSysInfo()
            {
                RawRows = sqlSysInfoList,
                Dictionary = di
            };

            ret.CpuCount = (int)ret.GetLong("cpu_count");
            
            var physical_memory_in_bytes = ret.GetNullableLong("physical_memory_in_bytes");
            var physical_memory_kb = ret.GetNullableLong("physical_memory_kb");
            long? memKb = physical_memory_kb ?? (physical_memory_in_bytes / 1024);
            ret.PhysicalMemoryKb = (int)memKb.GetValueOrDefault();

            return ret;
        }

        public static ICollection<InfoRow> QueryRaw(IDbConnection connection)
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