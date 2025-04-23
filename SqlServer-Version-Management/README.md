## SqlServer-Version-Management Powershell Module
SQL Server Setup and Management including Developer, Express, and LocalDB editions.
The intended use of this project is for Continuous Integration (CI) scenarios, where:
- A SQL Server or LocalDB needs to be installed without user interaction.
- A SQL Server or LocalDB installation doesn't need to persist across multiple CI runs.

SQL Server Setup defaults:
- Installs SQL Engine and full text search,
- Adds current user to SQL Server Administrators, 
- Turns on TCP/IP and Named Pipe protocols,
- Default sa password is 'Meaga`$trong'.

## Supported SQL Server version arguments:
&#x2714;&nbsp;&nbsp; _2022 Developer Update_: &nbsp;&nbsp; 16.0.4135.4 RTM CU14 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Developer_: &nbsp;&nbsp; 16.0.1000.6 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Advanced Update_: &nbsp;&nbsp; 16.0.4135.4 RTM CU14 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Advanced_: &nbsp;&nbsp; 16.0.1000.6 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Core Update_: &nbsp;&nbsp; 16.0.4135.4 RTM CU14 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 Core_: &nbsp;&nbsp; 16.0.1000.6 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2022 LocalDB_: &nbsp;&nbsp; 16.0.1000.6 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Developer Update_: &nbsp;&nbsp; 15.0.4385.2 RTM CU28 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Developer_: &nbsp;&nbsp; 15.0.2000.5 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Advanced Update_: &nbsp;&nbsp; 15.0.4385.2 RTM CU28 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Advanced_: &nbsp;&nbsp; 15.0.2000.5 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Core Update_: &nbsp;&nbsp; 15.0.4385.2 RTM CU28 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 Core_: &nbsp;&nbsp; 15.0.2000.5 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2019 LocalDB_: &nbsp;&nbsp; 15.0.2000.5 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Developer Update_: &nbsp;&nbsp; 14.0.3456.2 RTM CU31 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Developer_: &nbsp;&nbsp; 14.0.1000.169 RTM Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Advanced Update_: &nbsp;&nbsp; 14.0.3456.2 RTM CU31 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Advanced_: &nbsp;&nbsp; 14.0.1000.169 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Core Update_: &nbsp;&nbsp; 14.0.3456.2 RTM CU31 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 Core_: &nbsp;&nbsp; 14.0.1000.169 RTM Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2017 LocalDB_: &nbsp;&nbsp; 14.0.1000.169 RTM LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Developer Update_: &nbsp;&nbsp; 13.0.6441.1 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Developer_: &nbsp;&nbsp; 13.0.6404.1 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Advanced Update_: &nbsp;&nbsp; 13.0.6441.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Advanced_: &nbsp;&nbsp; 13.0.6404.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Core Update_: &nbsp;&nbsp; 13.0.6441.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 Core_: &nbsp;&nbsp; 13.0.6404.1 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2016 LocalDB_: &nbsp;&nbsp; 13.0.6300.2 SP3 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Developer_: &nbsp;&nbsp; 12.0.6024.0 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Advanced_: &nbsp;&nbsp; 12.0.6024.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 Core_: &nbsp;&nbsp; 12.0.6024.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x64 LocalDB_: &nbsp;&nbsp; 12.0.6024.0 SP3 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Developer_: &nbsp;&nbsp; 12.0.6024.0 SP3 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Advanced_: &nbsp;&nbsp; 12.0.6024.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2014-x86 Core_: &nbsp;&nbsp; 12.0.6024.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Developer_: &nbsp;&nbsp; 11.0.7001.0 SP4 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Advanced_: &nbsp;&nbsp; 11.0.7001.0 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 Core_: &nbsp;&nbsp; 11.0.7001.0 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x64 LocalDB_: &nbsp;&nbsp; 11.0.7001.0 SP4 LocalDB Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Developer_: &nbsp;&nbsp; 11.0.7001.0 SP4 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Advanced_: &nbsp;&nbsp; 11.0.7001.0 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2012-x86 Core_: &nbsp;&nbsp; 11.0.7001.0 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Developer_: &nbsp;&nbsp; 10.50.6000.34 SP3 Developer Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Advanced Update_: &nbsp;&nbsp; 10.50.6000.34 SP3 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Advanced_: &nbsp;&nbsp; 10.50.4000.0 SP2 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Core Update_: &nbsp;&nbsp; 10.50.6000.34 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x64 Core_: &nbsp;&nbsp; 10.50.4000.0 SP2 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Developer_: &nbsp;&nbsp; 10.50.6000.34 SP3 Developer Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Advanced Update_: &nbsp;&nbsp; 10.50.6000.34 SP3 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Advanced_: &nbsp;&nbsp; 10.50.4000.0 SP2 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Core Update_: &nbsp;&nbsp; 10.50.6000.34 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008R2-x86 Core_: &nbsp;&nbsp; 10.50.4000.0 SP2 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Advanced Update_: &nbsp;&nbsp; 10.0.6000.29 SP4 Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Advanced_: &nbsp;&nbsp; 10.0.1600.22 RTM Express Edition with Advanced Services (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Core Update_: &nbsp;&nbsp; 10.0.6000.29 SP4 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x64 Core_: &nbsp;&nbsp; 10.0.5500.0 SP3 Express Edition (64-bit)<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Advanced Update_: &nbsp;&nbsp; 10.0.6000.29 SP4 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Advanced_: &nbsp;&nbsp; 10.0.1600.22 RTM Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Core Update_: &nbsp;&nbsp; 10.0.6000.29 SP4 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2008-x86 Core_: &nbsp;&nbsp; 10.0.5500.0 SP3 Express Edition<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Advanced Update_: &nbsp;&nbsp; 9.00.5000.00 SP4 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Advanced_: &nbsp;&nbsp; 9.00.3042.00 SP2 Express Edition with Advanced Services<br/>
&#x2714;&nbsp;&nbsp; _2005-x86 Core_: &nbsp;&nbsp; 9.00.5000.00 SP4 Express Edition<br/>


## Setup-SqlServers function
&#x1F31F; Install SQL Server 2022 Developer Edition with Cumulative Update as default instance (local) with UTF8 Collation:
```powershell
Setup-SqlServers "2022 Developer Updated: MSSQLSERVER" `
                 "Collation=Latin1_General_100_CI_AS_SC_UTF8"
```

&#x1F31F; Install SQL Server 2019 Developer Edition RTM as DEVELOPER2019 instance:
```powershell
Setup-SqlServers "2019 Developer Updated: DEVELOPER2019"
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
     % { [pscustomObject] $_ } | 
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

&#x1F31F; Wait up to 30 seconds for the SQL Server health check to pass, then display its version
```
Query-SqlServer-Version -Title "Default MS SQL SERVER" -Instance "(local)" -Timeout 30
```

&#x1F31F; Wait up to 30 seconds for the SQL Server health check to pass, then display its version (on Linux)
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
