$ErrorActionPreference = "Stop";

$ENV:SENSORSAPP_STRESS_WORKINGSET_ROWS="1000"
# MilliSeconds
$ENV:SENSORSAPP_STRESS_DURATION="10"


del bin/*

$commitsRaw = & { set TZ=GMT; git log -n 999999 --date=raw --pretty=format:"%cd" }
$lines = $commitsRaw.Split([Environment]::NewLine)
$commitCount = $lines.Length
$ver="2.1.$($commitCount)"
Write-Host "Version: $ver" -ForegroundColor Yellow

$curdir=$(pwd)
pushd ..\Universe.SqlServerJam.Tests
dotnet test -f net8.0
if (-not $?) { throw 'Test Failed. Pack aborted'; exit 7 }
popd

pushd ..\Universe.SqlServerJam
dotnet pack -c Release -p:PackageVersion=$ver -p:Version=$ver -o "$curdir\bin"
popd
