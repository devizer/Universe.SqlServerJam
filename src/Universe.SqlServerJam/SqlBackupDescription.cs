using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;

namespace Universe.SqlServerJam
{
    public class SqlBackupDescription
    {
        public List<SqlBackupHeaderDescription> Header { get; }
        public List<BackupFileDescription> FileList { get; }

        public SqlBackupDescription(List<SqlBackupHeaderDescription> header, List<BackupFileDescription> fileList)
        {
            Header = header;
            FileList = fileList;
        }

        public override string ToString()
        {
            StringBuilder b = new StringBuilder();
            b.AppendLine("Backup History");
            foreach (SqlBackupHeaderDescription header in Header)
                b.AppendLine(header.ToString());

            b.AppendLine("Backup File List");
            foreach (var file in this.FileList)
                b.AppendLine(file.ToString());

            return b.ToString();
        }
    }

    public class SqlBackupHeaderDescription
    {
        public int Position { get; set; }
        public DateTime? ExpirationDate { get; set; }
        public string DatabaseName { get; set; }
        public string Collation { get; set; }
        public string RecoveryModel { get; set; }
        public string UserName { get; set; }
        public string BackupName { get; set; }
        public string BackupDescription { get; set; }
        public int BackupType { get; set; }
        public SqlBackupType StrictBackupType => (SqlBackupType) BackupType;
        public string BackupTypeDescription { get; set; }

        public int SoftwareVersionMajor { get; set; }
        public int SoftwareVersionMinor { get; set; }
        public int SoftwareVersionBuild { get; set; }
        public Version SqlServerVersion => new Version(SoftwareVersionMajor, SoftwareVersionMinor, SoftwareVersionBuild);

        public int Flags { get; set; }
        public SqlBackupFlags StrictFlags => (SqlBackupFlags) Flags;

        public override string ToString()
        {
            return $"{nameof(Position)}: {Position}, {nameof(ExpirationDate)}: {ExpirationDate}, {nameof(DatabaseName)}: {DatabaseName}, {nameof(Collation)}: {Collation}, {nameof(RecoveryModel)}: {RecoveryModel}, {nameof(UserName)}: {UserName}, {nameof(BackupName)}: {BackupName}, {nameof(BackupDescription)}: {BackupDescription}, {nameof(BackupType)}: {BackupType}, {nameof(StrictBackupType)}: {StrictBackupType}, {nameof(BackupTypeDescription)}: {BackupTypeDescription}, {nameof(SoftwareVersionMajor)}: {SoftwareVersionMajor}, {nameof(SoftwareVersionMinor)}: {SoftwareVersionMinor}, {nameof(SoftwareVersionBuild)}: {SoftwareVersionBuild}, {nameof(SqlServerVersion)}: {SqlServerVersion}, {nameof(Flags)}: {Flags}, {nameof(StrictFlags)}: {StrictFlags}";
        }
    }

    public enum SqlBackupType
    {
        Unknown = 0,
        Database = 1,
        TransactionLog = 2,
        File = 4,
        DifferentialDatabase = 5,
        DifferentialFile = 6,
        Partial = 7,
        DifferentialPartial = 8,
    }

    [Flags]
    public enum SqlBackupFlags
    {
        Log_Backup_Contains_Bulk_Logged_Operations = 1,
        Snapshot_Backup = 2,
        Database_Was_ReadOnly_When_Backed_Up = 4,
        Database_Was_In_SingleUser_Mode_When_Backed_Up = 8,
        Backup_Contains_Backup_Checksums = 16,
        Database_Was_Damaged_When_Backed_Up_But_The_Backup_Operation_Was_Requested_To_Continue_Despite_Errors = 32,
        Tail_Log_Backup = 64,
        Tail_Log_Backup_With_Incomplete_Metadata = 128,
        Tail_Log_Backup_With_Norecovery = 256,
    }

    public class BackupFileDescription
    {
        public string LogicalName { get; set; }
        public string PhysicalName { get; set; }
        public string Type { get; set; } // D|L|F|S
        public BackFileType StrictType => TryParseBackupFileType(Type);
        public string FileGroupName { get; set; }
        public bool IsReadOnly { get; set; }
        public bool IsPresent { get; set; }
        public string SnapshotURL { get; set; }
        public long Size { get; set; }
        public long BackupSizeInBytes { get; set; }

        public override string ToString()
        {
            return $"{nameof(LogicalName)}: {LogicalName}, {nameof(PhysicalName)}: {PhysicalName}, {nameof(Type)}: {Type}, {nameof(StrictType)}: {StrictType}, {nameof(FileGroupName)}: {FileGroupName}, {nameof(IsReadOnly)}: {IsReadOnly}, {nameof(IsPresent)}: {IsPresent}, {nameof(SnapshotURL)}: {SnapshotURL}, {nameof(Size)}: {Size}, {nameof(BackupSizeInBytes)}: {BackupSizeInBytes}";
        }

        public static BackFileType TryParseBackupFileType(string rawType)
        {
            var ignore = StringComparison.OrdinalIgnoreCase;
            if ("D".Equals(rawType, ignore)) return BackFileType.Data;
            else if ("L".Equals(rawType, ignore)) return BackFileType.Log;
            else if ("F".Equals(rawType, ignore)) return BackFileType.FullTextCatalog;
            else if ("S".Equals(rawType, ignore)) return BackFileType.FileStreamOrInMemoryContainer;
            else return BackFileType.Unknown;
        }

    }

    public enum BackFileType
    {
        Unknown = 0,
        Data = 1,
        Log = 2,
        FullTextCatalog = 3,
        FileStreamOrInMemoryContainer = 4,
    }
}
