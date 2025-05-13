## IDbConnection Extensions

The intention is tinung functional tests for maximum performance
```
IDbConnection cnn = ...;
cnn.Manage().Configuration.MinServerMemory = 4 * 1024;
cnn.Execute("Create Database [Db 1]");
cnn.Manage().Databases["Db 1"].PageVerify = DatabasePageVerify.None;
cnn.Manage().Databases["Db 1"].RecoveryMode = DatabaseRecoveryMode.Simple;
cnn.Manage().Databases["Db 1"].AutoCreateStatistic = AutoCreateStatisticMode.Incremental;
cnn.Manage().Databases["Db 1"].AutoUpdateStatistic = AutoUpdateStatisticMode.Async;
```


  Constructor| void SqlServerManagement(IDbConnection sqlConnection)
  Method| T GetServerProperty&lt;T&gt;(string propertyName)

  Method| bool IsDbExists(string dbName)
  Method| HashSet&lt;string&gt; FindCollations(IEnumerable&lt;string&gt; namesOrPatters)
  Method| HashSet&lt;string&gt; FindCollations(string[] namesOrPatters)
  Method| SqlBackupDescription GetBackupDescription(string bakFullPath)

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


## SQL Database IDbConnection Extensions


DatabaseOptionsManagement
  
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
| bool | IsIncrementalAutoStatisticCreationSupported | read-only
| AutoUpdateStatisticMode | AutoUpdateStatistic | read/write | Synchronously, Async, Off
| bool | IsBrokerEnabled | read/write |
| string | DefaultCollationName | read/write |
| string | StateDescription | read-only | Online, Offline, Emergency, Restoring, Recovering, ... |
| bool | IsOnline | read-only
| DatabaseComparisonStyle | ComparisonStyle | read-only | flags IgnoreCase, IgnoreAccent, IgnoreKana, IgnoreWidth
| bool | IsClone | read-only
| string | AzureServiceObjective | read-only
| string | AzureEdition | read-only
| string | AzureElasticPool | read-only
| long | Size | read-only
| bool | AreTriggersRecursive | read/write
| bool | IsFullTextEnabled | read-only
| string | OwnerName | read-only
| bool | HasMemoryOptimizedTableFileGroup | read-only


#2.2 {Show_Core_Only} &gt;PASSED&lt; in 00|00|00.0002348 (cpu| 0%, 0.000 = 0.000 [user] + 0.000 [kernel] milliseconds)

