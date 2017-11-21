rem *** BUILD ***
call Prepare-Nuget-and-Build-Tools.cmd
"%BUILD_TOOLS_ONLINE%\nuget.exe" restore
"%MS_BUILD_2017%"  /t:Rebuild /v:m /p:Configuration=Debug
"%MS_BUILD_2017%"  /t:Rebuild /v:m /p:Configuration=Release

rem *** TEST *** 
pushd Universe.SqlServerJam.Tests\bin\Release
"%NUNIT_CONSOLE_RUNNER%" --labels=On --workers=1 Universe.SqlServerJam.Tests.dll | tee tests.log
"%REPORT_UNIT%" .\ 1>report_uit.log 2>&1
popd
