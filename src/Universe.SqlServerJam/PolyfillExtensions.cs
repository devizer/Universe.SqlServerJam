using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Dapper;
using Universe.SqlServerJam.GenericSqlInterop;

namespace Universe.SqlServerJam
{

    public static class StringComparisonExtensions
    {
#if NETSTANDARD1_3
        public static readonly StringComparison IgnoreCase = StringComparison.OrdinalIgnoreCase;
#else
        public static readonly StringComparison IgnoreCase = StringComparison.InvariantCultureIgnoreCase;
#endif

    } 
    public static class StringJoinExtension
    {
        public static string JoinIntoString<T>(this IEnumerable<T> collection, string separator)
        {
            if (collection == null) return string.Empty;
            StringBuilder ret = new StringBuilder();
            bool first = true;
            foreach (var item in collection)
            {
                if (first) first = false;
                else ret.Append(separator);

                ret.Append(Convert.ToString(item));
            }

            return ret.ToString();
        }
    }
    
    public static class DapperExtensions
    {
#if NET35
        public static T ExecuteScalar<T>(this IDbConnection cnn, string sql)
        {
            // return cnn.ExecuteScalar<T>(sql, null, null, null, CommandType.Text);
            return cnn.ExecuteScalar2<T>(sql);
        }

        public static T ExecuteScalar<T>(this IDbConnection cnn, string sql, object parameters)
        {
            return cnn.ExecuteScalar<T>(sql, parameters, null, null, CommandType.Text);
        }

        // sp_who, sp_databases, SqlDefaultPaths
        public static IEnumerable<T> Query<T>(this IDbConnection cnn, string sql)
        {
            return cnn.Query<T>(sql, null, null, true, null, null);
        }

        public static void Execute(this IDbConnection cnn, string sql)
        {
            cnn.Execute2(sql);
        }

        public static void Execute(this IDbConnection cnn, string sql, int? commandTimeout)
        {
            cnn.Execute2(sql, commandTimeout.GetValueOrDefault());
        }
#else
#endif
    }
    
}

#if NETSTANDARD1_3
namespace System.ComponentModel
{
    public class DescriptionAttribute : Attribute
    {
        public DescriptionAttribute(string description)
        {
        }
    }
}

namespace System.Threading.Tasks
{
    public class Parallel
    {
        // Used for ProbeTransports only
        public static void ForEach<TSource>(
            IEnumerable<TSource> source,
            Action<TSource> body)
        {
            foreach (var item in source)
            {
                Task.Run(() => body(item)).GetAwaiter().GetResult();
            }
        }
    }
}
#endif

