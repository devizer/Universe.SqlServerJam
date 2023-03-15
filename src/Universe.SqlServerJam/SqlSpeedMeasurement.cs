using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using Dapper;
using Universe.SqlServerJam.GenericSqlInterop;

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


        public decimal GetPing(int limitCount = 20000, int milliSecondsLimit = 3000)
        {
            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();

                // Prepare JIT-compilation and Execution plan.
                long limitTicks = (long)(milliSecondsLimit / 1000m * Stopwatch.Frequency);
                GetPing_Impl(con, 1, 1);

                return GetPing_Impl(con, limitCount, limitTicks);
            }
        }

        public decimal GetUploadSpeed(
            int limitIterations = 1000000, int blockSizeInKb = 1024,
            int limitMilliSeconds = 10000)
        {
            byte[] random = new byte[blockSizeInKb * 1024];
            new Random().NextBytes(random);

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();

                long limitTicks = (long)(limitMilliSeconds / 1000m * Stopwatch.Frequency);
                GetUploadSpeed_Impl(con, new byte[8001], 1, 1);
                return GetUploadSpeed_Impl(con, random, limitIterations, limitTicks);
            }
        }

        public decimal GetDownloadSpeed(
            int limitIterations = 1000, int blockSizeInKb = 1024,
            int limitMilliSeconds = 10000)
        {
            byte[] random = new byte[blockSizeInKb * 1024];
            new Random().NextBytes(random);
            var tableName = "##T" + Guid.NewGuid().ToString("N");

            using (SqlConnection con = new SqlConnection(ConnectionString))
            {
                con.Open();

                con.Execute($"Create Table {tableName}(d image); Insert {tableName} values(@arg);", new {arg = random});

                long limitTicks = (long)(limitMilliSeconds / 1000m * Stopwatch.Frequency);
                GetDownloadSpeed_Impl(con, tableName, 1, 1);
                var ret = GetDownloadSpeed_Impl(con, tableName, limitIterations, limitTicks);
                con.Execute2($"Drop Table {tableName};");
                return ret;
            }
        }


        static decimal Ticks2Milliseconds(long ticks)
        {
            return ticks / (decimal) Stopwatch.Frequency * 1000m;
        }

        private static decimal GetPing_Impl(SqlConnection con, int limitCount, long limitTicks)
        {
            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            while (count < limitCount)
            {
                using (SqlCommand cmd = new SqlCommand("Select Null", con))
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

        static decimal GetUploadSpeed_Impl(SqlConnection con, byte[] param, int countLimit, long ticksLimit)
        {
            const string sql = "Select DataLength(@arg);";

            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            while (count < countLimit)
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.Add("@arg", SqlDbType.Image, param.Length).Value = param;
                    cmd.ExecuteNonQuery();
                }
                count++;
                ticks = sw.ElapsedTicks;
                if (count > countLimit || ticks >= ticksLimit) break;
            }

            var msecs = Ticks2Milliseconds(ticks);
            var ret = Convert.ToDecimal(count) * Convert.ToDecimal(param.Length) / 1024m / (msecs / 1000m);
            return ret;
        }

        static decimal GetDownloadSpeed_Impl(SqlConnection con, string tableName, int countLimit, long ticksLimit)
        {
            string sql = $"Select Top 1 d From {tableName};";

            int count = 0;
            var sw = Stopwatch.StartNew();
            long ticks = 0L;
            int blobLength = -1;
            while (count < countLimit)
            {
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    var blob = cmd.ExecuteScalar();
                    blobLength = ((byte[]) blob).Length;
                }
                count++;
                ticks = sw.ElapsedTicks;
                if (count > countLimit || ticks >= ticksLimit) break;
            }

            var msecs = Ticks2Milliseconds(ticks);
            var ret = Convert.ToDecimal(count) * Convert.ToDecimal(blobLength) / 1024m / (msecs / 1000m);
            return ret;
        }
    }
}
