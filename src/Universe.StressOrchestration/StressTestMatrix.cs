using System;
using System.Collections.Generic;
using System.Text;

namespace Universe.StressOrchestration
{
    public class StressTestMatrix
    {
        public bool IsLocalSql { get; private set; }
        public int SqlProcessorCount { get; private set; }
        public int AppProcessorCount { get; private set; }

        public StressTestMatrix(bool isLocalSql, int sqlProcessorCount, int appProcessorCount)
        {
            IsLocalSql = isLocalSql;
            SqlProcessorCount = sqlProcessorCount;
            AppProcessorCount = appProcessorCount;
        }

        public IEnumerable<Case> GetCases()
        {
            for(int sqlCores = 1; sqlCores <= SqlProcessorCount; sqlCores++)
            {
                // AffinityMask class is in Jam library
            }
            throw new NotImplementedException();
        }

        public class Case
        {
            public bool IsBaseLine { get; internal set; }
            public long SqlAffinity { get; internal set; }
            public long AppAffinity { get; internal set; }

            public int SqlCoreCount { get; internal set; }
            public int AppCoreCount { get; internal set; }
        }
    }
}
