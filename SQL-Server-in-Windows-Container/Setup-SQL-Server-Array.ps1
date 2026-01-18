        $SqlServers = @(
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
           '2012-x64 Developer',
           '2012-x64 Advanced',
           '2012-x64 Core',
           '2012-x86 Developer',
           '2012-x86 Advanced',
           '2012-x86 Core',
           '2012-x64 LocalDB',
           
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
           '2005-x86 Core'

        );
        
        [array]::Reverse($SqlServers)

        & curl -o Install-SqlServer-Version-Management.ps1 -kfsSL "https://raw.githubusercontent.com/devizer/Universe.SqlServerJam/master/SqlServer-Version-Management/Install-SqlServer-Version-Management.ps1"
        foreach($vc in "vcredist2005_x64.exe", "vcredist2005_x86.exe" "vcredist2008_x86.exe", "vcredist2008_x86.exe") {
          $vcUrl="https://github.com/devizer/glist/blob/master/bin/vcredist/$vc"
          Download-File-FailFree-and-Cached "$vc" "$vcUrl"
        }
        ls Install-SqlServer-Version-Management.ps1
        ls "vcredist*"
        foreach($sql in $SqlServers) {
          echo "SQL: '$sql'"
          $mnt="type=bind,source=$(Get-Location),target=C:\App"
          echo "--mount parameter is: [$mnt]"
          & docker run --rm --memory 4g --cpus 3 "--isolation=$ENV:ISOLATION" --mount "$mnt" -e SQL="$sql" -e PS1_TROUBLE_SHOOT="On" -e SQLSERVERS_SETUP_FOLDER="C:\Temp\SQL-Setup" --entrypoint powershell "$($env:THEIMAGE):$($env:TAG)" -Command "
            . C:\App\Install-SqlServer-Version-Management.ps1
            `$ENV:TF_BUILD='True'
            Write-Host Installing `$ENV:SQL
            cd C:\App
            # VC runtime 2005 and 2008
            vcredist2005_x64.exe /q
            vcredist2008_x64.exe /qn /norestart
            vcredist2005_x86.exe /q
            vcredist2008_x86.exe /qn /norestart

            Setup-SqlServers `"`$ENV:SQL`"
            Publish-SQLServer-SetupLogs `"C:\App\Setup Logs of `$ENV:SQL`"

          " | tee-object "$ENV:SYSTEM_ARTIFACTSDIRECTORY/Setup $sql.txt"
          Write-Host " "
          Write-Host "---------------------------------"
          Write-Host " "
        }

