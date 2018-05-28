type Prepare-NuGet-And-build-tools.ps1 | powershell -c -
call ~local-build-tools.cmd

rem *** BUILD ***
"%NUGET_EXE%" restore
"%MSBUILD_EXE%" /t:Rebuild /v:m /p:Configuration=Debug
"%MSBUILD_EXE%" /t:Rebuild /v:m /p:Configuration=Release

rem *** TEST *** 
if not defined TEST_SQL_NET_DURATION_OF_Ping     set TEST_SQL_NET_DURATION_OF_Ping=3000
if not defined TEST_SQL_NET_DURATION_OF_Upload   set TEST_SQL_NET_DURATION_OF_Upload=7000
if not defined TEST_SQL_NET_DURATION_OF_Download set TEST_SQL_NET_DURATION_OF_Download=7000
pushd Universe.SqlServerJam.Tests\bin\Release
"%NUNIT_RUNNER_EXE%" --labels=On --workers=1 Universe.SqlServerJam.Tests.dll | "%ESSENTIALS_PATH%\tee" tests.log
"%REPORT_UNIT_EXE%" .\ tests-report 1>report_unit.log 2>&1
popd
