$ErrorActionPreference = "Stop";

del bin/*

$commitsRaw = & { set TZ=GMT; git log -n 999999 --date=raw --pretty=format:"%cd" }
$lines = $commitsRaw.Split([Environment]::NewLine)
$commitCount = $lines.Length
$ver="1.0.$($commitCount)"
Write-Host "Version: $ver" -ForegroundColor Yellow
$curdir=$(pwd)

pushd ..\Universe.SqlServerJam.Tests
dotnet test
if (-not $?) { throw 'Test Failed. Pack aborted'; }
popd

pushd ..\Universe.SqlServerJam
dotnet pack -c Release -p:PackageVersion=$ver -p:Version=$ver -o "$curdir\bin"
popd
