using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

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

        public void Seed(int categoriesCount = 1000)
        {
            var maxSeedThreads = 1; // deadlock if 2 or more
            ParallelOptions po = new ParallelOptions() { MaxDegreeOfParallelism = Math.Min(Environment.ProcessorCount, maxSeedThreads) };
            // while (categoriesCount > 0)
            object sync = new object();
            Stopwatch sw = Stopwatch.StartNew();
            Parallel.ForEach(SplitByBlocks(categoriesCount, 1000), po, partCount =>
            {

                // lock (sync)
                var categoriesBatch = Enumerable.Range(1, partCount)
                        .Select(x => new DataAccess.CategoryIncrementTableType()
                        {
                            Category = Guid.NewGuid() + GetRandomCategoryName(Rand.Next(300, 350)),
                            Count = Rand.Next(1, 3),
                            Amount = Rand.NextDouble() * 123
                        })
                        // .ToArray()
                    ;

                // Console.WriteLine($"{sw.Elapsed.TotalSeconds:n1} Seeding {partCount:n0} categories of {categoriesCount:n0} total");
                    

                this.DataAccess.UpdateCategorySummaryBatch(categoriesBatch);
            });
        }

        static IEnumerable<int> SplitByBlocks(int totalCount, int blockSize)
        {
            while (totalCount > 0)
            {
                int partCount = Math.Max(1, Math.Min(blockSize, totalCount));
                totalCount -= partCount;
                yield return partCount;
            }
        }

        public void Seed_Prev(int categoriesCount = 1000, TimeSpan timeLimit = default)
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
            {
                var ch = (char)( i % 5 == 0 ? Rand.Next(65, 65 + 26 - 1) : (65 + i % 25));
                b.Append(ch);
            }
                

            return b.ToString();
        }
    }
}
