@Echo Off
for /f %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
echo %ESC%[41m %* %ESC%[%m
