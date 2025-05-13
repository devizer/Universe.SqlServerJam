#2.2 {Show_Core_Only} @ ShowAPI starting...
Type| SqlServerManagement
--------------------------------------------------------------------------------
  Constructor| void SqlServerManagement(IDbConnection sqlConnection)
  Method| T GetServerProperty<T>(string propertyName)

  Method| bool IsDbExists(string dbName)
  Method| HashSet<string> FindCollations(IEnumerable<string> namesOrPatters)
  Method| HashSet<string> FindCollations(string[] namesOrPatters)
  Method| SqlBackupDescription GetBackupDescription(string bakFullPath)

  - Property| IDbConnection SqlConnection | read-only
  - Property| SqlServerManagement.DatabaseSelector Databases | read-only

| Data Type | Member | Readonly | comments |
|-----------|--------|----------|----------|
| Version | ShortServerVersion | read-only | @@MICROSOFTVERSION |
| bool | IsLocalDB          | read-only |
| bool | IsAzure         | read-only | 
| string | EngineEditionName | read-only    | "SQL Azure", "Express Edition", "Developer Edition", "Enterprise Edition", ... |
| EngineEdition | EngineEdition | read-only | Standard, Exterprise, Express, SqlDatabase, SqlDataWarehouse, Personal |
| string | LongServerVersion | read-only | @@VERSION |
| SecurityMode | SecurityMode | read-only | IntegratedOnly, Both |
| string | MediumServerVersion | read-only |
| string | ProductVersion | read-only | GetServerProperty<string>("ProductVersion")
| string | ProductLevel | read-only | CTP, RTM, SP1, SP2, ... |
| string | ProductUpdateLevel | read-only | CU1, CU2, ... |
| string | ServerCollation | read-only | GetServerProperty<string>("Collation") |
| bool | IsFullTextSearchInstalled | read-only |
| bool | IsFileStreamSupported | read-only | this.ShortServerVersion.Major >= 10 && !this.IsLocalDB
| string | HostPlatform | read-only | "Windows" or "Linux" |
| bool | IsWindows | read-only |
| bool | IsLinux | read-only |
| SqlDefaultPaths | DefaultPaths            | read-only | Data, Log, and Backup folders |
| FixedServerRoles | FixedServerRoles       | read-only | SysAdmin, SetupAdmin, ServerAdmin, SecurityAdmin, ProcessAdmin, ... |
| bool | IsCompressedBackupSupported     | read-only | this.EngineEdition == EngineEdition.Enterprise && this.ShortServerVersion.Major >= 10 |
| bool | IsMemoryOptimizedTableSupported | read-only | Depends on edition, version and update level
| bool | IsConnectionEncrypted | read-only | 
| string | NetTransport | read-only | "TCP", "Shared Memory", "Named Pipe" |
| int | CurrentSPID | read-only | @@SPID, has no sense if IDbConnection is closed
| string | CurrentDatabaseName | read-only | DB_NAME()
| ServerConfigurationSettingsManager | ServerConfigurationSettings | read-only | sp_configure
| DatabaseOptionsManagement | CurrentDatabase | read-only | this.Databases[this.CurrentDatabaseName]


Type| ServerConfigurationSettingsManager
--------------------------------------------------------------------------------
  Constructor| void ServerConfigurationSettingsManager(SqlServerManagement serverManagement)
  Method| ServerConfigurationSettingsManager.Option<T> ReadAdvancedOption<T>(string name)
  Method| Void SetAdvancedOption<T>(string name, T value)
  Method| ServerConfigurationSettingsManager.Option<T> ReadOption<T>(string name)
  Method| Void SetOption<T>(string name, T value)
  Property| bool ClrEnabled
  Property| bool ServerTriggerRecursion
  Property| bool ShowAdvancedOption
  Property| FileStreamAccessLevels FileStreamAccessLevel
  Property| bool BackupCompressionDefault
  Property| bool XpCmdShell
  Property| int MaxServerMemory
  Property| int MinServerMemory


DatabaseOptionsManagement
  
| Data Type | Member | Readonly | comments |
|-----------|--------|----------|----------|
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


#2.2 {Show_Core_Only} >PASSED< in 00|00|00.0002348 (cpu| 0%, 0.000 = 0.000 [user] + 0.000 [kernel] milliseconds)

