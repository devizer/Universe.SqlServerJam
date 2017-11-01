pushd "%LOCALAPPDATA%"
echo [System.DateTime]::Now.ToString("yyyy-MM-dd,HH-mm-ss") | powershell -command - > .backup.timestamp
for /f %%i in (.backup.timestamp) do set datetime=%%i
popd

"C:\Program Files\7-Zip\7zG.exe" a -t7z -mx=9 -mfb=128 -md=128m -ms=on -xr!.git -xr!bin -xr!obj -xr!packages -xr!.vs ^
  "C:\Users\Backups on Google Drive\Universe.SqlServerJam (%datetime%).7z" .

