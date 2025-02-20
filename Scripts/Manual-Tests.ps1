
# In-Process Only
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/SqlServer-Version-Management/SqlServer-Version-Management.ps1'))

# Permanent
iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/SqlServer-Version-Management/Install-SqlServer-Version-Management.ps1'))

$ENV:PS1_TROUBLE_SHOOT = "On"
$ENV:SQLSERVERS_MEDIA_FOLDER = "T:\SQL-Media"
$ENV:SQLSERVERS_SETUP_FOLDER = "T:\SQL-Setup"
& setx.exe PS1_TROUBLE_SHOOT On
& setx.exe SQLSERVERS_MEDIA_FOLDER "$ENV:SQLSERVERS_MEDIA_FOLDER"
& setx.exe SQLSERVERS_SETUP_FOLDER "$ENV:SQLSERVERS_SETUP_FOLDER"


Bootstrap-Aria2-If-Required -Force $true

# Startup: Automatic | Manual
# /SQLUSERDBDIR, /SQLUSERDBLOGDIR (2008+)
# /SQLTEMPDBDIR, /SQLTEMPDBLOGDIR (2008+)


# /SQLMINMEMORY, /SQLMAXMEMORY (2019+) in MB

$i="DEV2022U"
Setup-SqlServers "2022 Developer Updated: $i" "Collation=French_CI_AI" "Startup=Manual" "InstallTo=C:\SQL $i" "Password=Meaga`$tr0ng" `
  "/SQLUSERDBDIR=T:\SQL\{InstanceName} DATA" "/SQLUSERDBLOGDIR=T:\SQL\{InstanceName} LOG" `
  "/SQLTEMPDBDIR=T:\SQL\{InstanceName} TEMP DATA" "/SQLTEMPDBLOGDIR=T:\SQL\{InstanceName} TEMP LOG" `
  *| tee "T:\SQL Setup Log $i.txt"

& net.exe start "MSSQL`$$i"

Set-SQLServer-Options -Title "SQL $i" -Instance "(local)\$i" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 2048; "max server memory (MB)" = 4096 }


$i="EXPRESS2012"
Setup-SqlServers "2012 Core: $i" "Collation=French_CI_AI" "Startup=Manual" "InstallTo=C:\SQL $i" "Password=Meaga`$tr0ng" `
  "/SQLUSERDBDIR=T:\SQL\{InstanceName} DATA" "/SQLUSERDBLOGDIR=T:\SQL\{InstanceName} LOG" `
  "/SQLTEMPDBDIR=T:\SQL\{InstanceName} TEMP DATA" "/SQLTEMPDBLOGDIR=T:\SQL\{InstanceName} TEMP LOG" `
  *| tee "T:\SQL Setup Log $i.txt"

& net.exe start "MSSQL`$$i"

Set-SQLServer-Options -Title "SQL $i" -Instance "(local)\$i" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 2048; "max server memory (MB)" = 4096 }



$i="EXPRESS2005"
Setup-SqlServers "2005 Core: $i" "Collation=French_CI_AI" "Startup=Manual" "InstallTo=C:\SQL $i" "Password=Meaga`$tr0ng" `
  "/SQLUSERDBDIR=T:\SQL\{InstanceName} DATA" "/SQLUSERDBLOGDIR=T:\SQL\{InstanceName} LOG" `
  "/SQLTEMPDBDIR=T:\SQL\{InstanceName} TEMP DATA" "/SQLTEMPDBLOGDIR=T:\SQL\{InstanceName} TEMP LOG" `
  *| tee "T:\SQL Setup Log $i.txt"

& net.exe start "MSSQL`$$i"

Set-SQLServer-Options -Title "SQL $i" -Instance "(local)\$i" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 2048; "max server memory (MB)" = 4096 }


$i="DEV2008"
Setup-SqlServers "2008 Developer Updated: $i" "Collation=French_CI_AI" "Startup=Manual" "InstallTo=C:\SQL $i" "Password=Meaga`$tr0ng" `
  "/SQLUSERDBDIR=T:\SQL\{InstanceName} DATA" "/SQLUSERDBLOGDIR=T:\SQL\{InstanceName} LOG" `
  "/SQLTEMPDBDIR=T:\SQL\{InstanceName} TEMP DATA" "/SQLTEMPDBLOGDIR=T:\SQL\{InstanceName} TEMP LOG" `
  *| tee "T:\SQL Setup Log $i.txt"

& net.exe start "MSSQL`$$i"

Set-SQLServer-Options -Title "SQL $i" -Instance "(local)\$i" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 2048; "max server memory (MB)" = 4096 }


Setup-SqlServers "2014 Developer Updated: FAKE2014" "Features=SSMS"
