using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark
{
    public class DataSeeder
    {
        public readonly DataAccess DataAccess;
        static Random Rand = new Random(1);

        public DataSeeder(DataAccess dataAccess)
        {
            DataAccess = dataAccess;
        }

        public void Seed(int categoriesCount = 1000, TimeSpan timeLimit = default)
        {
            Stopwatch sw = Stopwatch.StartNew();
            for (int i = 0; i < categoriesCount; i++)
            {
                this.DataAccess.UpdateCategorySummary(
                    GetRandomCategoryName(Rand.Next(350, 400)),
                    Rand.Next(1, 3),
                    Rand.NextDouble() * 123
                );

                if (timeLimit != default && sw.Elapsed > timeLimit) break;
            }
        }

        public static string GetRandomCategoryName(int length)
        {
            StringBuilder b = new StringBuilder();
            for (int i = 0; i < length; i++)
                b.Append((char)Rand.Next(65, 65 + 26 - 1));

            return b.ToString();
        }
    }
}
