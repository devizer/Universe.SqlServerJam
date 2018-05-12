using System.ComponentModel;

namespace Universe.SqlServerJam
{
    public enum SecurityMode
    {
        [Description("Integrated security (Windows Authentication) only")]
        IntegratedOnly = 1,

        [Description("Both Windows Authentication and SQL Server Authentication")]
        Both = 0,
    }
}