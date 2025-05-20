using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam
{

#if NET35 || NET40 || NET45
    public static class DapperQueryFirstOrDefaultPolyfill
    {
        public static T QueryFirstOrDefault<T>(this IDbConnection connection, string query, object parameters = null)
        {
            return connection.Query<T>(query, parameters).FirstOrDefault();
        }
    }
#endif

    public static class TitleCaseString
    {
        public static string Produce(string arg)
        {
            if (arg == null) return null;
            StringBuilder ret = new StringBuilder();
            bool prevSpace = true;
            foreach (var ch in arg)
            {
                bool isLetter = Char.IsLetter(ch);
                ret.Append((isLetter && prevSpace) ? Char.ToUpper(ch) : ch);
                prevSpace = !isLetter;
            }

            return ret.ToString();
        }
    }

    public static class StringComparisonExtensions
    {
#if NETSTANDARD1_4
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

        public static void Add(this DynamicParameters parameters, string name, object value)
        {
            if (value is string s)
                parameters.Add(name, value, DbType.String, ParameterDirection.Input, s.Length);
            else
                throw new ArgumentException("Unsupported value");
        }
        public static T ExecuteScalar<T>(this IDbConnection cnn, string sql)
        {
            return cnn.ExecuteScalar<T>(sql, null, null, null, CommandType.Text);
            // return cnn.ExecuteScalar2<T>(sql);
        }

        public static T ExecuteScalar<T>(this IDbConnection cnn, string sql, object parameters, int? commandTimeout = null)
        {
            return cnn.ExecuteScalar<T>(sql, parameters, null, null, CommandType.Text);
        }

        // sp_who, sp_databases, SqlDefaultPaths
        public static IEnumerable<T> Query<T>(this IDbConnection cnn, string sql)
        {
            return cnn.Query<T>(sql, null, null, true, null, null);
        }

        // return conn.Query<CategorySummaryEntity>(sql, null, commandTimeout: 100);
        public static IEnumerable<T> Query<T>(this IDbConnection cnn, string sql, object parameters, int? commandTimeout = 30)
        {
            
            return cnn.Query<T>(sql, parameters, null, true, commandTimeout, null);
        }


        public static void Execute(this IDbConnection cnn, string sql)
        {
            cnn.Execute(sql, null, null, null, CommandType.Text);            
            // cnn.Execute2(sql);
        }

        public static void Execute(this IDbConnection cnn, string sql, int? commandTimeout)
        {
            cnn.Execute(sql, commandTimeout.GetValueOrDefault(), null, commandTimeout.GetValueOrDefault(), CommandType.Text);
        }
#else
#endif
    }

}

namespace System
{
    public static class EnvironmentExtensions
    {
        public static string MachineName
        {
            get
            {
#if NETSTANDARD1_4
                return Environment.GetEnvironmentVariable("COMPUTERNAME") ?? Environment.GetEnvironmentVariable("HOSTNAME");
#else
                return Environment.MachineName;
#endif
            }
        }
    }
}

#if NETSTANDARD1_4
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
            var waiters = source
                .Select(item => Task.Run(() => body(item)))
                .Select(task => task.ConfigureAwait(false).GetAwaiter())
                .ToList();

            // Used for ProbeTransports only. Exceptions except OOM are not possible
            waiters.ForEach(x => x.GetResult());

            /*
            foreach (var item in source)
            {
                Task.Run(() => body(item)).ConfigureAwait(false).GetAwaiter().GetResult();
            }
        */
        }
    }
}
#endif

