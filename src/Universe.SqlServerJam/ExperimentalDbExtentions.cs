using System.Data;
using Dapper;

namespace Universe.SqlServerJam
{
    public static class ExperimentalDbExtentions
    {
        public enum RdbmsFamily
        {
            Unknown,
            MSSQLServer,
            SQLite,
            MySQL,
            Postgre,
            Oracle,
        }

        public static RdbmsFamily GetRdbmsFamily(this IDbConnection connection)
        {
            var checkers = new[]
            {
                new
                {
                    Kind = RdbmsFamily.MSSQLServer, SqlVersion = "Select @@VERSION",
                    Probe = new string[0],
                },
                new
                {
                    Kind = RdbmsFamily.SQLite, SqlVersion = "Select sqlite_version();",
                    Probe = new[] { "PRAGMA encoding;" }
                },
                new
                {
                    Kind = RdbmsFamily.MySQL, SqlVersion = "Select Version();",
                    Probe = new[] { "Show Variables Like \"VERSION\";" }
                },
                new
                {
                    Kind = RdbmsFamily.Postgre, SqlVersion = "Select Version();",
                    Probe = new[] { @"
DO $$DECLARE i DECIMAL;
BEGIN
  i = 42;
END$$;
" }
                },
                new
                {
                    Kind = RdbmsFamily.Oracle, SqlVersion = "SELECT * FROM V$VERSION",
                    Probe = new[] { @"
DECLARE
  p1 PLS_INTEGER := 40;
  p2 PLS_INTEGER := 2;
  n NUMBER;
  s varchar2(3 char);
BEGIN
  n := p1 + p2;
  s := to_char(n);
  DBMS_OUTPUT.put_line (s || ' is 3');
END;
" }
                },
            };

            // SQLite: 3.15.2 (2017) | 3.6.23 (2010)
            // PostgreSQL 9.6.3 on x86_64-pc-linux-gnu, compiled by gcc (GCC) 4.9.3, 64-bit
            // PostgreSQL 9.1.24lts2 on x86_64-unknown-linux-gnu, compiled by gcc (Debian 4.7.2-5) 4.7.2, 64-bit
            // Oracle Database 12c Enterprise Edition Release 12.1.0.2.0 - 64bit Production

            connection.OpenIfClosed();
            foreach (var check in checkers)
            {
                try
                {
                    foreach (var probe in check.Probe)
                        connection.Execute(probe);

                    string ver = connection.ExecuteScalar<string>(check.SqlVersion);
                    return check.Kind;
                }
                catch
                {
                }
            }

            return RdbmsFamily.Unknown;
        }


    }
}
