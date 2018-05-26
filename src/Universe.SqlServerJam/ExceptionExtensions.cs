using System;
using System.Collections.Generic;

namespace Universe.SqlServerJam
{
    public static class ExceptionExtensions
    {
        public static string GetExeptionDigest(this Exception ex)
        {
            List<string> ret = new List<string>();
            while (ex != null)
            {
                ret.Add("[" + ex.GetType().Name + "] " + ex.Message);
                ex = ex.InnerException;
            }

            return string.Join(" --> ", ret);
        }

    }
}