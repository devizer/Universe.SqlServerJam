using System;
using System.Data.Common;

namespace Universe.SqlServerJam
{
    public static class SqlServerJamConfigurationExtensions
    {
        public static DbConnection CreateConnection(this DbProviderFactory factory, string connectionString)
        {
            if (factory == null) throw new ArgumentNullException(nameof(factory));
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            if (string.IsNullOrEmpty(connectionString)) throw new ArgumentException("connectionString argument is empty", nameof(connectionString));

            var ret = factory.CreateConnection();
            ret.ConnectionString = connectionString;
            return ret;
        }

        public static DbConnection CreateConnection(string connectionString)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            if (string.IsNullOrEmpty(connectionString)) throw new ArgumentException("connectionString argument is empty", nameof(connectionString));

            var ret = SqlServerJamConfiguration.SqlProviderFactory.CreateConnection();
            ret.ConnectionString = connectionString;
            return ret;
        }


        public static string GetDataSource(string connectionString)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));

            var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            b.ConnectionString = connectionString;
            return b["Data Source"]?.ToString();
        }

        public static string ResetConnectionTimeout(string connectionString, int? timeout)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            b.ConnectionString = connectionString;
            if (timeout == null)
                b["Timeout"] = null;
            else
                b["Timeout"] = timeout.Value;

            return b.ConnectionString;
        }

        public static string GetClientSizeDataSource(string connectionString)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            b.ConnectionString = connectionString;
            return b["Data Source"]?.ToString();
        }

        public static string ResetConnectionPooling(string connectionString, bool? pooling)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            b.ConnectionString = connectionString;
            if (pooling == null)
                b["Pooling"] = null;
            else
                b["Pooling"] = pooling.Value;

            return b.ConnectionString;
        }


        public static string ResetConnectionDatabase(string connectionString, string initialCatalog)
        {
            if (connectionString == null) throw new ArgumentNullException(nameof(connectionString));
            var b = SqlServerJamConfiguration.SqlProviderFactory.CreateConnectionStringBuilder();
            b.ConnectionString = connectionString;
            if (initialCatalog == null)
                b["Initial Catalog"] = null;
            else
                b["Initial Catalog"] = initialCatalog;

            return b.ConnectionString;
        }


        public static DbCommand CreateDbCommand(string sqlCommandText, DbConnection con)
        {
            var ret = SqlServerJamConfiguration.SqlProviderFactory.CreateCommand();
            ret.CommandText = sqlCommandText;
            ret.Connection = con;
            return ret;



        }
    }
}