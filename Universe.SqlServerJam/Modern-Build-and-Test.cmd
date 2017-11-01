rem *** BUILD ***
call Prepare-Nuget-and-Build-Tools.cmd
"%BUILD_TOOLS_ONLINE%\nuget.exe" restore
"%MS_BUILD_2017%" CacheInvalidation.sln /t:Rebuild /v:m /p:Configuration=Debug
"%MS_BUILD_2017%" CacheInvalidation.sln /t:Rebuild /v:m /p:Configuration=Release

rem *** START REDIS ***
pushd SampleDb.Tests\redis-2.8
call restart.cmd
popd

rem *** TEST *** 
pushd SampleDb.Tests\bin\Debug\
"%NUNIT_CONSOLE_RUNNER%" --labels=On --workers=1 SampleDb.Tests.exe
"%REPORT_UNIT%" .\ 1>report_uit.log 2>&1
popd
