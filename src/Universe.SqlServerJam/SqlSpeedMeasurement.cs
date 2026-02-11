using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Diagnostics;
using Dapper;

namespace Universe.SqlServerJam
{
    public class SqlSpeedMeasurement
    {
        private readonly string ConnectionString;
        private readonly bool _IsLocal;

        public SqlSpeedMeasurement(string connectionString)
        {
            ConnectionString = connectionString;
        }


        public double GetPing(int limitCount = 20000, int milliSecondsLimit = 3000)
        {
            using (DbConnection con = SqlServerJamConfiguration.SqlProviderFactory.CreateConnection(ConnectionString))
            {
                con.Open();

                // Prepare JIT-compilation and Execution plan.
                GetPing_Impl(con, 1, 1);

                long limitTicks = (long)(milliSecondsLimit / 1000m * Stopwatch.Frequency);
                return GetPing_Impl(con, limitCount, limitTicks);
            }
        }

        public double GetUploadSpeed(
            int limitIterations = 1000000, int blockSizeInKb = 1024,
            int limitMilliSeconds = 10000)
        {
            byte[] random = new byte[blockSizeInKb * 1024];
            new Random().NextBytes(random);

            using (DbConnection con = SqlServerJamConfiguration.SqlProviderFactory.CreateConnection(ConnectionString))
            {
                con.Open();

                long limitTicks = (long)(limitMilliSeconds / 1000d * Stopwatch.Frequency);
                GetUploadSpeed_Impl(con, new byte[1], 1, 1);
                return GetUploadSpeed_Impl(con, random, limitIterations, limitTicks);
            }
        }

        public double GetDownloadSpeed(
            int limitIterations = 1000, int blockSizeInKb = 1024,
            int limitMilliSeconds = 10000)
        {
            byte[] random = new byte[blockSizeInKb * 1024];
            new Random().NextBytes(random);
            var tableName = "##T" + Guid.NewGuid().ToString("N");

            using (DbConnection con = SqlServerJamConfigurationExtensions.CreateConnection(ConnectionString))
            {
                con.Open();

                con.Execute($"Create Table {tableName}(d image); Insert {tableName} values(@arg);", new {arg = random});

                long limitTicks = (long)(limitMilliSeconds / 1000d * Stopwatch.Frequency);
                GetDownloadSpeed_Impl(con, tableName, 1, 1);
                var ret = GetDownloadSpeed_Impl(con, tableName, limitIterations, limitTicks);
                con.Execute($"Drop Table {tableName};");
                return ret;
            }
        }


        static double Ticks2Milliseconds(long ticks)
        {
            return ticks * 1000d / (double) Stopwatch.Frequency;
        }

        private static double GetPing_Impl(DbConnection con, int limitCount, long limitTicks)
        {
            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            while (count < limitCount)
            {
                using (DbCommand cmd = SqlServerJamConfiguration.SqlProviderFactory.CreateDbCommand("Select Null", con))
                {
                    cmd.ExecuteNonQuery();
                }
                count++;
                ticks = sw.ElapsedTicks;
                if (count > limitCount || ticks >= limitTicks) break;
            }

            var msecs = Ticks2Milliseconds(ticks);
            var ret = msecs / count;
            return ret;
        }

        static double GetUploadSpeed_Impl(DbConnection con, byte[] param, int countLimit, long ticksLimit)
        {
            const string sql = "Select DataLength(@arg);";

            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            while (count < countLimit)
            {
                // using (SqlCommand cmd = new SqlCommand(sql, con))
                using (DbCommand cmd = SqlServerJamConfiguration.SqlProviderFactory.CreateDbCommand(sql, con))
                {
                    // cmd.Parameters.Add("@arg", SqlDbType.Image, param.Length).Value = param;
                    var p = SqlServerJamConfiguration.SqlProviderFactory.CreateParameter();
                    p.DbType = DbType.Binary;
                    p.ParameterName = "@arg";
                    p.Size = param.Length;
                    p.Value = param;
                    cmd.Parameters.Add(p);

                    cmd.ExecuteNonQuery();
                }
                count++;
                ticks = sw.ElapsedTicks;
                if (count > countLimit || ticks >= ticksLimit) break;
            }

            var msecs = Ticks2Milliseconds(ticks);
            var ret = (double)count * param.Length / 1024d / (msecs / 1000d);
            return ret;
        }

        static double GetDownloadSpeed_Impl(DbConnection con, string tableName, int countLimit, long ticksLimit)
        {
            string sql = $"Select Top 1 d From {tableName};";

            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            int blobLength = -1;
            while (count < countLimit)
            {
                // using (SqlCommand cmd = new SqlCommand(sql, con))
                using(DbCommand cmd = SqlServerJamConfigurationExtensions.CreateDbCommand(sql, con))
                {
                    var blob = cmd.ExecuteScalar();
                    blobLength = ((byte[]) blob).Length;
                }
                count++;
                ticks = sw.ElapsedTicks;
                if (count > countLimit || ticks >= ticksLimit) break;
            }

            var msecs = Ticks2Milliseconds(ticks);
            var ret = (double)count * blobLength / 1024d / (msecs / 1000d);
            return ret;
        }
    }
}
