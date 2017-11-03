set runner=C:\X\NUnit-Runner
set arch=C:\Apps\7-Zip-x86\
set folder=Universe.SqlServerJam.Tests.Standalone
rd /q /s Universe.SqlServerJam.Tests\bin\%folder% 1>nul 2>nul
mkdir Universe.SqlServerJam.Tests\bin\%folder% 1>nul 2>nul
xcopy /s /y Universe.SqlServerJam.Tests\bin\Debug\*.* Universe.SqlServerJam.Tests\bin\%folder%\*.*
xcopy /y /s %runner% Universe.SqlServerJam.Tests\bin\%folder%\NUnit-Runner\*.*
echo NUnit-Runner\nunit3-console.exe --labels=On --workers=1 Universe.SqlServerJam.Tests.dll > Universe.SqlServerJam.Tests\bin\%folder%\test.cmd
echo pause >> Universe.SqlServerJam.Tests\bin\%folder%\test.cmd

pushd Universe.SqlServerJam.Tests\bin\%folder%
cd ..
%arch%\7z a -t7z -mx=9 -mfb=128 -md=128m -ms=on -sfx7z.sfx %folder%.7z.exe %folder%
popd
