rem dotnet tool install --global trx2html
rem trx2html TestResults\*.trx
dotnet test --logger trx -f net6.0 -c Release /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:CoverletOutput=$(Build.SourcesDirectory)/coverage/

