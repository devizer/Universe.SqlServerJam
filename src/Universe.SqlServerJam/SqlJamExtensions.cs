namespace Universe.SqlServerJam;

public static class SqlJamExtensions
{
    public static string Escape(string identifier)
    {
        return identifier?.Replace("]", "]]");
    }
}