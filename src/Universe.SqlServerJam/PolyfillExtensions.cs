using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam
{
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
            return cnn.ExecuteScalar<T>(sql, null, null, null, CommandType.Text);
        }

        public static T ExecuteScalar<T>(this IDbConnection cnn, string sql, object parameters)
        {
            return cnn.ExecuteScalar<T>(sql, parameters, null, null, CommandType.Text);
        }

        public static IEnumerable<T> Query<T>(this IDbConnection cnn, string sql)
        {
            return cnn.Query<T>(sql, null, null, true, null, null);
        }

        public static int Execute(this IDbConnection cnn, string sql)
        {
            return cnn.Execute(sql, null);
        }

        public static int Execute(this IDbConnection cnn, string sql, int? commandTimeout)
        {
            return cnn.Execute(sql, null, null, commandTimeout, CommandType.Text);
        }
#else
#endif
    }
}