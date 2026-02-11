$ErrorActionPreference = "Stop";

$ENV:SENSORSAPP_STRESS_WORKINGSET_ROWS="1000"
# MilliSeconds
$ENV:SENSORSAPP_STRESS_DURATION="10"

$ENV:TEST_SQL_NET_DURATION_OF_Upload=42
$ENV:TEST_SQL_NET_DURATION_OF_Download=42
$ENV:TEST_SQL_NET_DURATION_OF_Ping=42

del bin/*

$commitsRaw = & { set TZ=GMT; git log -n 999999 --date=raw --pretty=format:"%cd" }
$lines = "$commitsRaw".Split([Environment]::NewLine)
$commitCount = $lines.Length
$ver="2.1.$($commitCount)"
Write-Host "Version: $ver" -ForegroundColor Yellow

$curdir=$(pwd)
pushd ..\Universe.SqlServerJam.Tests
Measure-Action "PACK Universe.SqlServerJam" { & dotnet test -f net8.0 }
# dotnet test --filter "Name ~ Full_Featured_Demo & Name !~ Meashure_Upload_Speed & Name !~ Meashure_Download_Speed" -f net8.0
# dotnet test --filter "Name ~ Full_Featured_Demo" -f net8.0
if (-not $?) { throw 'Test Failed. Pack aborted'; exit 7 }
popd

pushd ..\Universe.SqlServerJam
# dotnet pack -c Release -p:PackageVersion=$ver -p:Version=$ver -o "$curdir\bin"
dotnet pack -c Release -o "$curdir\bin" -v:q /p:NoWarn=NETSDK1215
popd
