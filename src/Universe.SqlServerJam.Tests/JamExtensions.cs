using System;
using System.Data.SqlClient;

namespace Universe.SqlServerJam.Tests
{
    public static class JamExtensions
    {
        public static bool CanSimplyCreateDatabase(this SqlServerRef testCase)
        {
            var man0 = new SqlConnection(testCase.ConnectionString).Manage();
            var shortVersion = man0.ShortServerVersion;
            if (man0.IsLocalDB && shortVersion.Major == 14 && shortVersion.Minor == 0 && shortVersion.Build <= 1000)
            {
                Console.WriteLine($"SKIP '{man0.MediumServerVersion}' because of Create Database Bug");
                return false;
            }

            return true;
        }

        public static bool IsNotAzure(this SqlServerRef testCase)
        {
            var man0 = new SqlConnection(testCase.ConnectionString).Manage();
            if (man0.IsAzure)
            {
                Console.WriteLine($"SKIP '{man0.MediumServerVersion}' because Test does not support Azure");
                return false;
            }

            return true;
        }
    }
}