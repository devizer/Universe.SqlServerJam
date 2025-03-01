docker rm -f sqlserver
docker run --name sqlserver --privileged -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=p@assw0rd!" -p 1433:1433 -d mcr.microsoft.com/mssql/server:2022-latest
password='p@assw0rd!'
export SQL_SERVER_CONTAINER_NAME=sqlserver SQL_PING_TIMEOUT=30 SQL_PING_PARAMETERS="-No -C -S localhost -U sa -P \""$password"\"" 
script=https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/Add-SqlCmd-to-Path-for-Linux-Container.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash
