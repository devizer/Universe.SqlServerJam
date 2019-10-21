       $names = @();
       foreach($path in @('HKLM:\SOFTWARE\Microsoft\Microsoft SQL Server', 'HKLM:\SOFTWARE\WOW6432Node\Microsoft\Microsoft SQL Server')) {
           try { $v = (get-itemproperty $path).InstalledInstances; $names += $v } catch {}
       }

       [System.Array]::Sort($names);
       foreach($sqlname in $names) {
           Write-Host "SQL: $sqlname"

           [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.Smo") | Out-Null
           [reflection.assembly]::LoadWithPartialName("Microsoft.SqlServer.SqlWmiManagement") | Out-Null

           $serverName = $env:COMPUTERNAME
           $instanceName = $sqlname
           $wmi = new-object ('Microsoft.SqlServer.Management.Smo.Wmi.ManagedComputer')

           # Enable TCP/IP
           $uri = "ManagedComputer[@Name='$serverName']/ServerInstance[@Name='$instanceName']/ServerProtocol[@Name='Tcp']"
           $Tcp = $wmi.GetSmoObject($uri)
           $Tcp.IsEnabled = $true
           $TCP.alter()

           # Enable named pipes
           $uri = "ManagedComputer[@Name='$serverName']/ ServerInstance[@Name='$instanceName']/ServerProtocol[@Name='Np']"
           $Np = $wmi.GetSmoObject($uri)
           $Np.IsEnabled = $true
           $Np.Alter()

           Set-Service SQLBrowser -StartupType Manual
           Start-Service SQLBrowser
           Start-Service "MSSQL`$$instanceName"
       }
