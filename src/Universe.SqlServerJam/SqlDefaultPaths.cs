namespace Universe.SqlServerJam
{
    public class SqlDefaultPaths
    {
        public string DefaultData { get; set; }
        public string DefaultLog { get; set; }
        public string DefaultBackup { get; set; }

        public override string ToString()
        {
            return $"Data: {DefaultData}, Log: {DefaultLog}, Backup: {DefaultBackup}";
        }
    }
}