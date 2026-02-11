@rd /q /s Universe.SqlServerJam.Tests\bin\Debug\net8.0 2>nul 
dotnet build -f net8.0 | findstr "Version"
powershell -c "(Get-Item 'Universe.SqlServerJam.Tests\bin\Debug\net8.0\Universe.SqlServerJam.dll').VersionInfo.FileVersion"
dotnet msbuild Universe.SqlServerJam\Universe.SqlServerJam.csproj /t:pack /v:diag > pack.log.tmp
type pack.log.tmp | findstr /R "Target .* started"
rem type pack.log.tmp | findstr "Resolved Version By Git History"


dir Universe.SqlServerJam\bin\Release\*nupkg

