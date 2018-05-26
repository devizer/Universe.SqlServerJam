setx SQLSERVER_WELLKNOWN_Linux "Server=192.168.0.18;User ID=sa;Password=`1qazxsw2"
echo "Server=192.168.0.8;User ID=sa;Password=`1qazxsw2"
rem docker run --name mssql_2017 -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=`1qazxsw2' -p 1433:1433 --restart unless-stopped microsoft/mssql-server-linux:latest
