## SqlServer-Version-Management Powershell Module
SQL Server Setup and Management including Developer, Express, and LocalDB editions.
The intended use of this project is for Continuous Integration (CI) scenarios, where:
- SQL Server or LocalDB needs to be installed without user interaction.
- SQL Server or LocalDB installation doesn't need to persist across multiple CI runs.

SQL Server Setup defaults:
- Features are SQL Engine and full text search,
- Built-in Administrators (or localized name) are SQL Server Administrators for SSPI,
- TCP/IP and Named Pipe protocols are on,
- sa password is 'Meaga$tr0ng'.

## Supported SQL Server version arguments:
&#x2714;&nbsp;&nbsp; _2022 Developer Update_ 🡒 16.0.4135.4 RTM CU14 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Developer_ 🡒 16.0.1000.6 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Advanced Update_ 🡒 16.0.4135.4 RTM CU14 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Advanced_ 🡒 16.0.1000.6 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Core Update_ 🡒 16.0.4135.4 RTM CU14 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Core_ 🡒 16.0.1000.6 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 LocalDB_ 🡒 16.0.1000.6 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Developer Update_ 🡒 15.0.4385.2 RTM CU28 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Developer_ 🡒 15.0.2000.5 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Advanced Update_ 🡒 15.0.4385.2 RTM CU28 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Advanced_ 🡒 15.0.2000.5 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Core Update_ 🡒 15.0.4385.2 RTM CU28 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Core_ 🡒 15.0.2000.5 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 LocalDB_ 🡒 15.0.2000.5 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Developer Update_ 🡒 14.0.3456.2 RTM CU31 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Developer_ 🡒 14.0.1000.169 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Advanced Update_ 🡒 14.0.3456.2 RTM CU31 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Advanced_ 🡒 14.0.1000.169 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Core Update_ 🡒 14.0.3456.2 RTM CU31 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Core_ 🡒 14.0.1000.169 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 LocalDB_ 🡒 14.0.1000.169 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Developer Update_ 🡒 13.0.6441.1 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Developer_ 🡒 13.0.6404.1 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Advanced Update_ 🡒 13.0.6441.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Advanced_ 🡒 13.0.6404.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Core Update_ 🡒 13.0.6441.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Core_ 🡒 13.0.6404.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 LocalDB_ 🡒 13.0.6300.2 SP3 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Developer_ 🡒 12.0.6024.0 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Advanced_ 🡒 12.0.6024.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Core_ 🡒 12.0.6024.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 LocalDB_ 🡒 12.0.6024.0 SP3 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Developer_ 🡒 12.0.6024.0 SP3 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Advanced_ 🡒 12.0.6024.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Core_ 🡒 12.0.6024.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Developer_ 🡒 11.0.7001.0 SP4 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Advanced_ 🡒 11.0.7001.0 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Core_ 🡒 11.0.7001.0 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 LocalDB_ 🡒 11.0.7001.0 SP4 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Developer_ 🡒 11.0.7001.0 SP4 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Advanced_ 🡒 11.0.7001.0 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Core_ 🡒 11.0.7001.0 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Developer_ 🡒 10.50.6000.34 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Advanced Update_ 🡒 10.50.6000.34 SP3 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Advanced_ 🡒 10.50.4000.0 SP2 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Core Update_ 🡒 10.50.6000.34 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Core_ 🡒 10.50.4000.0 SP2 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Developer_ 🡒 10.50.6000.34 SP3 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Advanced Update_ 🡒 10.50.6000.34 SP3 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Advanced_ 🡒 10.50.4000.0 SP2 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Core Update_ 🡒 10.50.6000.34 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Core_ 🡒 10.50.4000.0 SP2 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Advanced Update_ 🡒 10.0.6000.29 SP4 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Advanced_ 🡒 10.0.1600.22 RTM Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Core Update_ 🡒 10.0.6000.29 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Core_ 🡒 10.0.5500.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Advanced Update_ 🡒 10.0.6000.29 SP4 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Advanced_ 🡒 10.0.1600.22 RTM Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Core Update_ 🡒 10.0.6000.29 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Core_ 🡒 10.0.5500.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Advanced Update_ 🡒 9.00.5000.00 SP4 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Advanced_ 🡒 9.00.3042.00 SP2 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Core_ 🡒 9.00.5000.00 SP4 Express Edition<br/>


## Setup-SqlServers function
&#x1F31F; Install SQL Server 2022 Developer Edition with Cumulative Update as default instance (local) with UTF8 Collation:
```powershell
Setup-SqlServers "2022 Developer Updated: MSSQLSERVER" `
                 "Collation=Latin1_General_100_CI_AS_SC_UTF8"
```

&#x1F31F; Install four SQL Server Instances on system drive, and put data and log folders on second ssd:
```powershell
$sqlServers=@"
2022 Developer Updated: DEVELOPER2022,
2019 Developer Updated: DEVELOPER2019,
2017 Developer Updated: DEVELOPER2017,
2016 Developer Updated: DEVELOPER2016
"@;
Setup-SqlServers $sqlServers `
                 "/SQLUSERDBDIR=D:\SQL\{InstanceName}-DATA" `
                 "/SQLUSERDBLOGDIR=D:\SQL\{InstanceName}-LOGS"
```

&#x1F31F; Install SQL Server 2019 Developer Edition RTM as DEVELOPER2019 instance:
```powershell
Setup-SqlServers "2019 Developer: DEVELOPER2019"
```

&#x1F31F; Install SQL Server 2016 Developer Edition SP3 as DEVELOPER2016 instance tuned for performance:
```powershell
$ENV:PS1_TROUBLE_SHOOT = "On"
$ENV:SQLSERVERS_MEDIA_FOLDER = "D:\SQL-SETUP\Media"
$ENV:SQLSERVERS_SETUP_FOLDER = "C:\SQL-SETUP\Installer"
Setup-SqlServers "2016 Developer: DEVELOPER2016" `
                 "Features=SQLENGINE,FullText" `
                 "Collation=SQL_Latin1_General_CP1_CI_AS" `
                 "Startup=Automatic" `
                 "InstallTo=D:\SQL" `
                 "Password=Zuper`$tr0ng" 
```

&#x1F31F; List Installed SQL Server Intances
```powershell
Find-Local-SqlServers | 
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host

Instance               InstallerVersion Service
--------               ---------------- -------
(local)                16.0.1000.6      MSSQLSERVER
(local)\ADV_2005_X86   9.00.5000.00     MSSQL$ADV_2005_X86
(local)\ADV_2008R2_X64 10.50.6000.34    MSSQL$ADV_2008R2_X64
(local)\ADV_2008_X86   10.0.1600.22     MSSQL$ADV_2008_X86
(local)\DEV2022UTF8    16.0.1000.6      MSSQL$DEV2022UTF8
(local)\DEV_2008R2_X64 10.50.6000.34    MSSQL$DEV_2008R2_X64
(local)\DEV_2008_X64   10.0.6000.29     MSSQL$DEV_2008_X64
(local)\DEV_2012_X64   11.0.7001.0      MSSQL$DEV_2012_X64
(local)\DEV_2014_X64   12.0.6024.0      MSSQL$DEV_2014_X64
(local)\DEV_2016       13.0.6441.1      MSSQL$DEV_2016
(local)\DEV_2017       14.0.1000.169    MSSQL$DEV_2017
(local)\DEV_2019       15.0.2000.5      MSSQL$DEV_2019
```

&#x1F31F; List Installed SQL Server Services, wait up to 30 seconds for each SQL Server health check to pass, and populate Version column
```powershell
Find-Local-SqlServers | 
     Populate-Local-SqlServer-Version -Timeout 30 |
     ft -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host

Instance               InstallerVersion Service              Version
--------               ---------------- -------              -------                                     
(local)                16.0.1000.6      MSSQLSERVER          16.0.4145.4 Developer Edition (64-bit) RTM CU15
(local)\ADV_2005_X86   9.00.5000.00     MSSQL$ADV_2005_X86   9.00.5000.00 Express Edition with Advanced SP4
(local)\ADV_2008R2_X64 10.50.6000.34    MSSQL$ADV_2008R2_X64 10.50.6000.34 Express Edition with Advanced SP3
(local)\ADV_2008_X86   10.0.1600.22     MSSQL$ADV_2008_X86   10.0.6000.29 Express Edition with Advanced SP4
(local)\DEV2022UTF8    16.0.1000.6      MSSQL$DEV2022UTF8    16.0.4145.4 Developer Edition (64-bit) RTM CU15
(local)\DEV_2008R2_X64 10.50.6000.34    MSSQL$DEV_2008R2_X64 10.50.6000.34 Developer Edition (64-bit) SP3
(local)\DEV_2008_X64   10.0.6000.29     MSSQL$DEV_2008_X64   10.0.6000.29 Developer Edition (64-bit) SP4
(local)\DEV_2012_X64   11.0.7001.0      MSSQL$DEV_2012_X64   11.0.7001.0 Developer Edition (64-bit) SP4
(local)\DEV_2014_X64   12.0.6024.0      MSSQL$DEV_2014_X64   12.0.6024.0 Developer Edition (64-bit) SP3
(local)\DEV_2016       13.0.6441.1      MSSQL$DEV_2016       13.0.6441.1 Developer Edition (64-bit) SP3
(local)\DEV_2017       14.0.1000.169    MSSQL$DEV_2017       14.0.3456.2 Developer Edition (64-bit) RTM CU31
(local)\DEV_2019       15.0.2000.5      MSSQL$DEV_2019       15.0.4385.2 Developer Edition (64-bit) RTM CU28
```

&#x1F31F; List Installed SQL Server Services
```powershell
Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | ft -AutoSize

Status  Name                 DisplayName
------  ----                 -----------
Running MSSQL$ADV_2005_X86   SQL Server (ADV_2005_X86)
Running MSSQL$ADV_2008_X86   SQL Server (ADV_2008_X86)
Running MSSQL$ADV_2008R2_X64 SQL Server (ADV_2008R2_X64)
Running MSSQL$DEV_2008_X64   SQL Server (DEV_2008_X64)
Running MSSQL$DEV_2008R2_X64 SQL Server (DEV_2008R2_X64)
Running MSSQL$DEV_2012_X64   SQL Server (DEV_2012_X64)
Running MSSQL$DEV_2014_X64   SQL Server (DEV_2014_X64)
Running MSSQL$DEV_2016       SQL Server (DEV_2016)
Running MSSQL$DEV_2017       SQL Server (DEV_2017)
Running MSSQL$DEV_2019       SQL Server (DEV_2019)
Running MSSQL$DEV2022UTF8    SQL Server (DEV2022UTF8)
Running MSSQLSERVER          SQL Server (MSSQLSERVER)

```

&#x1F31F; Wait up to 30 seconds for the SQL Server health check to pass, and return its version
```powershell
Query-SqlServer-Version -Title "Default MS SQL SERVER" -Instance "(local)" -Timeout 30
```

&#x1F31F; Wait up to 30 seconds for the SQL Server health check to pass, and return its version (on Linux)
```powershell
Query-SqlServer-Version -Title "SQL Server" `
      -ConnectionString "Data Source=localhost,1433;User ID=sa;Password=passw0rd!;Encrypt=False;" `
      -Timeout 30
```

&#x1F31F; Start SQL Server Instances that are currently stopped
```powershell
Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | 
   ? { $_.Status -ne "Running" } | 
   % { Write-Host "Starting $($_.Name)"; Start-Service "$($_.Name)" }

```

&#x1F31F; Stop SQL Server Instances that are currently running
```powershell
Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | 
   ? { $_.Status -ne "Stopped" } | 
   % { Write-Host "Stopping $($_.Name)"; Stop-Service "$($_.Name)" -Force }
```

## SQL Server LocalDB functions
&#x1F31F; Install all the versions of SQL Server LocalDB:
```powershell
Setup-SqlServers "
  2022 LocalDB,
  2019 LocalDB,
  2017 LocalDB,
  2016 LocalDB,
  2014 LocalDB,
  2012 LocalDB
"
```

&#x1F31F; List Installed SQL Server LocalDB Versions:
```powershell
Find-LocalDb-Versions |
     ft -Property ShortVersion, InstallerVersion -AutoSize |
     Out-String -Width 1234 |
     Out-Host

ShortVersion InstallerVersion
------------ ----------------
16.0         16.0.1000.6
15.0         15.0.4382.1
14.0         14.0.1000.169
13.0         13.3.6300.2
12.0         12.3.6024.0
11.0         11.4.7001.0
```

&#x1F31F; List SQL Server LocalDB Instances and their version:
```powershell
Find-LocalDb-SqlServers | Populate-Local-SqlServer-Version |
     ft -AutoSize |
     Out-String -Width 1234 |
     Out-Host

Instance                Version
--------                -------
(LocalDB)\LocalDB-v11.0 11.0.7001.0 LocalDB Express Edition (64-bit) SP4
(LocalDB)\LocalDB-v12.0 12.0.6024.0 LocalDB Express Edition (64-bit) SP3
(LocalDB)\LocalDB-v13.0 13.0.6300.2 LocalDB Express Edition (64-bit) SP3
(LocalDB)\LocalDB-v14.0 14.0.1000.169 LocalDB Express Edition (64-bit) RTM
(LocalDB)\LocalDB-v15.0 15.0.4382.1 LocalDB Express Edition (64-bit) RTM CU27
(LocalDB)\LocalDB-v16.0 16.0.1000.6 LocalDB Express Edition (64-bit) RTM
(LocalDB)\MSSQLLocalDB  15.0.4382.1 LocalDB Express Edition (64-bit) RTM CU27
(LocalDB)\My-v13.0      13.0.6300.2 LocalDB Express Edition (64-bit) SP3
(LocalDB)\v11.0         11.0.7001.0 LocalDB Express Edition (64-bit) SP4
```

&#x1F31F; Create SQL Server LocalDB Instance per version using pattern ```LocalDB-v{Version}```:
```powershell
foreach($localDb in Find-LocalDb-Versions) {
  $instance = "LocalDB-v$($localDb.ShortVersion)"
  Write-Host "Creating Instance $instance version $($localDb.ShortVersion)"
  $isCreated = Create-LocalDB-Instance `
    -InstanceName $instance `
    -OptionalVersion $localDb.ShortVersion
}
```
