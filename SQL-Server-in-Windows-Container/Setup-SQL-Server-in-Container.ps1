cd C:\App
pushd .
. .\Install-SqlServer-Version-Management.ps1
popd
$ENV:TF_BUILD='True'

function DO_NOT_SKIP() {

pushd .
Write-Host Installing $ENV:SQL
Write-Host Fix Performance Counter 64bit
cd $env:systemroot\system32
& lodctr /R
Write-Host Fix Performace Counters 32bit
cd $env:systemroot\syswow64
& lodctr /R
popd

}

DO_NOT_SKIP


Say Starting winmgmt
start-service winmgmt

Say Starting RPC
Start-Service -Name "RpcSs"

<#

Measure-Action "VC Redist 2005 x64" { & .\vcredist2005_x64.exe /q }
Measure-Action "VC Redist 2008 x64" { & .\vcredist2008_x64.exe /qn /norestart }
Measure-Action "VC Redist 2005 x86" { & .\vcredist2005_x86.exe /q }
Measure-Action "VC Redist 2008 x86" { & .\vcredist2008_x86.exe /qn /norestart }

Say "Starting vcredist2005_x64.exe ..."
& .\vcredist2005_x64.exe /q
Say "Starting vcredist2008_x64.exe ..."
& .\vcredist2008_x64.exe /qn /norestart
Say "Starting vcredist2005_x86.exe ..."
& .\vcredist2005_x86.exe /q
Say "Starting vcredist2008_x86.exe ..."
& .\vcredist2008_x86.exe /qn /norestart

#>


If ("$ENV:SQL" -match 2005) { Setup-SqlServers "$ENV:SQL" }
ElseIf ("$ENV:SQL" -match 2008 -or "$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterNotCorruptedCheck } 
Else { Setup-SqlServers "$ENV:SQL" /SkipRules=PerfMonCounterCheck }

# Setup-SqlServers "$ENV:SQL"

Publish-SQLServer-SetupLogs "C:\App\SQL Setup Logs\Setup of $ENV:SQL"

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