using System;

namespace Universe.SqlServerJam.Tests;

public class SensorsAppStressSettings
{
    static int? GetInt(string name) => 
        Int32.TryParse(Environment.GetEnvironmentVariable(name), out var ret) ? ret : null;

    public static int? WorkingSetRows = GetInt("SENSORSAPP_STRESS_WORKINGSET_ROWS");

    // Was "SQL_STRESS_DURATION_SECONDS"
    public static int? StressDuration = GetInt("SENSORSAPP_STRESS_DURATION");
}