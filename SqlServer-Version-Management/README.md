## SqlServer-Version-Management Powershell Module
SQL Server Setup and Management including Developer, Express, and LocalDB editions.
The intended use of this project is for Continuous Integration (CI) scenarios, where:

 - SQL Server or LocalDB needs to be installed without user interaction.
 - SQL Server or LocalDB installation doesn't need to persist across multiple CI runs.

SQL Server Setup defaults:

 - Features are SQL Engine and full text search,
 - Built-in Administrators (or localized name) are SQL Server Administrators for SSPI,
 - TCP/IP and Named Pipe protocols are on,
 - sa password is 'Meaga$tr0ng'.

## The Guide 
Moved to the [SqlServer-Version-Management](https://github.com/devizer/SqlServer-Version-Management) repo