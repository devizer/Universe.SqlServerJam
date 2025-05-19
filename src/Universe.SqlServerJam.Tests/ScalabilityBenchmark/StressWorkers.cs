using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Universe.SqlServerJam.Tests.ScalabilityBenchmark
{
    public class StressWorkerReader : IStressAction
    {
        public readonly DataAccess DataAccess;
        public StressWorkerReader(DataAccess dataAccess)
        {
            DataAccess = dataAccess;
        }

        public void Act()
        {
            string categoryName =
                StressState.Rand.Next(130) == 1
                    ? "No Such Category"
                    : StressState.GetRandomExistingCategory().Category;

            var category = DataAccess.GetCategory(categoryName);
        }
    }

    public class StressWorkerUpdater : IStressAction
    {
        public readonly DataAccess DataAccess;

        public StressWorkerUpdater(DataAccess dataAccess)
        {
            DataAccess = dataAccess;
        }

        public void Act()
        {

            string categoryName =
                StressState.Rand.Next(13) == 1
                    ? Guid.NewGuid().ToString()
                    : StressState.GetRandomExistingCategory().Category;

            DataAccess.UpdateCategorySummary(categoryName, 1, StressState.Rand.NextDouble());
        }
    }

    public class StressState
    {
        public static Random Rand = new Random(1);
        public static CategorySummaryEntity[] Categories;

        public static CategorySummaryEntity GetRandomExistingCategory() =>
            Categories[Rand.Next(Categories.Length)];
    }

}
