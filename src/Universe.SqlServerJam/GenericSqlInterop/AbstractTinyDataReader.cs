using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices;

namespace Universe.SqlServerJam.GenericSqlInterop
{
    public abstract class AbstractTinyDataReader<TRow, TParameters>
    {
        protected virtual void BuildParameters(IDbCommand command, TParameters parameters)
        {
        }

        protected virtual void CatchColumnIndexes(IDataReader reader)
        {
        }

        protected abstract TRow ParseRow(IDataReader reader);

        private bool IsFirst = true;

        public TRow QuerySingle(IDbConnection cnn, string sql, TParameters parameters, int commandTimeout)
        {
            return Query(cnn, sql, QueryBehaviour.Single, parameters, commandTimeout).Single();
        }

        public TRow QueryFirstOrDefault(IDbConnection cnn, string sql, TParameters parameters, int commandTimeout)
        {
            return Query(cnn, sql, QueryBehaviour.FirstOrDefault, parameters, commandTimeout).Single();
        }

        public IEnumerable<TRow> Query(IDbConnection cnn, string sql, QueryBehaviour behaviour, TParameters parameters)
        {
            return Query(cnn, null, sql, behaviour,  parameters, 0);
        }

        public IEnumerable<TRow> Query(IDbConnection cnn, string sql, QueryBehaviour behaviour, TParameters parameters, int commandTimeout)
        {
            return Query(cnn, null, sql, behaviour, parameters, commandTimeout);
        }

        public IEnumerable<TRow> Query(IDbConnection cnn, IDbTransaction transaction, string sql, QueryBehaviour behaviour, TParameters parameters)
        {
            return Query(cnn, transaction, sql, behaviour, parameters, 0);
        }

        public IEnumerable<TRow> Query(IDbConnection cnn, IDbTransaction transaction, string sql, QueryBehaviour behaviour, TParameters parameters,
            int commandTimeout)
        {
            var state = cnn.State;
            byte totalRows = 0;
            using (IDbCommand cmd = cnn.CreateCommand())
            {
                cmd.Connection = cnn;
                if (transaction != null) cmd.Transaction = transaction;
                if (state == ConnectionState.Closed) cnn.Open();
                try
                {
                    cmd.CommandText = sql;
                    cmd.CommandTimeout = commandTimeout;
                    
                    BuildParameters(cmd, parameters);

                    CommandBehavior beh = CommandBehavior.Default | CommandBehavior.SingleResult;
                    if (state == ConnectionState.Closed) beh |= CommandBehavior.CloseConnection;
                    if (behaviour == QueryBehaviour.Single || behaviour == QueryBehaviour.FirstOrDefault) beh |= CommandBehavior.SingleRow;


                    if (behaviour == QueryBehaviour.NoAnyResults)
                    {
                        cmd.ExecuteNonQuery();
                        yield break;
                    }
                    else
                    {
                        IDataReader reader = cmd.ExecuteReader(beh);
                        if (IsFirst)
                        {
                            CatchColumnIndexes(reader);
                            IsFirst = false;
                        }

                        while (reader.Read())
                        {
                            if (totalRows < 2) totalRows++;
                            yield return ParseRow(reader);
                        }
                    }

                }
                finally
                {
                    if (state == ConnectionState.Closed) cnn.Close();

                    string getTotalRowsInfo(byte arg)
                    {
                        if (arg == 0) return "no any rows";
                        else if (arg == 1) return "exactly one row";
                        else return "more then one row";
                    }


                    if (behaviour == QueryBehaviour.Single && totalRows != 1)
                        throw new Exception($"Single row expected, but {getTotalRowsInfo(totalRows)} obtained total");
                }
            }
        }
    }

    public enum QueryBehaviour
    {
        Enumerable,
        Single,
        FirstOrDefault,
        NoAnyResults,
    }
}