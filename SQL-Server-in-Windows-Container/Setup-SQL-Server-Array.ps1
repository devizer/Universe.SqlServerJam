        $SqlServers = @(
<#
           '2025 Developer',
           '2025 Core',
           '2025 LocalDB',
           '2022 Developer Update',
           '2022 Developer',
           '2022 Advanced Update',
           '2022 Advanced',
           '2022 Core Update',
           '2022 Core',
           '2022 LocalDB',
           '2019 Developer Update',
           '2019 Developer',
           '2019 Advanced Update',
           '2019 Advanced',
           '2019 Core Update',
           '2019 Core',
           '2019 LocalDB',
           '2017 Developer Update',
           '2017 Developer',
           '2017 Advanced Update',
           '2017 Advanced',
           '2017 Core Update',
           '2017 Core',
           '2017 LocalDB',
           '2016 Developer Update',
           '2016 Developer',
           '2016 Advanced Update',
           '2016 Advanced',
           '2016 Core Update',
           '2016 Core',
           '2016 LocalDB',
           '2014-x64 Developer',
           '2014-x64 Advanced',
           '2014-x64 Core',
           '2014-x64 LocalDB',
           '2014-x86 Developer', 
           '2014-x86 Advanced',
           '2014-x86 Core',
#>
           
           '2008R2-x64 Developer',
           '2008R2-x64 Advanced Update',
           '2008R2-x64 Advanced',
           '2008R2-x64 Core Update',
           '2008R2-x64 Core',
           '2008R2-x86 Developer',
           '2008R2-x86 Advanced Update',
           '2008R2-x86 Advanced',
           '2008R2-x86 Core Update',
           '2008R2-x86 Core',
           '2008-x64 Developer Update',
           '2008-x64 Developer',
           '2008-x64 Advanced Update',
           '2008-x64 Advanced',
           '2008-x64 Core Update',
           '2008-x64 Core',
           '2008-x86 Developer Update',
           '2008-x86 Developer',
           '2008-x86 Advanced Update',
           '2008-x86 Advanced',
           '2008-x86 Core Update',
           '2008-x86 Core',

           '2005-x86 Advanced Update',
           '2005-x86 Advanced',
           '2005-x86 Core',

           '2012-x86 Developer',
           '2012-x86 Advanced',
           '2012-x86 Core',
           '2012-x64 Developer',
           '2012-x64 Advanced',
           '2012-x64 Core',
           '2012-x64 LocalDB'
        );
        
        [array]::Reverse($SqlServers)

        $ErrorActionPreference = 'Continue' 
        cd SQL-Server-in-Windows-Container

        & curl -o Install-SqlServer-Version-Management.ps1 -kfsSL "https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/SqlServer-Version-Management/Install-SqlServer-Version-Management.ps1"
        # ls
        
        foreach($vc in "vcredist2005_x64.exe", "vcredist2005_x86.exe", "vcredist2008_x86.exe", "vcredist2008_x64.exe") {
          $vcUrl="https://github.com/devizer/glist/blob/master/bin/vcredist/$vc"
          $vcUrl="https://raw.githubusercontent.com/devizer/glist/master/bin/vcredist/$vc"
          Download-File-FailFree-and-Cached "$(Get-Location)\$vc" "$vcUrl"
        }
        # ls "vcredist*"
        New-item C:\SQL -ItemType Directory -Force -EA SilentlyContinue | Out-Null
        $mnt="type=bind,source=$(Get-Location),target=C:\App"
        echo "--mount parameter is: [$mnt]"
        $index=0; $count=$SqlServers.Length
        $blockSetup = { $sql = $_;
          $index++
          Write-Host "$index/$count SQL: '$sql'"
          Remove-Item -Path "C:\SQL\*" -Recurse -Force

          & { & docker run -d --name sql-server --hostname sql-server --memory 4g --cpus 3 "--isolation=$ENV:ISOLATION" `
            --mount "$mnt" --mount type=bind,source=C:\SQL,target=C:\SQL `
            -e SQL="$sql" -e PS1_TROUBLE_SHOOT="On" -e SQLSERVERS_SETUP_FOLDER="C:\Temp\SQL-Setup" `
            --workdir=C:\App --entrypoint powershell "$($env:THEIMAGE):$($env:TAG)" -Command "Sleep 2147482; Wait-Event;" } 2>&1 | out-host

          & { & docker exec sql-server powershell -Command "cd C:\App; . .\Install-SqlServer-Version-Management.ps1; . .\Setup-SQL-Server-in-Container.ps1;" } 2>&1 |
            tee-object "$ENV:SYSTEM_ARTIFACTSDIRECTORY/OUTPUT $sql.txt" } 2>&1 | out-host

          Write-Host "Removing the sql-server container"
          & { & docker rm -f sql-server } 2>&1 | out-host
          Write-Host " "
          Write-Host "---------------------------------------------- $index/$count [$SQL] Finished -----------------------------------------"
          Write-Host " "
        }

        $errors = @($SqlServers | Try-Action-ForEach -ActionTitle "SETUP SQL SERVER IN CONTAINER" -Action $blockSetup -ItemTitle { "$_" })
        Write-Host "SETUP ERRORS COUNT = $($errors.Count)"
        Write-Host $errors
