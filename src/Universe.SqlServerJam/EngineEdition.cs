using System.ComponentModel;

namespace Universe.SqlServerJam
{
    public enum EngineEdition
    {
        [Description("Personal or Desktop Engine (Not available in SQL Server 2005 and later versions.)")]
        Personal = 1,

        [Description("Standard (This is returned for Standard, Web and Business Intelligence.)")]
        Standard = 2,

        [Description("Enterprise (This is returned for Evaluation, Developer, and Enterprise editions.)")]
        Enterprise = 3,

        [Description("Express (This is returned for Express, Express with Tools and Express with Advanced Services)")]
        Express = 4,

        [Description("SQL Database")]
        SQL_Database = 5,

        [Description("SQL Data Warehouse")]
        SQL_Data_Warehouse = 6,

    }
}