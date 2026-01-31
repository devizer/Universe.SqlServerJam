# Run-Remote-Script https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Scripts/Launch-Sql-Discovery.ps1
$url="https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Scripts/LocalSqlDiscovery-net4.5.7z"
$workFolder="$($ENV:SystemDrive)\Temp\Sql-Discovery"
$archiveFull="$workFolder\LocalSqlDiscovery-net4.5.7z"
$okDownload = Download-File-FailFree $archiveFull @($url)
cd "$workFolder"
# ls | out-host
& 7z.exe x -bso0 -bsp0 -y LocalSqlDiscovery-net4.5.7z
cd LocalSqlDiscovery-net4.5
$outputFile = "SHOW-SQL-Servers.log"
& .\SHOW-SQL-Servers.cmd *| tee "$outputFile"
$mediumVersion = Get-Content "$outputFile" | ? {$_ -match "Medium Version"} | % {$_.Split(":") | Select -Last 1 | % { "$_".Trim() }}
$mediumVersion = @($mediumVersion | Sort-Object -Property @{ Expression = { To-Sortable-Version-String $_ }; Descending = $false })
$mediumVersion = @($mediumVersion | % { "   * $_" })
Write-Line -TextGreen "Medium Version(s)" -Reset
Write-Host ($mediumVersion -join ([Environment]::NewLine))
