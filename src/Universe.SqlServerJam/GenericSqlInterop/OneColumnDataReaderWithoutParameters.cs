using System;
using System.Data;
using System.Data.Common;
using System.Data.SqlClient;
using System.Linq;

namespace Universe.SqlServerJam.GenericSqlInterop
{
    public class OneColumnDataReader<TColumn, TParameters> : AbstractTinyDataReader<TColumn, TParameters>
    {
        public static readonly OneColumnDataReader<TColumn, TParameters> Instance = new OneColumnDataReader<TColumn, TParameters>();
        protected override TColumn ParseRow(IDataReader reader)
        {
            if (reader.IsDBNull(0)) return default;
            object rawValue = reader.GetValue(0);

            if (typeof(TColumn) == typeof(string)) return (TColumn) (object) Convert.ToString(rawValue);

            return (TColumn)rawValue;
        }
    }

    public class OneColumnDataReaderWithoutParameters<TColumn> : OneColumnDataReader<TColumn, NoAnyCommandParameters>
    {
        public new static readonly OneColumnDataReaderWithoutParameters<TColumn> Instance = new OneColumnDataReaderWithoutParameters<TColumn>();

        public TColumn ExecuteScalar(IDbConnection cnn, string sql)
        {
            return QueryFirstOrDefault(cnn, sql, NoAnyCommandParameters.Insance, 0);
        }
    }

    public static class OneColumnDataReaderWithoutParametersExtensions
    {
        public static TColumn ExecuteScalar2<TColumn>(this IDbConnection cnn, string sql)
        {
            return OneColumnDataReaderWithoutParameters<TColumn>.Instance.ExecuteScalar(cnn, sql);
        }
    }

}