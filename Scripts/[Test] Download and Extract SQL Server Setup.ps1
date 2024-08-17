$ErrorActionPreference="Stop"

# --> ..\Includes\*.ps1 <--
# --> ..\Includes.SqlServer\*.ps1 <--

$SqlServerDownloadLinks | ConvertTo-Json -Depth 32

foreach($mt in "LocalDB", "Core", "Advanced", "Developer") {
foreach($ver in @("2016", "2017", "2019", "2022")) {
  Say "SQL Server $ver [$mt]"
  $result = Download-Fresh-SQL-Server-and-Extract $ver $mt
  $result | Format-Table -AutoSize | Out-String -Width 200
}}