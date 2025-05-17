## Functional Testing for .NET Applications with SQL Server and LocalDB

The intention is to tune SQL Servers for functional tests to achieve maximum performance, while also providing an accurate description and connection properties for locally installed SQL Servers and LocalDB instances.

The entry point is the extension method `Manage(this IDbConnection connection)`. The example below creates new database ***per test*** on each local SQL Server, each LocalDB instance, and an AWS SQL Server propagated via the `SQLSERVER_WELLKNOWN_My_AWS_1` environment variable.


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
    /* 5 */       .Where(server => server.Version != null)
                  .Where(server => server.Manage().EngineEdition == EngineEdition.Enterprise) // Developer|Enterprise
                  .Where(server => server.Manage().ShortServerVersion.Major >= 15) // 2019 or above
                  .OrderByVersionDesc()
                  .ToList();
}
```
* Line ①: Retrieves all locally pre-installed SQL Servers (`Kind=Local`) and all pre-installed LocalDB instances (`Kind=LocalDB`). At this step, the `DataSource` and `InstallerVersion` properties are populated. No communication with SQL Server is performed during this step. Additionally, for local SQL Server instances, the `ServiceStartup` property is also populated.
* Line ②: Filters out disabled SQL Server windows services.
* Line ③: Starts local SQL Servers and LocalDB instances if they are not already running. On Linux and macOS it has no effect.
* Line ④: Waits up to 30 seconds for each SQL Server health check to complete and populates the `Version` property.
* Line ⑤: Filter out non-healthy SQL Server instances from the previous step. This filter and two next are a dubious ones in most cases, but it is added for illustration purposes. Apparently, a non-responsive SQL Server should be fixed/removed if you control your development environment and your CI pipeline. 

## SQL Server Management Extensions

| Data Type | Member | Readonly | Comments |
|-----------|--------|----------|----------|
| Version | ShortServerVersion | read-only | @@MICROSOFTVERSION |
| bool | IsLocalDB          | read-only |
| bool | IsAzure         | read-only | 
| string | EngineEditionName | read-only    | "SQL Azure", "Express Edition", "Developer Edition", "Enterprise Edition", ... |
| EngineEdition | EngineEdition | read-only | Standard, Exterprise, Express, SqlDatabase, SqlDataWarehouse, Personal |
| string | LongServerVersion | read-only | @@VERSION |
| string | MediumServerVersion | read-only |
| SecurityMode | SecurityMode | read-only | IntegratedOnly, Both |
| string | ProductVersion | read-only | GetServerProperty&lt;string&gt;("ProductVersion")
| string | ProductLevel | read-only | CTP, RTM, SP1, SP2, ... |
| string | ProductUpdateLevel | read-only | CU1, CU2, ... |
| int    | CpuCount           | read-only
| long   | AvailableMemoryKb  | read-only | process_memory_limit_mb, Committed_Target_Kb, or Visible_Target_Kb depending on edition and version
| long   | CommittedMemoryKb  | read-only | Committed_Kb
| long   | PhysicalMemoryKb   | read-only | physical_memory_in_bytes or physical_memory_kb depending on version
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
| DatabaseOptionsManagement | CurrentDatabase | read-only | this.Databases[this.CurrentDatabaseName]
| DatabaseOptionsManagement | Databases["Db1"] | read-only | 
| HashSet&lt;string&gt; | FindCollations(IEnumerable&lt;string&gt; namesOrPatters)
| SqlBackupDescription | GetBackupDescription (string&nbsp;bakFullPath) | | Backups and files inside each backup
| bool | IsDbExists(string dbName)


## SQL Server Configuration

The entry point is the extension method `Manage(this IDbConnection connection).Configuration`

| Data Type | Member | Readonly | Comments |
|-----------|--------|----------|----------|
| Option&lt;T&gt; | ReadAdvancedOption&lt;T&gt;(string&nbsp;name)   | read
| void | SetAdvancedOption&lt;T&gt;(string&nbsp;name, T&nbsp;value) | write
| Option&lt;T&gt; | ReadOption&lt;T&gt;(string&nbsp;name)           | read
| void | SetOption&lt;T&gt;(string&nbsp;name, T&nbsp;value)         | write
| bool | Configuration.ClrEnabled | read/write | sp_configure 'clr enabled'
| bool | Configuration.ServerTriggerRecursion | read/write | sp_configure 'server trigger recursion'
| bool | Configuration.ShowAdvancedOption | read/write | sp_configure 'show advanced option'
| FileStreamAccessLevels | Configuration.FileStreamAccessLevel | read/write | sp_configure 'filestream access level'
| bool | Configuration.BackupCompressionDefault | read/write | sp_configure 'backup compression default'
| bool | Configuration.XpCmdShell | read/write | sp_configure 'xp_cmdshell'
| int | Configuration.MaxServerMemory | read/write | sp_configure 'max server memory (MB)'
| int | Configuration.MinServerMemory | read/write | sp_configure 'min server memory (MB)'


## SQL Database Management Extensions
  
| Data Type | Member | Readonly | Comments |
|-----------|--------|----------|----------|
| bool | Exists | readonly |  |
| void | SetState(TargetDatabaseState newState) | | Online, Offline, Emergency |
| void | Shrink(ShrinkOptions&#160;options, int?&#160;commandTimeout) | | options are: Shink and Truncate, Shrink only, Truncate only |
| bool | IsReadOnly | read/write |
| DatabaseRecoveryMode | RecoveryMode | read/write | Simple, Bulk logged, or Full
| DatabasePageVerify   | PageVerify | read/write | Checksum, Torn Page Detection, or None. Not supported by Azure
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

## SQL Server Discovery

On **Windows**, SQL Server instances and their versions are discovered via the registry path `HKLM\Software\Microsoft\Microsoft SQL Server` ([reference](https://learn.microsoft.com/en-us/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server)).

On **Linux** and **macOS**, SQL Server instance information is provided through environment variables prefixed with `SQLSERVER_WELLKNOWN_***`.



