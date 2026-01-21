cd C:\App
pushd .
# . .\Install-SqlServer-Version-Management.ps1
popd
$ENV:TF_BUILD='True'

function DO_NOT_SKIP() {

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

}

DO_NOT_SKIP


Say starting winmgmt
start-service winmgmt

Say Start RPC
Start-Service -Name "RpcSs"


# If ("$ENV:SQL" -match 2005) { Setup-SqlServers "$ENV:SQL" }
# ElseIf ("$ENV:SQL" -match 2008 -or "$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterNotCorruptedCheck } 
# Else { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterCheck }

Setup-SqlServers "$ENV:SQL"

Publish-SQLServer-SetupLogs "C:\App\Setup Logs of $ENV:SQL"

Say "List SQL Server Instances"
Find-Local-SqlServers | 
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host


Say "Query SQL Servers"
Find-Local-SqlServers | Populate-Local-SqlServer-Version |
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host

Say "Finish: $ENV:SQL"