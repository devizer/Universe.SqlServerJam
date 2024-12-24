﻿using System;
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

        public static DbCommand CreateDbCommand(string sqlCommandText, DbConnection con)
        {
            var ret = SqlServerJamConfiguration.SqlProviderFactory.CreateCommand();
            ret.CommandText = sqlCommandText;
            ret.Connection = con;
            return ret;



        }
    }
}