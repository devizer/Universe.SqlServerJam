using System;
using System.Collections.Generic;
using System.Text;

namespace Universe.SqlServerJam;

// Intended for variable column set
public class SingleRowResultSet
{
    public IDictionary<string, InfoRow> Dictionary { get; internal set; }
    public List<InfoRow> RawRows { get; internal set; }

    public InfoRow GetRow(string name) =>
        Dictionary.TryGetValue(name, out var ret) ? ret : null;

    public long? GetNullableLong(string name)
    {
        var row = GetRow(name);
        return row == null ? (long?)null : Convert.ToInt64(row.Value);
    }

    public long GetLong(string name) => GetNullableLong(name).GetValueOrDefault();


    public SingleRowResultSet(IDictionary<string, object> rawSingleRow)
    {
        if (rawSingleRow == null) throw new ArgumentNullException(nameof(rawSingleRow));

        RawRows = new List<InfoRow>(rawSingleRow.Count);
        Dictionary<string, InfoRow> di = new Dictionary<string, InfoRow>(StringComparer.OrdinalIgnoreCase);

        foreach (var pair in rawSingleRow)
        {
            var name = pair.Key;
            var title = TitleCaseString.Produce(name.Replace("_", " "));
            RawRows.Add(new InfoRow() { Name = name, Value = pair.Value, Title = title });
        }

        foreach (InfoRow row in RawRows)
            di[row.Name] = row;

        Dictionary = di;
    }

    public class InfoRow
    {
        public string Name { get; internal set; }
        public object Value { get; internal set; }
        public string Title { get; internal set; }
    }

}

public static class SingleRowResultSetExtensions
{
    public static string Format(this SingleRowResultSet singleRowResultSet)
    {
        return Format(singleRowResultSet, "\t");
    }

    public static string Format(this SingleRowResultSet singleRowResultSet, string padding)
    {
        StringBuilder ret = new StringBuilder();
        foreach (var info in singleRowResultSet.RawRows)
        {
            var val = info.Value is long l ? l.ToString("n0") : Convert.ToString(info.Value);
            ret.AppendLine($"{padding}{info.Title}: {val}");
        }

        return ret.ToString();
    }
}
