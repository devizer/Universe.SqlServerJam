# Universe.SqlServerJam
Package implements: discovering local sql server instances by the same way as SSMS and operations during unit testing: start, stop services, check server edition, forced database delete, checking databases size, recovery mode, auto shrinking, etc.

## Full Featured Demo
Source code: [Full_Featured_Demo.cs](https://github.com/devizer/Universe.SqlServerJam/blob/master/Universe.SqlServerJam/Universe.SqlServerJam.Tests/Full_Featured_Demo.cs)

## SqlDiscovery
It is a root class of the library.
It's purpose to find local installed SQL Server, icluding x86 and x64 families.
Also it finds default MSSQLLocalDB instance of LocalDB 2014 or 2016.
Optionally for integration tests network/cloud SQL Servers might be injectec into descory proc using environvent variables. For example:
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
 * tcp:my-server-frankfurt.cu2g0szytlwx.eu-central-1.rds.amazonaws.com,1433 (13.0.4422)
 * (LocalDB)\MSSqlLocalDB (13.0)
 * tcp:my-server-oregon.chwcc2jan4bi.us-west-2.rds.amazonaws.com,1433 (10.50.2789)
 * (local)\SQL2008R2 (10.50.1600.1)
 * (local)\SQL2005 (9.0.5000.0)
```

The bullet list above (local) and (localdb) servers was discovered automatically using registry, and rest of servers where injected using `SQLSERVER_WELLKNOWN_` env vars.

