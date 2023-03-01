using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Universe.SqlServerJam
{
    public static class ExceptionExtensions
    {
        public static string GetExceptionDigest(this Exception exception)
        {
            List<string> ret = new List<string>();
            // while (ex != null)
            foreach(var ex in AsPlainExceptionList(exception))
            {
                SqlException sqlex = ex as SqlException;
                string sqlError = sqlex?.Errors.OfType<SqlError>().Select(x => x.Number).JoinIntoString(",") ?? "";
                ret.Add("[" + ex.GetType().Name + (sqlError.Length == 0 ? "" : " ") + sqlError + "] " + ex.Message);
            }

            return ret.JoinIntoString(" --> ");
        }

        public static IEnumerable<Exception> AsPlainExceptionList(this Exception ex)
        {
            while (ex != null)
            {
                if (ex is AggregateException ae)
                {
                    foreach (var subException in ae.Flatten().InnerExceptions)
                    {
                        yield return subException;
                    }
                    yield break;
                }

                yield return ex;
                ex = ex.InnerException;
            }
        }


    }
}