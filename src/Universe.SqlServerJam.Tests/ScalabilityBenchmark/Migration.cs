using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Common;
using System.Linq;
using System.Text;
using Dapper;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark
{
    internal class Migration
    {
        public readonly Func<IDbConnection> NewConnection;

        public Migration(Func<IDbConnection> newConnection)
        {
            NewConnection = newConnection;
        }

        public void Migrate()
        {
            var sql1 = @"
If Object_ID('CategorySummary') Is Null
Create Table CategorySummary(
  Id bigint Identity Not Null, 
  Category nvarchar(400) Not Null,
  Count bigint Not Null,
  Sum float(53) Not Null,
  Constraint PK_CategorySummary Primary Key Clustered (Id)
);

CREATE NONCLUSTERED INDEX [IX_CategorySummary_Category]
    ON CategorySummary (Category);
";
            using var conn = NewConnection();
            conn.Execute(sql1);
        }
    }
}
