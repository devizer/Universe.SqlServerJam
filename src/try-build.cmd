@rd /q /s Universe.SqlServerJam.Tests\bin\Debug\net8.0 2>nul 
dotnet build -f net8.0 | findstr "Version"
powershell -c "(Get-Item 'Universe.SqlServerJam.Tests\bin\Debug\net8.0\Universe.SqlServerJam.dll').VersionInfo.FileVersion"
rd /q /s Universe.SqlServerJam\bin\Release
dotnet pack -c Release Universe.SqlServerJam\Universe.SqlServerJam.csproj | findstr "Version"
dir Universe.SqlServerJam\bin\Release\*nupkg
