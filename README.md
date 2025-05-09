# Universe.SqlServerJam &nbsp;&nbsp;&nbsp;[![Test SQL Servers Matrix](https://github.com/devizer/Universe.SqlServerJam/actions/workflows/setup-sqlservers.yml/badge.svg)](https://github.com/devizer/Universe.SqlServerJam/actions/workflows/setup-sqlservers.yml)
Operations during unit testing: start, stop services, check server edition, forced database delete, checking databases size, recovery mode, auto shrinking, etc. Discovering local sql server instances by the same way as SSMS

## IDbConnection.Manage() Extensions

| Data Type | Member | comments |
|-----------|--------|----------|
| Version | ShortServerVersion { get; } | @@MICROSOFTVERSION |
| string | ProductVersion { get; } | GetServerProperty<string>("ProductVersion") |
| string | ProductLevel { get; } | CTP, RTM, SP1, SP2, ... |
| string | ProductUpdateLevel { get; } | CU1, CU2, ... |
| string | LongServerVersion { get; } | @@VERSION |
| string    | ServerEdition { get; } | "SQL Azure", "Express Edition", "Developer Edition", "Enterprise Edition", ...
| EngineEdition | EngineEdition { get; }| Personal, Standard, Exterprise, Express, SqlDatabase, SqlDataWarehouse |
| bool | IsLocalDB { get; } |
| bool | IsAzure { get; } |
| bool | IsCompressedBackupSupported { get; } | ShortServerVersion.Major >= 10 && EngineEdition == Enterprise |
| bool | IsFullTextSearchInstalled { get; } |
| bool | IsConnectionEncrypted { get; } |
| SecurityMode| SecurityMode { get; } | IntegratedOnly, Both |
| string | HostPlatform { get; } | "Windows", "Linux" |
| FixedServerRoles | FixedServerRoles { get; } | SysAdmin, SetupAdmin, ServerAdmin, SecurityAdmin, ProcessAdmin, ... |
| string | NetTransport { get; } | "TCP", "Shared Memory", "Named Pipe" |
| int | CurrentSPID | @@SPID |
| string | CurrentDatabaseName { get; } | DB_NAME() |
| DatabaseOptionsManagement | CurrentDatabase { get; } | .Databases[CurrentDatabaseName] |
| double | Ping(int timeout = 20) | returns roundtrip duration |
| SqlDefaultPaths | DefaultPaths { get; } | Data, Logs and Backups default folder. By default SQL Server process has permissions to this folders only. Not applicable for Azure |

SqlServerManagement Manage(this IDbConnection) contains following public members:
```csharp
Version ShortServerVersion { get; }                      │ @@MICROSOFTVERSION
string ProductVersion { get; }                           │ 
string ProductUpdateLevel { get; }                       │ CU1, CU2, ... 
string ProductLevel { get; }                             │ CTP, RTM, SP1, SP2, ... 
string LongServerVersion { get; }                        │ @@VERSION 
string ServerEdition { get; }                            │ "SQL Azure", "Express Edition", "Developer Edition", "Enterprise Edition", ...
EngineEdition EngineEdition { get; }                     │ Personal | Standard | Exterprise | Express | SqlDatabase | SqlDataWarehouse
bool IsLocalDB { get; }                                  │
bool IsAzure { get; }                                    │
bool IsCompressedBackupSupported { get; }                │ ShortServerVersion.Major >= 10 && EngineEdition == Enterprise 
string ServerCollation { get; }                          |
bool IsFullTextSearchInstalled { get; }                  │
bool IsConnectionEncrypted { get; }                      │
SecurityMode SecurityMode { get; }                       │ Either IntegratedOnly or Both
SqlDefaultPaths DefaultPaths { get; }                    │ Data, Logs and Backups default folder. Not applicable for Azure DB
string HostPlatform { get; }                             │ Either "Windows" or "Linux"
FixedServerRoles FixedServerRoles { get; }               │ SysAdmin | SetupAdmin | ServerAdmin, ...
string NetTransport { get; }                             │ Either "TCP", "Shared Memory" or "Named Pipe" 
int CurrentSPID { get; }                                 │ @@SPID
double Ping(int timeout = 20)                            │ Returns roundtrip duration in seconds
string CurrentDatabaseName { get; }                      │ DB_NAME() 
DatabaseOptionsManagement CurrentDatabase { get; }       │ Databases[CurrentDatabaseName] 
DatabaseOptionsManagement Databases["Contoso"] { get; }  │
```


## Full Featured Demo
Source code: [Full_Featured_Demo.cs](https://github.com/devizer/Universe.SqlServerJam/blob/master/Universe.SqlServerJam/Universe.SqlServerJam.Tests/Full_Featured_Demo.cs)

## SqlDiscovery
It is *a* first person class of the library.
It's purpose to find local installed SQL Server, icluding x86 and x64 families.
```csharp
public static List<SqlServerRef> GetLocalDbAndServerList() { ... }

public class SqlServerRef
{
    public SqlServerDiscoverySource Kind { get; set; }
    public Version Version { get; set; }
    public string ConnectionString { get; }
}

public enum SqlServerDiscoverySource
{
    Local,
    LocalDB,
    WellKnown
}

```

Also it finds default MSSQLLocalDB instance of LocalDB 2012 ... 2016.
Optionally for integration tests a network/cloud SQL Servers might be injectec into descory proc using environvent variables. For example:
```
set SQLSERVER_WELLKNOWN_Linux=Server=tcp:Ubuntu-16.04-LTS,1433;User Id=sa;Password=your!passw0rd
set SQLSERVER_WELLKNOWN_Azure_EU=Server=tcp:my-server.database.windows.net,1433;Initial Catalog=MyDb;Persist Security Info=False;User ID=<user>;Password=<password>;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
```

Here is a sample output
```cs
var sqlServers = SqlDiscovery.GetLocalDbAndServerList().OrderByVersionDesc().ToList();
Console.WriteLine(sqlServers.AsBullets());
```

```
 * tcp:Ubuntu-16.04-LTS,1433 (14.0.3006)
 * (local)\SQLEXPRESS (14.0.1000.169)
 * tcp:my-server-eu.database.windows.net,1433 (14.0.900)
 * tcp:my-server-frankfurt.blablahash.eu-central-1.rds.amazonaws.com,1433 (13.0.4422)
 * (LocalDB)\MSSqlLocalDB (13.0)
 * tcp:my-server-oregon.blablahash.rds.amazonaws.com,1433 (10.50.2789)
 * (local)\SQL2008R2 (10.50.1600.1)
 * (local)\SQL2005 (9.0.5000.0)
```

The bullet list above of (local) and (localdb) servers was discovered automatically using registry, and rest of servers where injected using `SQLSERVER_WELLKNOWN_` env vars.

## SqlExtentions
Here is a sample output of IDbConnection extentions on Azure DB
```
Version (32-bit) .........: 14.0.900
Version (string) .........: 12.0.2000.8
Product Level ............: RTM
Update Level .............: 
Edition ..................: SQL Azure
Engine Edition ...........: SQL_Database
Host Platform ............: Windows
Security Mode ............: Both
Is LocalDB ...............: False
Transport ................: TCP, Encrypted
Server Collation .........: SQL_Latin1_General_CP1_CI_AS
Built-in Roles ...........: None
Databases ................: 1 (4512 Kb)
Default Data .............: 
Default Log ..............: 
Default Backup ...........: 
Connected DB Info ........: [MySandBox]
  - Auto Shrink ......... : False
  - Auto Create Statistic : Complete
  - Auto Update Statistic : Syncly
  - Recursive Triggers .. : False
  - Broker Enabled ...... : True
  - State ............... : Online
  - Is Readonly ......... : False
  - Default Collation ... : SQL_Latin1_General_CP1_CI_AS [IgnoreCase, IgnoreKana, IgnoreWidth]
  - Size (KB) ........... : 4512
  - Recovery Mode ....... : Full
  - Owner ............... : Not Applicable
  - AZ Edtion ........... : Standard
  - AZ Service Objective. : S1
  - AZ Elastic Pool ..... : 
Long Version .............: Microsoft SQL Azure (RTM) - 12.0.2000.8 Aug 29 2017 13:06:11 Copyright (C) 2017 Microsoft Corporation 
```
