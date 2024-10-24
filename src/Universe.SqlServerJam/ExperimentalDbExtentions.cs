using System.Data;
using System.Threading;
using System.Threading.Tasks;
using Dapper;

namespace Universe.SqlServerJam
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

    public class RdbmsInfo
    {
        public RdbmsFamily Family { get; set; }
        public string Version { get; set; }

        public override string ToString()
        {
            return $"{Family}{(Family != RdbmsFamily.Unknown ? ", " + Version : "")}";
        }
    }

    public static class ExperimentalDbExtentions
    {
        public static RdbmsInfo GetRdbmsFamily(this IDbConnection connection)
        {
            var checkers = new[]
            {
                new
                {
                    Kind = RdbmsFamily.MSSQLServer,
                    VerQuery = "Select Cast(ServerProperty('ProductVersion') as nvarchar) + ' (' + Cast(ServerProperty('Edition') as nvarchar) + ')';",
                    SpecificProbe = new[]{ "Declare @v nvarchar(4000); Set @v = Cast(@@VERSION as nvarchar);" }
                },
                new
                {
                    Kind = RdbmsFamily.SQLite,
                    VerQuery = "Select sqlite_version();",
                    SpecificProbe = new[] { "PRAGMA encoding;" }
                },
                new
                {
                    Kind = RdbmsFamily.MySQL,
                    VerQuery = "Select Version();",
                    SpecificProbe = new[] { "Show Variables Like \"VERSION\";" }
                },
                new
                {
                    Kind = RdbmsFamily.Postgre,
                    VerQuery = "Select Version();",
                    SpecificProbe = new[] { @"
DO $$DECLARE i DECIMAL;
BEGIN
  i = 42;
END$$;
" }
                },
                new
                {
                    Kind = RdbmsFamily.Oracle,
                    VerQuery = "SELECT * FROM V$VERSION",
                    SpecificProbe = new[] { @"
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

            IDbConnection temp = connection;
            // PARALLEL QUERIES might be WRONG!
            foreach (var check in checkers)
            {
                try
                {
                    foreach (var probeSql in check.SpecificProbe) connection.Execute(probeSql);
                    string ver = connection.ExecuteScalar<string>(check.VerQuery);
                    return new RdbmsInfo()
                    {
                        Family = check.Kind,
                        Version = ver,
                    };
                }
                catch
                {
                }
            }

            return new RdbmsInfo() {Family = RdbmsFamily.Unknown};
        }

    }
}
