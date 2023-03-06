using System;

namespace Universe.SqlServerJam
{
    [Flags]
    public enum FixedServerRoles
    {
        None = 0,
        BulkAdmin = 128,
        DbCreator = 64,
        DiskAdmin = 32,
        ProcessAdmin = 16,
        SecurityAdmin = 8,
        ServerAdmin = 4,
        SetupAdmin = 2,
        SysAdmin = 1,
    }
}