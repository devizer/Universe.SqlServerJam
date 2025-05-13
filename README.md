## IDbConnection Extensions

The intention is tinung SQL Servers on functional tests for maximum performance. As well as providing accurate description and connection properties for locally installed sql servers and localdb instances.

The entry proint is extension method ```Manage(this IDbConnection connection)```. The example below creates test database on each local SQL Server, each instance of LocalDB instance, and AWS SQL Server propgated via ```SQLSERVER_WELLKNOWN_My_AWS_1``` environment variable.

The intention is to tune SQL Servers for functional tests to achieve maximum performance, while also providing an accurate description and connection properties for locally installed SQL Servers and LocalDB instances.

The entry point is the extension method `Manage(this IDbConnection connection)`. The example below creates a test database on each local SQL Server, each LocalDB instance, and an AWS SQL Server propagated via the `SQLSERVER_WELLKNOWN_My_AWS_1` environment variable.


```csharp
[Test]
[TestCaseSource(nameof(GetEnabledServers))]
public void Demo1(SqlServerRef testCase)
{
    IDbConnection cnn = new SqlConnection(testCase.ConnectionString);
    cnn.Manage().Configuration.MinServerMemory = 5000; // 5Gb
    cnn.Manage().Configuration.MaxServerMemory = 128000; // 128Gb

    string newDbName = $"Test DB {Guid.NewGuid():N}";
    try
    {
        cnn.Execute($"Create Database [{newDbName}]");
        cnn.Manage().Databases[newDbName].RecoveryMode = DatabaseRecoveryMode.Simple;
        cnn.Manage().Databases[newDbName].IsAutoShrink = false;
        cnn.Manage().Databases[newDbName].PageVerify = DatabasePageVerify.None;
        cnn.Manage().Databases[newDbName].AutoCreateStatistic = AutoCreateStatisticMode.Off;
        cnn.Manage().Databases[newDbName].AutoUpdateStatistic = AutoUpdateStatisticMode.Off;
        Console.WriteLine($"Success: {cnn.Manage().MediumServerVersion}");
    }
    finally
    {
        ResilientDbKiller.Kill(testCase.ConnectionString, newDbName);
    }

    // Validate newDbName database is deleted
    Assert.That(cnn.Manage().IsDbExists(newDbName), Is.False);
}

static IEnumerable<SqlServerRef> GetEnabledServers()
{
    return 
    /* 1 */   SqlDiscovery.GetLocalDbAndServerList() 
    /* 2 */       .Where(server => server.ServiceStartup != LocalServiceStartup.Disabled)
    /* 3 */       .StartLocalIfStopped()
    /* 4 */       .WarmUp(timeout: TimeSpan.FromSeconds(30))
                  .OrderByVersionDesc()
                  .ToList();
}
```
* Line ①: Retrieves all locally pre-installed SQL Servers (`Kind=Local`) and all pre-installed LocalDB instances (`Kind=LocalDB`). At this step, the `DataSource` and `InstallerVersion` properties are populated. No communication with SQL Server is performed during this step. Additionally, for local SQL Server instances, the `ServiceStartup` property is also populated.
* Line ②: Filters out disabled SQL Server services.
* Line ③: Starts local SQL Servers and LocalDB instances if they are not already running.
* Line ④: Waits up to 30 seconds for each SQL Server health check to complete and populates the `Version` property.



## SQL Server IDbConnection Extensions

| Data Type | Member | Readonly | Comments |
|-----------|--------|----------|----------|
| Version | ShortServerVersion | read-only | @@MICROSOFTVERSION |
| bool | IsLocalDB          | read-only |
| bool | IsAzure         | read-only | 
| string | EngineEditionName | read-only    | "SQL Azure", "Express Edition", "Developer Edition", "Enterprise Edition", ... |
| EngineEdition | EngineEdition | read-only | Standard, Exterprise, Express, SqlDatabase, SqlDataWarehouse, Personal |
| string | LongServerVersion | read-only | @@VERSION |
| SecurityMode | SecurityMode | read-only | IntegratedOnly, Both |
| string | MediumServerVersion | read-only |
| string | ProductVersion | read-only | GetServerProperty&lt;string&gt;("ProductVersion")
| string | ProductLevel | read-only | CTP, RTM, SP1, SP2, ... |
| string | ProductUpdateLevel | read-only | CU1, CU2, ... |
| string | ServerCollation | read-only | GetServerProperty&lt;string&gt;("Collation") |
| bool | IsFullTextSearchInstalled | read-only |
| bool | IsFileStreamSupported | read-only | this.ShortServerVersion.Major &gt;= 10 && !this.IsLocalDB
| string | HostPlatform | read-only | "Windows" or "Linux" |
| bool | IsWindows | read-only |
| bool | IsLinux | read-only |
| SqlDefaultPaths | DefaultPaths            | read-only | Data, Log, and Backup folders |
| FixedServerRoles | FixedServerRoles       | read-only | SysAdmin, SetupAdmin, ServerAdmin, SecurityAdmin, ProcessAdmin, ... |
| bool | IsCompressedBackupSupported     | read-only | this.EngineEdition == EngineEdition.Enterprise && this.ShortServerVersion.Major &gt;= 10 |
| bool | IsMemoryOptimizedTableSupported | read-only | Depends on edition, version and update level
| bool | IsConnectionEncrypted | read-only | 
| string | NetTransport | read-only | "TCP", "Shared Memory", "Named Pipe" |
| int | CurrentSPID | read-only | @@SPID, has no sense if IDbConnection is closed
| string | CurrentDatabaseName | read-only | DB_NAME()
| ServerConfigurationSettingsManager | ServerConfigurationSettings | read-only | sp_configure
| DatabaseOptionsManagement | CurrentDatabase | read-only | this.Databases[this.CurrentDatabaseName]
| DatabaseOptionsManagement | Databases["Db1"] | read-only | 
| Option&lt;T&gt; | Configuration.ReadAdvancedOption&lt;T&gt;(string name)
| Option&lt;T&gt; | Configuration.ReadOption&lt;T&gt;(string name)
| void | Configuration.SetAdvancedOption&lt;T&gt;(string name, T value)
| void | Configuration.SetOption&lt;T&gt;(string name, T value)
| bool | Configuration.ClrEnabled | read/write
| bool | Configuration.ServerTriggerRecursion | read/write
| bool | Configuration.ShowAdvancedOption | read/write
| FileStreamAccessLevels | Configuration.FileStreamAccessLevel | read/write
| bool | Configuration.BackupCompressionDefault | read/write
| bool | Configuration.XpCmdShell | read/write
| int | Configuration.MaxServerMemory | read/write
| int | Configuration.MinServerMemory | read/write
| T | GetServerProperty&lt;T&gt;(string propertyName)
| bool | IsDbExists(string dbName)
| HashSet&lt;string&gt; | FindCollations(IEnumerable&lt;string&gt; namesOrPatters)
| SqlBackupDescription | GetBackupDescription(string bakFullPath) | | Backups and files inside each backup


## SQL Database IDbConnection Extensions
  
| Data Type | Member | Readonly | Comments |
|-----------|--------|----------|----------|
| bool | Exists | readonly |  |
| void | SetState(TargetDatabaseState newState) | | Online, Offline, Emergency |
| void | Shrink(ShrinkOptions&#160;options, int?&#160;commandTimeout) | | options are: Shink and Truncate, Shrink only, Truncate only |
| bool | IsReadOnly | read/write |
| DatabaseRecoveryMode | RecoveryMode | read/write | Simple, Bulk logged, or Full
| DatabasePageVerify   | PageVerify | read/write | Checksum, Torn Page Detection, or None
| bool | IsAutoShrink | read/write |
| AutoCreateStatisticMode | AutoCreateStatistic | read/write | Complete, Incremental, Off
| bool | AreTriggersRecursive | read/write
| AutoUpdateStatisticMode | AutoUpdateStatistic | read/write | Synchronously, Async, Off
| bool | IsIncrementalAutoStatisticCreationSupported | read-only | ServerVersion.Major >= 12
| bool | IsBrokerEnabled | read/write |
| string | DefaultCollationName | read/write |
| string | StateDescription | read-only | Online, Offline, Emergency, Restoring, Recovering… |
| bool | IsOnline | read-only
| DatabaseComparisonStyle | ComparisonStyle | read-only | flags IgnoreCase, IgnoreAccent, IgnoreKana, IgnoreWidth
| bool | IsClone | read-only
| string | AzureServiceObjective | read-only | S0, S1, S2, ElasticPool…
| string | AzureEdition | read-only | Basic, Standard, Premium…
| string | AzureElasticPool | read-only | sys.database_service_objectives.elastic_pool_name
| long | Size | read-only
| bool | IsFullTextEnabled | read-only
| string | OwnerName | read-only
| bool | HasMemoryOptimizedTableFileGroup | read-only



