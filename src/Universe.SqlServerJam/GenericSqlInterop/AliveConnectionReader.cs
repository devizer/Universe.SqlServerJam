using System.Data;

namespace Universe.SqlServerJam.GenericSqlInterop
{
    public class AliveConnection
    {
        public int SessionId { get; set; }
        public string DatabaseName { get; set; }
    }

    public class AliveConnectionReader : AbstractTinyDataReader<AliveConnection, NoAnyCommandParameters>
    {
        public static readonly AliveConnectionReader Instance = new AliveConnectionReader();

        private static int IndexSPID = -1, IndexDbName = -1;

        protected override void CatchColumnIndexes(IDataReader reader)
        {
            IndexSPID = reader.GetOrdinal("spid");
            IndexDbName = reader.GetOrdinal("dbname");
        }

        protected override AliveConnection ParseRow(IDataReader reader)
        {
            return new AliveConnection()
            {
                SessionId = reader.IsDBNull(IndexSPID) ? default : reader.GetInt32(IndexSPID),
                DatabaseName = reader.IsDBNull(IndexDbName) ? default : reader.GetString(IndexDbName),
            };
        }
    }
}