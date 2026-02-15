cd C:\App

$dump_folder="C:\App"
if ($ENV:SYSTEM_ARTIFACTSDIRECTORY) { $dump_folder=$ENV:SYSTEM_ARTIFACTSDIRECTORY }
New-Item $dump_folder -Type Directory -Force -EA SilentlyContinue | out-null

Import-Module CimCmdlets -ErrorAction SilentlyContinue
Import-Module Microsoft.PowerShell.Management -ErrorAction SilentlyContinue

pushd .
if (Test-Path ".\Install-SqlServer-Version-Management.ps1") {
. .\Install-SqlServer-Version-Management.ps1
}
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

Say Starting RpcSs
Start-Service -Name "RpcSs"

Say Starting msiserver
Start-Service msiserver

if ("$ENV:SQL" -match 2012) {
  Say "Clean transaction folder 'C:\Windows\System32\config\txr' (2012 only)"
  Remove-Item -Path "C:\Windows\System32\config\txr" -Recurse -Force -ErrorAction SilentlyContinue
}

# Say Starting AppIDSvc
# Set-Service AppIDSvc -StartupType Automatic
# Start-Service AppIDSvc

Say Grant Full Access to Crypto Keys
$path = "$env:ProgramData\Microsoft\Crypto\RSA\MachineKeys"
$acl = Get-Acl $path
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("Everyone", "FullControl", "ContainerInherit, ObjectInherit", "None", "Allow")
$acl.AddAccessRule($rule)
Set-Acl $path $acl

Say Add Builtin SYSTEM to Administrators
& net localgroup Administrators "NT AUTHORITY\SYSTEM" /add

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

$collation = If ("$ENV:SQL" -match "2019" -or "$ENV:SQL" -match "2022" -or "$ENV:SQL" -match "2025") { "Latin1_General_100_CI_AS_SC_UTF8" } Else { "SQL_Latin1_General_CP1_CI_AS" };
Say "SQL Setup COLLATION = '$collation'"

$installTo = "$($ENV:SQLSERVERS_INSTALL_TO)"
if (-not $installTo) { $installTo = "C:\SQL" }
Write-Host "Target SQL Server Install Folder: [$installTo]"

try 
{ 
    If ("$ENV:SQL" -match 2005) { Setup-SqlServers "$ENV:SQL" "InstallTo=$installTo" }
    ElseIf ("$ENV:SQL" -match 2008) { Setup-SqlServers "$ENV:SQL" "InstallTo=$installTo" "Collation=$collation" /SkipRules=PerfMonCounterNotCorruptedCheck } 
    # ElseIf ("$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" "/SkipRules=PerfMonCounterNotCorruptedCheck FacetPowerShellCheck RebootRequiredCheck" } 
    # ElseIf ("$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" "/SkipRules=AllRules" } 
    # !!!!!!!!!!!!!!!!!!!!!!! /BROWSERSVCSTARTUPTYPE=Disabled
    ElseIf ("$ENV:SQL" -match 2012) { Setup-SqlServers "$ENV:SQL" "InstallTo=$installTo" "Collation=$collation" "/BROWSERSVCSTARTUPTYPE=Disabled" "/SkipRules=RebootRequiredCheck PerfMonCounterNotCorruptedCheck FacetPowerShellCheck AclPermissionsFacet Cluster_VerifyForErrors Cluster_IsOnlineIfServerIsClustered BlockMixedArchitectureInstall VSSShellInstalledFacet X86SupportedOn64BitCheck Wow64PlatformCheck NoGuidAllAppsCheck" } 
    Else { Setup-SqlServers "$ENV:SQL" "InstallTo=$installTo" "Collation=$collation" /SkipRules=PerfMonCounterCheck }

    # SkipRules="RebootRequiredCheck PerfMonCounterNotCorruptedCheck FacetPowerShellCheck AclPermissionsFacet Cluster_VerifyForErrors Cluster_IsOnlineIfServerIsClustered BlockMixedArchitectureInstall"
    # 2012: /SkipRules="PerfMonCounterNotCorruptedCheck FacetPowerShellCheck RebootRequiredCheck ServerCoreBlockUnsupportedSxSCheck"
} 
finally {
    $serverVersion = "$ENV:SQL".Split(":")[0]
    $artfifacts_folder="$ENV:SYSTEM_ARTIFACTSDIRECTORY"
    if ("$artfifacts_folder" -eq "") { $artfifacts_folder="C:\Artifacts" }
    Publish-SQLServer-SetupLogs "$artfifacts_folder\SQL Setup Logs\Setup of $serverVersion"
}

Say "List SQL Server Instances"
@(Find-Local-SqlServers) + @(Find-LocalDb-SqlServers) | 
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Out-Host


Say "Query SQL Servers"
@(Find-Local-SqlServers) + @(Find-LocalDb-SqlServers) | Populate-Local-SqlServer-Version |
     Format-Table -AutoSize | 
     Out-String -Width 1234 | 
     Tee-Object -FilePath "C:\App\POWERSHELL-DISCOVERY.TXT" |
     Out-Host


Write-Host "try sql discovery (net 4.5)"
Run-Remote-Script https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Scripts/Launch-Sql-Discovery.ps1 *>&1 | Tee-Object -FilePath "C:\App\SQL-DISCOVERY.TXT"

Say "Finish: $ENV:SQL"
