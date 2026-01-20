cd C:\App
. .\Install-SqlServer-Version-Management.ps1
$ENV:TF_BUILD='True'
Write-Host Installing $ENV:SQL
& .\vcredist2005_x64.exe /q
& .\vcredist2008_x64.exe /qn /norestart
& .\vcredist2005_x86.exe /q
& .\vcredist2008_x86.exe /qn /norestart

Write-Host fix 64
cd $env:systemroot\system32
& lodctr /R
Write-Host ' '
Write-Host Fix 32
cd $env:systemroot\syswow64
& lodctr /R
Write-Host ' '

Write-Host starting winmgmt
start-service winmgmt

Write-Host Start RPC
Start-Service -Name "RpcSs"


If ("$ENV:SQL" -match 2005) { Setup-SqlServers "$ENV:SQL" }
ElseIf ("$ENV:SQL" -match 2008 -or "$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterNotCorruptedCheck } 
Else { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterCheck }

Publish-SQLServer-SetupLogs "C:\App\Setup Logs of $ENV:SQL"

Write-Line -TextYellow "SQL Server Instances"
Find-Local-SqlServers | 
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host


Write-Line -TextYellow "Query SQL Servers"
Find-Local-SqlServers | Populate-Local-SqlServer-Version |
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host
