using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark;

public class DataAccess
{
    public readonly Func<IDbConnection> NewConnection;

    public DataAccess(Func<IDbConnection> newConnection)
    {
        NewConnection = newConnection;
    }

    public CategorySummaryEntity GetCategory(string categoryName)
    {
        var sql = "Select Top 1 * From [CategorySummary] Where Category = @categoryName";
        using var conn = NewConnection();
        return conn.QueryFirstOrDefault<CategorySummaryEntity>(sql, new { categoryName });
    }
    public IEnumerable<CategorySummaryEntity> GetAllCategories()
    {
        var sql = "Select * From [CategorySummary]";
        using var conn = NewConnection();
        return conn.Query<CategorySummaryEntity>(sql, null, commandTimeout: 100);
    }

    public IEnumerable<CategorySummaryEntity> GetCategories(IEnumerable<string> categoryNames)
    {
        DynamicParameters parameters = new DynamicParameters();
        StringBuilder where = new StringBuilder();
        int i = 0;
        foreach (var category in categoryNames)
        {
            parameters.Add($"@category{i}", value: category);
            where.Append(where.Length == 0 ? "" : ",").Append($"@category{i}");
            i++;
        }

        if(i == 0) return Enumerable.Empty<CategorySummaryEntity>();

        var sql = $"Select * From [CategorySummary] Where Category In ({where})";
        using var conn = NewConnection();
        return conn.Query<CategorySummaryEntity>(sql, parameters);
    }

    public class CategoryIncrementTableType
    {
        public string Category { get; set; }
        public int Count { get; set; }
        public double Amount { get; set; }
    }

    public void UpdateCategorySummaryBatch(IEnumerable<CategoryIncrementTableType> categories)
    {
        var dt = new DataTable();
        dt.Columns.Add("Category");
        dt.Columns.Add("Count", typeof(int));
        dt.Columns.Add("Amount", typeof(double));
        foreach (var cat in categories)
        {
            dt.Rows.Add(cat.Category, cat.Count, cat.Amount);
        }

        var sql = @"
SET IMPLICIT_TRANSACTIONS OFF;
SET NOCOUNT ON;
MERGE [CategorySummary] AS Target 
USING @Categories as Source
ON (Target.Category = Source.Category)
WHEN MATCHED THEN
  Update Set
    Target.[Count] = Target.[Count] + Source.[Count], 
    Target.[Sum] = Target.[Sum] + Source.[Amount]
WHEN NOT MATCHED THEN
  INSERT ([Category], [Count], [Sum])
  VALUES (Source.[Category], Source.[Count], Source.[Amount])
;
";
        using var conn = NewConnection();
        conn.Execute(sql, new { Categories = dt.AsTableValuedParameter("CategoryIncrementTableType") });
    }

    public void UpdateCategorySummary(string category, int count, double amount)
    {
        var sql = @"
SET IMPLICIT_TRANSACTIONS OFF;
SET NOCOUNT ON;
MERGE [CategorySummary] AS Target 
USING (
  VALUES (@category, @count, @amount)
) AS Source ([Category], [Count], [Amount]) 
ON (Target.Category = Source.Category)
WHEN MATCHED THEN
  Update Set
    Target.[Count] = Target.[Count] + Source.[Count], 
    Target.[Sum] = Target.[Sum] + Source.[Amount]
WHEN NOT MATCHED THEN
  INSERT ([Category], [Count], [Sum])
  VALUES (Source.[Category], Source.[Count], Source.[Amount])
;
";
        using var conn = NewConnection();
        conn.Execute(sql, new { category, count, amount });
    }
}