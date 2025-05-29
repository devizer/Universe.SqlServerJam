set FMT=yyyy-MM-dd,HH-mm-ss&& for /f "delims=;" %%i in ('powershell -command "[System.DateTime]::Now.ToString($ENV:FMT)"') DO set datetime=%%i

7za a -t7z -mx=9 -mfb=128 -md=128m -ms=on -mqs=on -xr!.git -xr!bin -xr!obj -xr!.vs ^
  "C:\Cloud\vg\backup\Universe.CpuInfo (%datetime%).7z" .

