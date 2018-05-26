using System.Data;

namespace Universe.SqlServerJam
{
    public static class SqlConnectionExtensions
    {
        // Any wrapper alike MiniProfiler is fully supported
        public static SqlServerManagement Manage(this IDbConnection connection)
        {
            return new SqlServerManagement(connection);
        }
    }
}

