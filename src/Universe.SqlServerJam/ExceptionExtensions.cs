using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;

namespace Universe.SqlServerJam
{
    public static class ExceptionExtensions
    {
        public static string GetExeptionDigest(this Exception ex)
        {
            List<string> ret = new List<string>();
            while (ex != null)
            {
                SqlException sqlex = ex as SqlException;
                string sqlError = sqlex?.Errors.OfType<SqlError>().Select(x => x.Number).JoinIntoString(",") ?? "";
                ret.Add("[" + ex.GetType().Name + (sqlError == "" ? "" : " ") + sqlError + "] " + ex.Message);
                ex = ex.InnerException;
            }

            return ret.JoinIntoString(" --> ");
        }

    }
}