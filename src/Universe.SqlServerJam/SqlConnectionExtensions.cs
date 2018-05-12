using System.Data;
using System.Runtime.CompilerServices;
using System.Text;

namespace Universe.SqlServerJam
{
    public static class SqlConnectionExtensions
    {

        public static SqlServerManagement GetSqlManagment(this IDbConnection connection)
        {
            return new SqlServerManagement(connection);
        }

    }
}

