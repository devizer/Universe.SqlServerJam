using System;
using System.Data;

namespace Universe.SqlServerJam.GenericSqlInterop
{
    public class SqlExecutorWithoutResults<TParameters> : AbstractTinyDataReader<NoAnyResultSet, TParameters>
    {
        public new static readonly SqlExecutorWithoutResults<TParameters> Instance = new SqlExecutorWithoutResults<TParameters>();

        protected override NoAnyResultSet ParseRow(IDataReader reader)
        {
            throw new Exception("ParseRow() call is unbelievable");
        }
    }

    public static class SqlExecutorWithoutResultsExtensions
    {
        public static void Execute2(this IDbConnection cnn, string sql, int commandTimeout)
        {
            SqlExecutorWithoutResults<NoAnyCommandParameters>.Instance
                .Query(cnn, sql, QueryBehaviour.NoAnyResults, NoAnyCommandParameters.Insance, commandTimeout);
        }

        public static void Execute2(this IDbConnection cnn, string sql)
        {
            Execute2(cnn, sql, 0);
        }

    }

}
