using System.Data;
using System.Runtime.CompilerServices;
using System.Text;

namespace Universe.SqlServerJam
{
    public static class SqlConnectionExtensions
    {

        public static SqlServerManagment GetSqlManagment(this IDbConnection connection)
        {
            return new SqlServerManagment(connection);
        }

    }
}

