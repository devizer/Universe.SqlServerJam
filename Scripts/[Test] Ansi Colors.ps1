$ErrorActionPreference="Stop"

# Include Directive: [ ..\Includes\*.ps1 ]
# Include File: [\Includes\$Full7zLinksMetadata.ps1]
$Full7zLinksMetadata_onWindows = @(
  @{ Ver = 2301; 
     X64Links = @(
       "https://www.7-zip.org/a/7z2301-x64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x64-2301.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x64-2301.7z?viasf=1"
     );
     ARM64Links = @(
       "https://www.7-zip.org/a/7z2301-arm64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-arm64-2301.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-arm64-2301.7z?viasf=1"
     );
     X86Links = @(
       "https://www.7-zip.org/a/7z2301.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x86-2301.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x86-2301.7z?viasf=1"
     )
  },
  @{ Ver = 2201; 
     X64Links = @(
       "https://www.7-zip.org/a/7z2201-x64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x64-2201.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x64-2201.7z?viasf=1"
     );
     ARM64Links = @(
       "https://www.7-zip.org/a/7z2201-arm64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-arm64-2201.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-arm64-2201.7z?viasf=1"
     );
     X86Links = @(
       "https://www.7-zip.org/a/7z2201.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x86-2201.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x86-2201.7z?viasf=1"
     )
  },
  @{ Ver = 1900; 
     X64Links = @(
       "https://www.7-zip.org/a/7z1900-x64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x64-1900.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x64-1900.7z?viasf=1"
     );
     X86Links = @(
       "https://www.7-zip.org/a/7z1900.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x86-1900.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x86-1900.7z?viasf=1"
     )
  },
  @{ Ver = 1604;
     X64Links = @(
       "https://www.7-zip.org/a/7z1604-x64.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x64-1604.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x64-1604.7z?viasf=1"
     );
     X86Links = @(
       "https://www.7-zip.org/a/7z1604.exe",
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x86-1604.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x86-1604.7z?viasf=1"
     )
  },
  @{ Ver = 920;
     X86Links = @(
       "https://sourceforge.net/projects/p7zz-repack/files/windows/7z-full-x86-920.7z/download",
       "https://master.dl.sourceforge.net/project/p7zz-repack/windows/7z-full-x86-920.7z?viasf=1"
     )
  }
);

<# 
  https://www.7-zip.org/a/7z2301-arm64.exe
  https://www.7-zip.org/a/7z2301-x64.exe
  https://www.7-zip.org/a/7z2301.exe

  https://www.7-zip.org/a/7z2201-arm64.exe
  https://www.7-zip.org/a/7z2201-x64.exe
  https://www.7-zip.org/a/7z2201.exe

  https://www.7-zip.org/a/7z1900-x64.exe
  https://www.7-zip.org/a/7z1900.exe
  
  https://www.7-zip.org/a/7z1604-x64.exe
  https://www.7-zip.org/a/7z1604.exe
  
  https://www.7-zip.org/a/7z920.exe
  https://www.7-zip.org/a/7z920-arm.exe

  https://www.7-zip.org/a/7zr.exe
#>

# Include File: [\Includes\$VcRuntimeLinksMetadata.ps1]
$VcRuntimeLinksMetadata = @(
  @{ Ver=14; 
     Args="/install /passive /norestart"; 
     X64Link="https://aka.ms/vs/17/release/vc_redist.x64.exe"; 
     X86Link="https://aka.ms/vs/17/release/vc_redist.x86.exe"; 
     ARM64Link="https://aka.ms/vs/17/release/vc_redist.arm64.exe" 
  },
  @{ Ver=12; 
     Args="/install /passive /norestart"; 
     X64Link="https://aka.ms/highdpimfc2013x64enu"; 
     X86Link="https://aka.ms/highdpimfc2013x86enu"; 
  },
  @{ Ver=11; 
     Args="/install /passive /norestart"; 
     X64Link="https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe"; 
     X86Link="https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe"; 
  },
  @{ Ver=10; 
     Args="/q /norestart";
     X64Link="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x64.exe";       
     X86Link="https://download.microsoft.com/download/1/6/5/165255E7-1014-4D0A-B094-B6A430A6BFFC/vcredist_x86.exe";
  },
  @{ Ver=9;  
     Args="/q /norestart";                
     X64Link="https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x64.exe";       
     X86Link="https://download.microsoft.com/download/5/D/8/5D8C65CB-C849-4025-8E95-C3966CAFD8AE/vcredist_x86.exe"; 
  },
  @{ Ver=8;  
     Args="/q:a";   
     # FULLY SILENT X64 on x86: /q /c:"msiexec /i vcredist.msi IACCEPTSQLLOCALDBLICENSETERMS=YES /qn /L*v c:\vc8b-x64.log"
     X64Link="https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE";       
     X86Link="https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE"; 
  }
);

# Include File: [\Includes\Add-Folder-To-Path.ps1]
function Add-Folder-To-Path([string] $folder, [string] $target = "User", [switch] $includeProcess = $true ) {
  $thePath = [Environment]::GetEnvironmentVariable("PATH", "$target");
  $arr = $thePath.Split(";")
  $has = $null -ne ($arr | ? { $_ -eq $folder })
  if ($has) {
    Write-Host "Folder $folder already in the $($target) path"
  }
  else {
    $arr += "$folder"
    $newPath = $arr -join ";"
    Write-Host "New $($target) Path: '$newPath'"
    [Environment]::SetEnvironmentVariable("PATH", $newPath, "$target");
  }
  if (($includeProcess -eq $true) -and ($target -ne "Process")) { Add-Folder-To-Path $folder "Process" $false }
}

function Add-Folder-To-System-Path([string] $folder) {
  Add-Folder-To-Path "$folder" "Machine"
}

function Add-Folder-To-User-Path([string] $folder) {
  Add-Folder-To-Path "$folder" "User"
}

# Add-Folder-To-User-Path "C:\TEST-TEST-TEST" -IncludeProcess:$false

# Include File: [\Includes\Append-All-Text.ps1]
function Append-All-Text( [string]$file, [string]$text ) {
  Create-Directory-for-File $file
  $utf8=new-object System.Text.UTF8Encoding($false); 
  [System.IO.File]::AppendAllText($file, $text, $utf8);
}

function Write-All-Text( [string]$file, [string]$text ) {
  Create-Directory-for-File $file
  $utf8=new-object System.Text.UTF8Encoding($false); 
  [System.IO.File]::WriteAllText($file, $text, $utf8);
}

# Include File: [\Includes\Bootstrap-Aria2-If-Required.ps1]
# on windows 7 api.gitgub.com, etc are not available
function Bootstrap-Aria2-If-Required(
  [bool] $force = $false,
  [string] $deployMode = "copy-to", # copy-to | modify-path
  [string] $copyToFolder = $ENV:SystemRoot
) 
{
  if ((Get-Os-Platform) -ne "Windows") { return; }
  $major = [System.Environment]::OSVersion.Version.Major;
  $minor = [System.Environment]::OSVersion.Version.Minor;
  $canWebClient = ($major -gt 6) -or ($major -eq 6 -and $minor -ge 2);
  $okAria=$false; try { & aria2c.exe -h *| out-null; $okAria=$? } catch {}
  if (-not $force) { 
    if ($canWebClient -or $okAria) { return; }
  }
  $ariaExe = Get-Aria2c-Exe-FullPath-for-Windows
  if ($deployMode -eq "copy-to") {
    Copy-Item $ariaExe $copyToFolder -Force -EA Continue
    Write-Host "Provisioning aria2.exe for Windows $major.$minor. Copied to $copyToFolder"
  } elseif ($deployMode -eq "modify-path") {
    $dir=[System.IO.Path]::GetDirectoryName($ariaExe)
    $ENV:PATH="$($ENV:PATH);$($dir)"
    Write-Host "Provisioning aria2.exe for Windows $major.$minor. Added $dir to PATH"
  }
}

# Include File: [\Includes\Combine-Path.ps1]
function Combine-Path($start) { foreach($a in $args) { $start=[System.IO.Path]::Combine($start, $a); }; $start }

# Include File: [\Includes\Create-Directory.ps1]
function Create-Directory($dirName) { 
  if ($dirName) { 
    $err = $null;
    try { 
      $_ = [System.IO.Directory]::CreateDirectory($dirName); return; 
    } catch {
      $err = "Create-Directory failed for `"$dirName`". $($_.Exception.GetType().ToString()) $($_.Exception.Message)"
      Write-Host "Warning! $err";
      throw $err;
    }
  }
}

function Create-Directory-for-File($fileFullName) { 
  $dirName=[System.IO.Path]::GetDirectoryName($fileFullName)
  Create-Directory "$dirName";
}

# Include File: [\Includes\Demo-Test-of-Is-Vc-Runtime-Installed.ps1]
function Demo-Test-of-Is-Vc-Runtime-Installed() {
  foreach($arch in @("X86", "X64", "ARM64")) {
    Write-Host -NoNewline "$("{0,5}" -f $arch)|   "
    foreach($ver in $VcRuntimeLinksMetadata | % {$_.Ver}) {
      $isInstalled = Is-Vc-Runtime-Installed $ver $arch
      $color="Red"; if ($isInstalled) { $color="Green"; }
      Write-Host -NoNewline "v$($ver)=$("{0,-8}" -f $isInstalled) " -ForegroundColor $color
    }
    Write-Host ""
  }
}

# Include File: [\Includes\Demo-Test-of-Platform-Info.ps1]
function Demo-Test-of-Platform-Info() {
  echo "Memory $((Get-Memory-Info).Description)"
  echo "OS Platform: '$(Get-Os-Platform)'"
  if ("$(Get-Os-Platform)" -ne "Windows") { echo "UName System: '$(Get-Nix-Uname-Value "-s")'" }
  echo "CPU: '$(Get-Cpu-Name)'"
  Measure-Action "The Greeting Test Action" {echo "Hello World"}
  Measure-Action "The Fail Test Action" {$x=0; echo "Cant devide by zero $(42/$x)"; }
  Measure-Action "The CPU Name" {echo "CPU: '$(Get-Cpu-Name)'"}
}; # test

# Include File: [\Includes\Download-And-Install-Specific-VC-Runtime.ps1]
function Download-And-Install-Specific-VC-Runtime([string] $arch, [int] $version, [bool] $wait = $true) {
  $fullPath = Download-Specific-VC-Runtime $arch $version
  $commandLine=$VcRuntimeLinksMetadata | where { "$($_.Ver)" -eq "$version" } | % { $_.Args }
  # & "$fullPath" $commandLine.Split([char]32)
  # $isOk = $?;
  # return $isOk;
  $isOk = $false
  try { 
    Start-Process -FilePath "$fullPath" -ArgumentList ($commandLine.Split([char]32)) -Wait:$wait -NoNewWindow 
    $isOk = $true
  } catch {}
  return $isOk
}

# Include File: [\Includes\Download-File-FailFree-and-Cached.ps1]
function Download-File-FailFree-and-Cached([string] $fullName, [string[]] $urlList, [string] $algorithm="SHA512", [bool] $showFileSize = $false) {
  
  if ((Is-File-Not-Empty "$fullName") -and (Is-File-Not-Empty "$fullName.$algorithm")) { 
    $hashActual = Get-Smarty-FileHash "$fullName" $algorithm
    $hashExpected = Get-Content -Path "$fullName.$algorithm"
    if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
      Troubleshoot-Info "File already downloaded: '" -Highlight "$fullName" "'"
      return $true;
    }
  }
  $isOk = [bool] ((Download-File-FailFree $fullName $urlList -ShowFileSize $showFileSize) | Select -Last 1)
  if ($isOk) { 
    $hashActual = Get-Smarty-FileHash "$fullName" $algorithm
    echo "$hashActual" > "$($fullName).$algorithm"
    return $true; 
  }

  return $false;
}

# Include File: [\Includes\Download-File-Managed.ps1]
function Download-File-Managed([string] $url, [string]$outfile, [bool] $showFileSize = $false) {
  $dirName=[System.IO.Path]::GetDirectoryName($outfile)
  Create-Directory "$dirName";
  $okAria=$false; try { & aria2c.exe -h *| out-null; $okAria=$? } catch {}

  if ($showFileSize) {
    $urlFileLength = Query-Download-File-Size $url 6000
    if ($urlFileLength) {
      Write-Host "Download size is '$("{0:n0}" -f $urlFileLength)' bytes for url '$url'"
    }
  }

  if ($okAria) {
    Troubleshoot-Info "Starting download `"" -Highlight "$url" "`" using aria2c as `"" -Highlight "$outfile" "`""
    # "-k", "2M",
    $startAt = [System.Diagnostics.Stopwatch]::StartNew()
    & aria2c.exe @("--allow-overwrite=true", "--check-certificate=false", "-x", "16", "-j", "16", "-d", "$($dirName)", "-o", "$([System.IO.Path]::GetFileName($outfile))", "$url") | out-null;
    if ($?) { 
      <# Write-Host "aria2 rocks ($([System.IO.Path]::GetFileName($outfile)))"; #> 
      try { $length = (new-object System.IO.FileInfo($outfile)).Length; } catch {}; $milliSeconds = $startAt.ElapsedMilliseconds;
      $size=""; if ($length -gt 0) { $size=" ($($length.ToString("n0")) bytes)"; }
      $speed=""; if ($length -gt 0 -and $milliSeconds -gt 0) { $speed=" Speed is $(($length*1000/1024/$milliSeconds).ToString("n0")) Kb/s."; }
      $duration=""; if ($milliSeconds -gt 0) {$duration=" It took $(($milliSeconds/1000.).ToString("n1")) seconds."; }
      $downloadReport="Download of '$outfile'$($size) completed.$($duration)$($speed)";
      Write-Host $downloadReport;
      if ("$($ENV:SYSTEM_ARTIFACTSDIRECTORY)") { Append-All-Text (Combine-Path "$($ENV:SYSTEM_ARTIFACTSDIRECTORY)" "Download Speed Report.log") "$downloadReport$([Environment]::NewLine)"; }
      return $true; 
    }
  }
  elseif (([System.Environment]::OSVersion.Version.Major) -eq 5 -and (Get-Os-Platform) -eq "Windows" ) {
    Write-Host "Warning! Windows XP and Server 2003 requires aria2c.exe in the PATH for downloading." -ForegroundColor Red; 
  }
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
  if ($PSVersionTable.PSEdition -ne "Core") {
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true};
  }
  for ($i=1; $i -le 3; $i++) {
    Troubleshoot-Info "Starting download attempt #$i `"" -Highlight "$url" "`" using built-in http client as `"" -Highlight "$outfile" "`""
    $d=new-object System.Net.WebClient;
    # $d.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36");
    try {
      $startAt = [System.Diagnostics.Stopwatch]::StartNew()
      $d.DownloadFile("$url","$outfile"); 
      try { $length = (new-object System.IO.FileInfo($outfile)).Length; } catch {}; $milliSeconds = $startAt.ElapsedMilliseconds;
      $size=""; if ($length -gt 0) { $size=" ($($length.ToString("n0")) bytes)"; }
      $speed=""; if ($length -gt 0 -and $milliSeconds -gt 0) { $speed=" Speed is $(($length*1000/1024/$milliSeconds).ToString("n0")) Kb/s."; }
      $duration=""; if ($milliSeconds -gt 0) {$duration=" It took $(($milliSeconds/1000.).ToString("n1")) seconds."; }
      $downloadReport="Download of '$outfile'$($size) completed.$($duration)$($speed)";
      Write-Host $downloadReport;
      if ("$($ENV:SYSTEM_ARTIFACTSDIRECTORY)") { Append-All-Text (Combine-Path "$($ENV:SYSTEM_ARTIFACTSDIRECTORY)" "Download Speed Report.log") "$downloadReport$([Environment]::NewLine)"; }
      return $true
    } 
    catch { 
      $fileExists = (Test-Path $outfile)
      if ($fileExists) { Remove-Item $outfile -force }
      # Write-Host $_.Exception -ForegroundColor DarkRed; 
      if ($i -lt 3) {
        Write-Host "The download of the '$url' url failed.$([System.Environment]::NewLine)Retrying, $($i+1) of 3. $($_.Exception.Message)" -ForegroundColor Red;
        sleep 1;
      } else {
        Write-Host "Unable to download of the '$url' url.$([System.Environment]::NewLine)$($_.Exception.Message)" -ForegroundColor Red;
      }
    } 
  } 
  return $false
}

function Download-File-FailFree([string] $outFile, [string[]] $urlList, [bool] $showFileSize = $false) {
  foreach($url in $urlList) {
    $isOk = Download-File-Managed $url $outFile -showFileSize $showFileSize | Select -Last 1;
    if ($isOk) { return $true; }
  }
  return $fasle;
}


# Include File: [\Includes\Download-Specific-VC-Runtime.ps1]
function Download-Specific-VC-Runtime([string] $arch, [int] $version) {
  $algorithm="SHA512"
  $downloadFolder = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "VC-Runtime"
  $link = $VcRuntimeLinksMetadata | where {"$($_.Ver)" -eq "$version"} | % { $_."$($arch)Link"}
  if (-not "$link")  {
    Write-Host "Warning! Undefined link for Visual C++ Runtime v$($version) for $arch architecture" -ForegroundColor Red
  } else {
    $fullPath = Combine-Path $downloadFolder "$arch-v$version" "$([System.IO.Path]::GetFilename($link))"
    if (-not ($fullPath.ToLower().EndsWith(".exe"))) { $fullPath = "$($fullPath).exe"; }
    if ((Is-File-Not-Empty "$fullPath") -and (Is-File-Not-Empty "$fullPath.$algorithm")) { 
      $hashActual = Get-Smarty-FileHash "$fullPath" $algorithm
      $hashExpected = Get-Content -Path "$fullPath.$algorithm"
      if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
        Troubleshoot-Info "Already downloaded " -Highlight "$arch" - "v" -Highlight "$($version)" ": '$fullPath'"
        return $fullPath;
      }
    }
    $isOk = [bool] (Download-File-Managed $link $fullPath)
    if ($isOk) { 
      $hashActual = Get-Smarty-FileHash "$fullPath" $algorithm
      echo "$hashActual" > "$($fullPath).$algorithm"
      return $fullPath; 
    }
  }
  return "";
}

# Include File: [\Includes\Execute-Process-Smarty.ps1]
function Execute-Process-Smarty {
  Param(
    [string] $title, 
    [string] $launcher,
    [string[]] $arguments,
    [string] $workingDirectory = $null,
    [int] $waitTimeout = 3600,
    [switch] $Hidden = [switch] $false
  )
  $arguments = @($arguments | ? { "$_".Trim() -ne "" })
  Troubleshoot-Info "[$title] `"$launcher`" $arguments";
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()

  $ret = @{};
  $windowStyle = if ($Hidden) { "Hidden" } else { "Normal" };
  try { 
    if ($workingDirectory) { 
      $app = Start-Process "$launcher" -ArgumentList $arguments -WorkingDirectory $workingDirectory -PassThru -WindowStyle $windowStyle;
    } else {
      $app = Start-Process "$launcher" -ArgumentList $arguments -PassThru -WindowStyle $windowStyle;
    }
  } catch {
    $err = "$($_.Exception.GetType()): '$($_.Exception.Message)'";
    $ret = @{Error = "$title failed. $err"; };
  }
  
  $exitCode = $null;
  $okExitCode = $false;
  if (-not $ret.Error) {
    if ($app -and $app.Id) {
      $isExited = $app.WaitForExit(1000*$waitTimeout);
      if (-not $isExited) { 
        $ret = @{ Error = "$title timed out." };
      }
      if (-not $ret.Error) {
        sleep 0.01 # background tasks
        $exitCode = [int] $app.ExitCode;
        $isLegacy = ([System.Environment]::OSVersion.Version.Major) -eq 5;
        if ($isExited -and $isLegacy -and "$exitCode" -eq "") { $exitCode = 0; }
        $okExitCode = $exitCode -eq 0;
        # Write-Host "Exit Code = [$exitCode], okExitCode = [$okExitCode]"
        $ret = @{ExitCode = $exitCode};
        if (-not $okExitCode) {
          $err = "$title failed."; if ($app.ExitCode) { $err += " Exit code $($app.ExitCode)."; }
          $ret = @{ Error = $err };
        }
      }
    } else {
      if (-not "$($ret.Error)") { $ret["Error"] = "$title failed."; }
    }
  }

  $isOk = ((-not $ret.Error) -and $okExitCode);
  $status = IIF $isOk "Successfully completed" $ret.Error;
  
  if ($isOk) { 
    Write-Host "$title $status. It took $($startAt.ElapsedMilliseconds.ToString("n0")) ms";
  } else {
    Write-Host "$title $status. It took $($startAt.ElapsedMilliseconds.ToString("n0")) ms" -ForegroundColor DarkRed;
  }
  
  if (!$isOk -and ($app.Id)) {
    # TODO: Windows Only
    & taskkill.exe @("/t", "/f", "/pid", "$($app.Id)") | out-null;
  }
  return $ret;
}

# Include File: [\Includes\Extract-Archive-by-Default-Full-7z.ps1]
function Extract-Archive-by-Default-Full-7z([string] $fromArchive, [string] $toDirectory, $extractCommand = "x") {
  New-Item -Path "$($toDirectory)" -ItemType Directory -Force -EA SilentlyContinue | Out-Null
  $full7zExe = "$(Get-Full7z-Exe-FullPath-for-Windows)"
  try { $fileOnly = [System.IO.Path]::GetFileName($fromArchive); } catch { $fileOnly = $fromArchive; }
  $execResult = Execute-Process-Smarty "'$fileOnly' Extractor" $full7zExe @($extractCommand, "-y", "-o`"$toDirectory`"", "`"$fromArchive`"") -Hidden;
  $ret = $true;
  if ($execResult -and $execResult.Error) { $ret = $fasle; }
  return $ret;
}

# Include File: [\Includes\Format-Table-Smarty.ps1]
function Format-Table-Smarty
{ 
   $arr = (@($Input) | % { [PSCustomObject]$_} | Format-Table -AutoSize | Out-String -Width 2048).Split(@([char]13, [char]10)) | ? { "$_".Length -gt 0 };
   if (-not $arr) { return; }
   [string]::Join([Environment]::NewLine, $arr);
}

# Include File: [\Includes\Get-7z-Exe-FullPath-for-Windows.ps1]
function Get-Mini7z-Exe-FullPath-for-Windows() {
  $algorithm="SHA512"
  $ret = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "7z-mini-x86" "7zr.exe";
  $isOk = Download-File-FailFree-and-Cached $ret @("https://www.7-zip.org/a/7zr.exe", "https://sourceforge.net/projects/p7zz-repack/files/windows/7zr.exe/download")
  return (IIF $isOk $ret $null);
}




function Get-Mini7z-Exe-FullPath-for-Windows-Prev() {
  $algorithm="SHA512"

  $ret = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "7z-mini-x86" "7zr.exe";
  if ((Is-File-Not-Empty "$ret") -and (Is-File-Not-Empty "$ret.$algorithm")) {
    $hashActual = Get-Smarty-FileHash "$ret" $algorithm
    $hashExpected = Get-Content -Path "$ret.$algorithm"
    if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
      return $ret
    }
  } else {
    $isOk = Download-File-Managed "https://www.7-zip.org/a/7zr.exe" $ret
    if ($isOk) {
      $hashActual = Get-Smarty-FileHash "$ret" $algorithm
      echo "$hashActual" > "$($ret).$algorithm"
      return $ret;
    }
  }
    
  return $null
}



# Include File: [\Includes\Get-Aria2c-Exe-FullPath-for-Windows.ps1]
# arch: x86|x64|arm64|Xp
function Get-Aria2c-Exe-FullPath-for-Windows([string] $arch) {
  $linkXp="https://github.com/q3aql/aria2-static-builds/releases/download/v1.19.2/aria2-1.19.2-win-xp-build1.7z"
  $linkX86="https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-32bit-build1.zip"
  $linkX64="https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip"
  $linkArm64="https://github.com/minnyres/aria2-windows-arm64/releases/download/v1.37.0/aria2_1.37.0_arm64.zip" # Not Tested

  if (-not $arch) { 
    $currentArch = Get-CPU-Architecture-Suffix-for-Windows;
    if ($currentArch -eq "arm64") {
      if (Is-Intel-Emulation-Available 32) { $arch="x86"; }
      if (Is-Intel-Emulation-Available 64) { $arch="x64"; }
    } else {
      $arch=$currentArch;
    }
    if (([System.Environment]::OSVersion.Version.Major) -eq 5) {
      $arch="Xp";
    }
  }

  $link = Get-Variable -Name "Link$arch" -Scope Local -ValueOnly
  # $link="$($"Link$arch")"
  # return "Not Implemented";

  $archiveFileOnly="aria2c-$arch.$([System.IO.Path]::GetExtension($link).Trim([char]46))"
  $downloadFolder = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "aria2-setup"
  $archiveFullName = Combine-Path $downloadFolder $archiveFileOnly
  $plainFolder = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "aria2-$arch"
  $ret = Combine-Path "$plainFolder" "aria2c.exe"

  Troubleshoot-Info "Download Link for [$arch]   : $link"
  Troubleshoot-Info "archiveFullName for [$arch] : $archiveFullName"
  Troubleshoot-Info "plainFolder for [$arch]     : $plainFolder"

  $algorithm="SHA512"
  if ((Is-File-Not-Empty "$ret") -and (Is-File-Not-Empty "$ret.$algorithm")) {
    $hashActual = Get-Smarty-FileHash "$ret" $algorithm
    $hashExpected = Get-Content -Path "$ret.$algorithm"
    if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
      return $ret;
    }
  } else {
    $isDownloadOk = Download-File-Managed "$link" "$archiveFullName" | Select -Last 1
    if (-not $isDownloadOk) {
      Write-Host "Error downloading $link" -ForeGroundColor Red;
    }
    else {
      Troubleshoot-Info "Starting extract of '$archiveFullName'"
      $isExtractOk = ExtractArchiveByDefault7zFull "$archiveFullName" "$plainFolder" "e" | Select -Last 1
      Troubleshoot-Info "isExtractOk: $isExtractOk ($archiveFullName)"
      if (-not $isExtractOk) { 
        Write-Host "Error extracting $archiveFullName" -ForeGroundColor Red;
      } else {
        $hashActual = Get-Smarty-FileHash "$ret" $algorithm
        echo "$hashActual" > "$($ret).$algorithm"
        return $ret;
      }
    }
  }

  return $null;
}
<# 
  https://github.com/q3aql/aria2-static-builds/releases/download/v1.19.2/aria2-1.19.2-win-xp-build1.7z
  https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-32bit-build1.zip
  https://github.com/aria2/aria2/releases/download/release-1.36.0/aria2-1.36.0-win-64bit-build1.zip
#>

# Include File: [\Includes\Get-CPU-Architecture-Suffix-for-Windows.ps1]

# x86 (0), MIPS (1), Alpha (2), PowerPC (3), ARM (5), ia64 (6) Itanium-based systems, x64 (9), ARM64 (12)
function Get-CPU-Architecture-Suffix-for-Windows-Implementation() {
    $ret = Get-OS-Architecture-by-Registry
    if ($ret) { return $ret; }
    # on multiple sockets x64
    $proc = Select-WMI-Objects "Win32_Processor";
    $a = ($proc | Select -First 1).Architecture
    if ($a -eq 0)  { return "x86" };
    if ($a -eq 1)  { return "mips" };
    if ($a -eq 2)  { return "alpha" };
    if ($a -eq 3)  { return "powerpc" };
    if ($a -eq 5)  { return "arm" };
    if ($a -eq 6)  { return "ia64" };
    if ($a -eq 9)  { 
      # Is 32-bit system on 64-bit CPU?
      # OSArchitecture: "ARM 64-bit Processor", "32-bit", "64-bit"
      $os = Select-WMI-Objects "Win32_OperatingSystem";
      $osArchitecture = ($os | Select -First 1).OSArchitecture
      if ($osArchitecture -like "*32-bit*") { return "x86"; }
      return "x64" 
    };
    if ($a -eq 12) { return "arm64" };
    return "";
}

function Get-CPU-Architecture-Suffix-for-Windows() {
  if ($Global:CPUArchitectureSuffixforWindows -eq $null) { $Global:CPUArchitectureSuffixforWindows = Get-CPU-Architecture-Suffix-for-Windows-Implementation; }
  return $Global:CPUArchitectureSuffixforWindows
}

function Get-OS-Architecture-by-Registry {
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Environment"
    $valueName = "PROCESSOR_ARCHITECTURE"
    $rawArch = $null

    try {
        if (Test-Path $regPath) { $rawArch = (Get-ItemProperty -Path $regPath -Name $valueName -ErrorAction SilentlyContinue).$valueName }
    } catch { $rawArch = $null }

    switch ($rawArch) {
        "AMD64"   { return "x64" }
        "x86"     { return "x86" }
        "ARM64"   { return "arm64" }
        "ARM"     { return "arm" }
        "IA64"    { return "ia64" }
        "EM64T"   { return "x64" }
    }
}

# Include File: [\Includes\Get-Cpu-Name.ps1]
function Get-Cpu-Name-Implementation {
  $platform = Get-Os-Platform
  if ($platform -eq "Windows") {
    $proc = Select-WMI-Objects "Win32_Processor" | Select -First 1;
    $ret = Normalize-Cpu-Name "$($proc.Name)".Trim()
    return $ret
  }

  if ($platform -eq "MacOS") {
    $ret = (& sysctl "-n" "machdep.cpu.brand_string" | Out-String-And-TrimEnd)
    $ret = Normalize-Cpu-Name $ret
    return $ret
  }

  if ($platform -eq "Linux") {
    # TODO: Replace grep, awk, sed by NET
    $shell="cat /proc/cpuinfo | grep -E '^(model name|Hardware)' | awk -F':' 'NR==1 {print `$2}' | sed -e 's/^[[:space:]]*//'"
    $ret = "$(& bash -c "$shell" | Out-String-And-TrimEnd)"
    if (-not $ret) {
      $parts = @(
        (Get-Nix-Uname-Value "-m"), 
        "$(& bash -c "getconf LONG_BIT" | Out-String-And-TrimEnd) bit"
      );
      $ret = ($parts | where { "$_" }) -join ", "
    }
    $ret = Normalize-Cpu-Name $ret
    return $ret
  }

  $ret = $null;
  try { $ret = Get-Nix-Uname-Value "-m"; } catch {}
  $ret = Normalize-Cpu-Name $ret
  if ($ret) { return "$ret"; }

  return "Unknown"
}

function Normalize-Cpu-Name([string] $name) {
  $ret = "$name".Replace("`r", " ").Replace("`n", " ").Replace("`t", " ")
  while ($ret.IndexOf("  ") -ge 0) { $ret = "$ret".Replace("  ", " ") }
  return $ret;
}

function Get-Cpu-Name {
  [OutputType([string])] param([switch] $includeCoreCount)

  if (-not $Global:_Cpu_Name) { $Global:_Cpu_Name = "$(Get-Cpu-Name-Implementation)"; }
  $ret="$($Global:_Cpu_Name)"

  if ($includeCoreCount) { 
    if ("$ret".Length -gt 0) { $ret += ", " }
    $coreCount = [System.Environment]::ProcessorCount
    if ($coreCount -eq 1) { $ret += "1 core" } else { $ret += "$coreCount cores" }
  }

  return $ret;
}

# Get-Cpu-Name -includeCoreCount

# Include File: [\Includes\Get-Folder-Size.ps1]
function Get-Folder-Size([string] $folder) {
  if (Test-Path "$folder" -PathType Container) {
     $subFolderItems = Get-ChildItem "$folder" -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum
     return $subFolderItems.sum;
  }
}


# Include File: [\Includes\Get-Full7z-Exe-FullPath-for-Windows.ps1]
# arch: x86|x64|arm64
# version: 1604|2301
function Get-Full7z-Exe-FullPath-for-Windows([string] $arch, [string] $version = "2301") {
  if (-not $arch) { 
    $currentArch = Get-CPU-Architecture-Suffix-for-Windows;
    $arch = "x86"
    if ($currentArch -eq "arm64") { $arch="arm64"; }
    if ($currentArch -eq "x64") { $arch="x64"; }

    # arm64 below 2201 is not supported
    if ($arch -eq "arm64" -and (([int] $version) -lt 2201)) {
      if (Is-Intel-Emulation-Available 32) { $arch="x86"; }
      if (Is-Intel-Emulation-Available 64) { $arch="x64"; }
    }
    # v9.2 available as x86 only
    if ((([int] $version) -eq 920)) {
      $arch="x86"; 
    }
  }
  # $suffix="-$arch"; if ($suffix -eq "-x86") { $suffix=""; }
  # $link="https://www.7-zip.org/a/7z$($version)$($suffix).exe"
  $versionLinks = $Full7zLinksMetadata_onWindows | where { "$($_.Ver)" -eq "$version" } | Select -First 1
  $archLinks = $versionLinks."$($arch)Links"
  if (-not $archLinks) { 
     TroubleShoot-Info "ERROR. Unknown links for full 7z v$($version) arch $arch"
  }

  $archiveFileOnly="7z-$version-$arch.exe"
  $downloadFolder = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "7z-Full-Setup"
  $archiveFullName = Combine-Path $downloadFolder $archiveFileOnly
  $plainFolder = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "7z-Full-$arch-$version"
  $ret = Combine-Path "$plainFolder" "7z.exe"

  $algorithm="SHA512"
  if ((Is-File-Not-Empty "$ret") -and (Is-File-Not-Empty "$ret.$algorithm")) {
    $hashActual = Get-Smarty-FileHash "$ret" $algorithm
    $hashExpected = Get-Content -Path "$ret.$algorithm"
    if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
      return $ret;
    }
  } else {
    $isDownloadOk = Download-File-FailFree $archiveFullName $archLinks | Select -Last 1
    if (-not $isDownloadOk) {
      Write-Host "Error downloading any link of [$archLinks]" -ForeGroundColor Red;
      return $null;
    }

    $isExtractOk = ExtractArchiveBy7zMini "$archiveFullName" "$plainFolder" | Select -Last 1
    popd
    if (-not $isExtractOk) {
      Write-Host "Error extracting $archiveFullName" -ForeGroundColor Red;
    } else {
      $hashActual = Get-Smarty-FileHash "$ret" $algorithm
      echo "$hashActual" > "$($ret).$algorithm"
      return $ret;
    }
  }

  return $null;
}

function ExtractArchiveBy7zMini([string] $fromArchive, [string] $toDirectory) {
  New-Item -Path "$($toDirectory)" -ItemType Directory -Force -EA SilentlyContinue | Out-Null
  $mini7z = "$(Get-Mini7z-Exe-FullPath-for-Windows)"
  $commandLine=@("x", "-y", "-o`"$($toDirectory)`"", "`"$fromArchive`"")
  $singleCore7z=@(); $memInfo = Get-Memory-Info; $procCount = ([Environment]::ProcessorCount); if ($memInfo -and ($memInfo.Free) -and ($memInfo.Free -lt (640*$procCount))) { $singleCore7z=@("-mmt=1") }
  $commandLine += $singleCore7z
  Troubleshoot-Info "7z-mini: '$mini7z'; commandLine: '$commandLine' ('$fromArchive' ---> '$toDirectory')"
  # ok on pwsh and powersheel
  $prevPass = $PSNativeCommandArgumentPassing; $PSNativeCommandArgumentPassing = "Legacy"
  & "$mini7z" @commandLine >$null
  $PSNativeCommandArgumentPassing = $prevPass
  $isExtractOk = $?;
  return $isExtractOk;
}


function ExtractArchiveByDefault7zFull([string] $fromArchive, [string] $toDirectory, $extractCommand = "x") {
  New-Item -Path "$($toDirectory)" -ItemType Directory -Force -EA SilentlyContinue | Out-Null
  # pushd "$($toDirectory)"
  $full7zExe = "$(Get-Full7z-Exe-FullPath-for-Windows)"

  $commandLine = @("$extractCommand", "-y", "-o`"$($toDirectory)`"", "`"$fromArchive`"")
  $singleCore7z=@(); $memInfo = Get-Memory-Info; $procCount = ([Environment]::ProcessorCount); if ($memInfo -and ($memInfo.Free) -and ($memInfo.Free -lt (640*$procCount))) { $singleCore7z=@("-mmt=1") }
  $commandLine += $singleCore7z
  
  Troubleshoot-Info "`"$fromArchive`" $([char]8594) " -Highlight "`"$($toDirectory)`"" " by `"$full7zExe`""
  & "$full7zExe" $commandLine
  $isExtractOk = $?;
  return $isExtractOk;
}


<# 
  https://www.7-zip.org/a/7z2301-arm64.exe
  https://www.7-zip.org/a/7z2301-x64.exe
  https://www.7-zip.org/a/7z2301.exe

  https://www.7-zip.org/a/7z2201-arm64.exe
  https://www.7-zip.org/a/7z2201-x64.exe
  https://www.7-zip.org/a/7z2201.exe

  https://www.7-zip.org/a/7z1900-x64.exe
  https://www.7-zip.org/a/7z1900.exe
  
  https://www.7-zip.org/a/7z1604-x64.exe
  https://www.7-zip.org/a/7z1604.exe
  
  https://www.7-zip.org/a/7z920.exe
  https://www.7-zip.org/a/7z920-arm.exe

  https://www.7-zip.org/a/7zr.exe
#>

# Include File: [\Includes\Get-Github-Latest-Release.ps1]
function Get-Github-Latest-Release([string] $owner, [string] $repo) {
  $queryLatest="https://api.github.com/repos/$owner/$repo/releases/latest" # "tag_name": "v3.227.2",
  $qyeryResultFullName = Combine-Path (Get-PS1-Repo-Downloads-Folder) "Queries" "Github Latest Release" "$(([System.Guid]::NewGuid()).ToString("N")).json"
  $isOk = Download-File-FailFree $qyeryResultFullName @($queryLatest)
  if (-not $isOk) {
    Write-Host "Error query latest version for '$owner/$repo'" -ForegroundColor Red
  }
  $jsonResult = Get-Content $qyeryResultFullName | ConvertFrom-Json
  $ret = $jsonResult.tag_name;
  if (-not $ret) {
    Write-Host "Maflormed query latest version for '$owner/$repo'. Missing property 'tag_name'" -ForegroundColor Red
  } else {
    Remove-Item $qyeryResultFullName -Force
  }
  return $ret;
}


# Include File: [\Includes\Get-Github-Releases.ps1]
function Get-Github-Releases([string] $owner, [string] $repo) {
  $url="https://api.github.com/repos/$owner/$repo/releases?per_page=128"
  # https://api.github.com/repos/microsoft/azure-pipelines-agent/releases?per_page=128 
  $qyeryResultFullName = Combine-Path (Get-PS1-Repo-Downloads-Folder) "Queries" "Github Releases" "$(([System.Guid]::NewGuid()).ToString("N")).json"
  $isOk = Download-File-FailFree $qyeryResultFullName @($url)
  if (-not $isOk) {
    Write-Host "Error query release list for '$owner/$repo'" -ForegroundColor Red
  }
  $jsonResult = Get-Content $qyeryResultFullName | ConvertFrom-Json

<#
    "tag_name":"v3.230.0",
    "target_commitish":"6ee2a6be8f5e0cccac6079e4fb42b5fe9f8de04e",
    "name":"v3.230.0",
    "draft":false,
    "prerelease":true,
    "created_at":"2023-11-03T02:33:23Z",
    "published_at":"2023-11-07T11:17:01Z",
    "tarball_url":"https://api.github.com/repos/microsoft/azure-pipelines-agent/tarball/v3.230.0",
    "zipball_url":"https://api.github.com/repos/microsoft/azure-pipelines-agent/zipball/v3.230.0",
    "body":"## Features\r\n - Add `AllowWorkDirectoryRepositories` knob (#4423)\r\n - Update process handler (#4425)\r\n - Check task deprecation (#4458)\r\n - Enable Domains for Pipeline Artifact (#4460)\r\n - dedupStoreHttpClient honors redirect timeout from client settings and update ADO lib to 0.5.227-262a3469 (#4504)\r\n\r\n## Bugs\r\n - Detect the OS and switch node runner if not supported for Node20 (#4470)\r\n - Revert \"Enable Domains for Pipeline Artifact\" (#4477)\r\n - Add capability to publish/download pipeline artifact in a different domain. (#4482)\r\n - Mount Workspace (#4483)\r\n\r\n## Misc\r\n\r\n\r\n\r\n## Agent Downloads\r\n\r\n|                | Package | SHA-256 |\r\n| -------------- | ------- | ------- |\r\n| Windows x64    | [vsts-agent-win-x64-3.230.0.zip](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-win-x64-3.230.0.zip) | cbb21ea2ec0b64663c35d13f204e215cfe41cf2e3c8efff7c228fdab344d00de |\r\n| Windows x86    | [vsts-agent-win-x86-3.230.0.zip](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-win-x86-3.230.0.zip) | 7182a054b1f58c5d104f7b581fe00765c32f1bd544dc2bcc423d0159929f4692 |\r\n| macOS x64      | [vsts-agent-osx-x64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-osx-x64-3.230.0.tar.gz) | 988234fe3a1bbc6f79c3f6d94d70ea1908f2395ce6b685118d1dae983f03479e |\r\n| macOS ARM64    | [vsts-agent-osx-arm64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-osx-arm64-3.230.0.tar.gz) | 82f670482ffb45de2e533687c5eefa9506cbe0686edaa6a3c02487887729101c |\r\n| Linux x64      | [vsts-agent-linux-x64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-linux-x64-3.230.0.tar.gz) | bc222ec99ff675c1035efd0a086cea02adb5847ae7df8ee36e89db14aee8673d |\r\n| Linux ARM      | [vsts-agent-linux-arm-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-linux-arm-3.230.0.tar.gz) | f399e0ddceb10f09cd768c29e31fa51eb05c51c092e2392282e63795729f6a39 |\r\n| Linux ARM64    | [vsts-agent-linux-arm64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-linux-arm64-3.230.0.tar.gz) | 3c6fa98e26c7d8b19e8a35ca5b45a32122088a3bc12e817e7ccdead303893789 |\r\n| Linux musl x64 | [vsts-agent-linux-musl-x64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/vsts-agent-linux-musl-x64-3.230.0.tar.gz) | 3461bef5756e452b920779b1f163cd194fa1971267acd582c2ad4870b1f611c2 |\r\n\r\nAfter Download:\r\n\r\n## Windows x64\r\n\r\n``` bash\r\nC:\\> mkdir myagent && cd myagent\r\nC:\\myagent> Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory(\"$HOME\\Downloads\\vsts-agent-win-x64-3.230.0.zip\", \"$PWD\")\r\n```\r\n\r\n## Windows x86\r\n\r\n``` bash\r\nC:\\> mkdir myagent && cd myagent\r\nC:\\myagent> Add-Type -AssemblyName System.IO.Compression.FileSystem ; [System.IO.Compression.ZipFile]::ExtractToDirectory(\"$HOME\\Downloads\\vsts-agent-win-x86-3.230.0.zip\", \"$PWD\")\r\n```\r\n\r\n## macOS x64\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-osx-x64-3.230.0.tar.gz\r\n```\r\n\r\n## macOS ARM64\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-osx-arm64-3.230.0.tar.gz\r\n```\r\n\r\n## Linux x64\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-linux-x64-3.230.0.tar.gz\r\n```\r\n\r\n## Linux ARM\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-linux-arm-3.230.0.tar.gz\r\n```\r\n\r\n## Linux ARM64\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-linux-arm64-3.230.0.tar.gz\r\n```\r\n\r\n## Alpine x64\r\n\r\n``` bash\r\n~/$ mkdir myagent && cd myagent\r\n~/myagent$ tar xzf ~/Downloads/vsts-agent-linux-musl-x64-3.230.0.tar.gz\r\n```\r\n\r\n***Note:*** Node 6 does not exist for Alpine.\r\n\r\n## Alternate Agent Downloads\r\n\r\nAlternate packages below do not include Node 6 and are only suitable for users who do not use Node 6 dependent tasks. \r\nSee [notes](docs/node6.md) on Node version support for more details.\r\n\r\n|             | Package | SHA-256 |\r\n| ----------- | ------- | ------- |\r\n| Windows x64 | [pipelines-agent-win-x64-3.230.0.zip](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-win-x64-3.230.0.zip) | f5bbae6dad8c39ea809db9b04abbcf3add37962d67ef9c67245a09fb536d38ca |\r\n| Windows x86 | [pipelines-agent-win-x86-3.230.0.zip](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-win-x86-3.230.0.zip) | 00d5f1776767ead3e70036f63cdbd38a007b7d971c287a4d24d7346f4d3715a6 |\r\n| macOS x64   | [pipelines-agent-osx-x64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-osx-x64-3.230.0.tar.gz) | e6e602c6664414b8a9b27a2df73511156d32a6bc76f8b4bb69aa960767aa9684 |\r\n| macOS ARM64 | [pipelines-agent-osx-arm64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-osx-x64-3.230.0.tar.gz) | a00182572b1be649fe6836336bde3d4d3f79ceee42822fe44707afa9950b2232 |\r\n| Linux x64   | [pipelines-agent-linux-x64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-linux-x64-3.230.0.tar.gz) | d46581abbf0eb5c3aef534825b51f92ade9d86a5b089b9489e84387070366d1b |\r\n| Linux ARM   | [pipelines-agent-linux-arm-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-linux-arm-3.230.0.tar.gz) | 1dc871562bd6266567f7accced8d4a9ec3b4b85139891cf563a8fa305968ad40 |\r\n| Linux ARM64 | [pipelines-agent-linux-arm64-3.230.0.tar.gz](https://vstsagentpackage.azureedge.net/agent/3.230.0/pipelines-agent-linux-arm64-3.230.0.tar.gz) | 4ce243af0a09d5be2a6194b94d98c11fc323607b083ec5dcf3893bf67abb2dda |\r\n"
#>
  $ret=@()
  foreach($release in $jsonResult) { 
    $ret += New-Object PSObject -Property @{
        Tag          = $release.tag_name
        Commit       = $release.target_commitish
        Name         = $release.name
        IsDraft      = [bool] $release.draft
        IsPrerelease = [bool] $release.prerelease
        CreatedAt    = $release.created_at
        PublishedAt  = $release.published_at
        TarballUrl   = $release.tarball_url
        ZipballUrl   = $release.zipball_url
    }
  }
  
  if (-not ($ret | Select -First 1)) {
    Write-Host "Empty release list for '$owner/$repo'" -ForegroundColor Red
  } else {
    Remove-Item $qyeryResultFullName -Force
  }
  return $ret | where { -not ($_.IsDraft) };
}

# Include File: [\Includes\Get-Installed-VC-Runtimes.ps1]
function Get-Installed-VC-Runtimes() {
  $softwareFilter = { $_.name -like "*Visual C++*" -and $_.vendor -like "*Microsoft*" -and ($_.name -like "*Runtime*" -or $_.name -like "*Redistributable*")}
  return Get-Speedy-Software-Product-List | where $softwareFilter
}

# Include File: [\Includes\Get-Memory-Info.ps1]
function Get-Memory-Info {
  [OutputType([object])] param()

  $platform = Get-Os-Platform
  if ($platform -eq "Windows") {
    $os = Select-WMI-Objects "Win32_OperatingSystem";
    $mem=($os | Where { $_.FreePhysicalMemory } | Select FreePhysicalMemory,TotalVisibleMemorySize -First 1);
    $total=[int] ($mem.TotalVisibleMemorySize / 1024);
    $free=[int] ($mem.FreePhysicalMemory / 1024);
    
    $wmiSwap = @(Select-WMI-Objects "Win32_PageFileUsage")
    $swapCurrent   = $wmiSwap | Measure-Object -property CurrentUsage -sum      | % { $_.Sum } | Select -First 1
    $swapPeak      = $wmiSwap | Measure-Object -property PeakUsage -sum         | % { $_.Sum } | Select -First 1
    $swapAllocated = $wmiSwap | Measure-Object -property AllocatedBaseSize -sum | % { $_.Sum } | Select -First 1
    if ($swapAllocated) {
      $customDescription = ". Swap Usage: $(FormatNullableNumeric $swapCurrent) (peak $(FormatNullableNumeric $swapPeak)) of $(FormatNullableNumeric $swapAllocated) Mb"
    }
  }

  if ($platform -eq "MacOS") {
    $total=[long] (& sysctl -n hw.memsize | Out-String).TrimEnd(@([char]13,[char]10))
    $total=[int] ($total/1024/1024)
    $free=[long] (& vm_stat | grep "Pages free" | awk -v OFMT="%.0f" '{print (4 * $NF / 1024)}' | Out-String-And-TrimEnd)
    $inactive=[long] (& vm_stat | grep "Pages inactive" | awk -v OFMT="%.0f" '{print (4 * $NF / 1024)}' | Out-String-And-TrimEnd)
    $free = [int]$free + [int]$inactive;
    # Write-Host "Mem Total: $total, Free: $free"
  }

  if ($platform -eq "Linux") {
    # total: $2, $used: $3, shared: $5. free = total-(used+shared)
    $total=[int] (& free -m | awk 'NR==2 {print $2}' | Out-String-And-TrimEnd)
    $used =[int] (& free -m | awk 'NR==2 {print $3 + $5}' | Out-String-And-TrimEnd)
    $free=$total-$used

    $swapAllocated = [int] (& free -m | awk '$1 ~ /^[S|s]wap/ {print $2}' | Out-String-And-TrimEnd)
    $swapCurrent   = [int] (& free -m | awk '$1 ~ /^[S|s]wap/ {print $3}' | Out-String-And-TrimEnd)
    if ($swapAllocated) {
      $customDescription = ". Swap Usage: $(FormatNullableNumeric $swapCurrent) of $(FormatNullableNumeric $swapAllocated) Mb"
    }
  }

  if ($total) {
    $info="Total RAM: $($total.ToString("n0")) MB. Free: $($free.ToString("n0")) MB ($([Math]::Round($free * 100 / $total, 1))%)$customDescription";
    $ret = @{
        Total=$total;
        Free=$free;
        Description=$info;
    }
    if ($swapAllocated) {
      $ret["SwapAllocated"] = $swapAllocated;
      $ret["SwapCurrent"]   = $swapCurrent;
    }
    return $ret;
  }

  <#
     .OUTPUTS
     Object with 3 properties: [int] Total, [int] Free, [string] Description
  #>

}

function FormatNullableNumeric($n, $fractionalDigits = 0) {
  try { $num = [int] $n } catch { $num = 0 }
  return $num.ToString("n$fractionalDigits");
}

# Include File: [\Includes\Get-Nix-Uname-Value.ps1]

# Linux/Darwin/FreeBSD, Error on Windows
function Get-Nix-Uname-Value {
  param([string] $arg)
  return (& uname "$arg" | Out-String-And-TrimEnd)
}

# Include File: [\Includes\Get-Os-Platform.ps1]
# Returns Linux/Windows/Mac/FreeBSD
function Get-Os-Platform {
  [OutputType([string])] param()

  $platform = [System.Environment]::OSVersion.Platform;
  if ($platform -like "Win*") { return "Windows"; }

  $nixUnameSystem = Get-Nix-Uname-Value "-s"
  if ($nixUnameSystem -eq "Linux") { return "Linux"; }
  if ($nixUnameSystem -eq "Darwin") { return "MacOS"; }
  if ($nixUnameSystem -eq "FreeBSD") { return "FreeBSD"; }

  return "Unknown"

  <#
     .OUTPUTS
     One of the following values: "Linux", "Windows", "MacOS", "FreeBSD", "Unknown"
  #>
}

# Include File: [\Includes\Get-PS1-Repo-Downloads-Folder.ps1]
function Get-PS1-Repo-Downloads-Folder() {
  return (GetPersistentTempFolder "PS1_REPO_DOWNLOAD_FOLDER" "PS1 Repo Downloads");
}

function GetPersistentTempFolder([string] $envPrefix, [string] $pathSuffix) {
  
  foreach($pair in (gci env:$($envPrefix)* | sort-object name)) {
      $explicitRet = "$($pair.Value)";
      if ($explicitRet) {
        New-Item -Path $explicitRet -ItemType Directory -Force -EA SilentlyContinue | Out-null
        $isExplicit = Test-Path -Path $explicitRet -PathType Container -EA SilentlyContinue;
        if ($isExplicit) { return "$explicitRet"; }
      }
  }

  If (Get-Os-Platform -eq "Windows") { $ret = "$($ENV:TEMP)" } else { $ret = "$($ENV:TMPDIR)"; if (-not $ret) { $ret = "/tmp" }};
  $is1 = Test-Path -Path $ret -PathType Container -EA SilentlyContinue
  if (-not $is1) {
    try { New-Item -Path $ret -ItemType Directory -Force -EA SilentlyContinue | Out-null } catch { }
    $is2 = Test-Path -Path $ret -PathType Container -EA SilentlyContinue
    if (-not $is2) { 
      $ret=""
    }
  }

  if (-not $ret) {
    $ret="$($ENV:LOCALAPPDATA)";
    if ("$ret" -eq "") { $ret="$($ENV:APPDATA)"; }; 
    if ("$ret" -eq "") { $ret="$($ENV:HOME)/.cache"; }; 
  }
  
  $separator="$([System.IO.Path]::DirectorySeparatorChar)"
  if (-not ($ret -like "*\Temp" -or $ret -like "*/.cache")) { $ret += "$($separator)Temp"; }
  $ret += "$($separator)$pathSuffix";
  return $ret;
}


# Include File: [\Includes\Get-Random-Free-Port.ps1]
function Get-Random-Free-Port() {
  $tcpListener = New-Object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Loopback <# ::Any? #>, 0)
  $tcpListener.Start()
  $port = ([System.Net.IPEndPoint] $tcpListener.LocalEndpoint).Port;
  $tcpListener.Stop()
  return $port;
}

# Get-Random-Free-Port

# Include File: [\Includes\Get-Smarty-FileHash.ps1]
# $algorithm: MD5|SHA1|SHA256|SHA384|SHA512
function Get-Smarty-FileHash([string] $fileName, [string] $algorithm = "MD5") {
  $fileExists = (Test-Path $fileName -PathType Leaf)
  if (-not $fileExists) { return $null; }
  $hashAlg = [System.Security.Cryptography.HashAlgorithm]::Create($algorithm)
  try {
    $fileStream = new-object System.IO.FileStream($fileName, "Open", "Read", "ReadWrite", 32768)
    $bytes = $hashAlg.ComputeHash($fileStream);
    # $ret="";
    # foreach($b in $bytes) { $ret = "$($ret)$($b.ToString("X2"))"; }
    $ret = "$($bytes | % { $_.ToString("X2") })".Replace(" ","")
    return $ret;
  }
  finally {
    if ($fileStream) { $fileStream.Dispose(); }
  }
  return $null;
}


# Include File: [\Includes\Get-Smarty-FolderHash.ps1]
# Get-Smarty-FileHash([string] $fileName, [string] $algorithm = "MD5") {
function Get-Smarty-FolderHash([string] $rootFolder, [string] $algorithm = "MD5", [bool] $includeDates = $false) {
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  $folderExists = (Test-Path $rootFolder -PathType Container)
  if (-not $folderExists) { return $null; }
  $colItems = Get-ChildItem $rootFolder -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Sort-Object -Property FullName
  $summary=New-Object System.Collections.ArrayList;
  $filesCount = 0;
  foreach ($i in $colItems)
  {
      $filesCount++;
      $fileHash = Get-Smarty-FileHash $i.FullName $algorithm;
      if ($includeDates) { 
        foreach($date in $i.CreationTimeUtc, $i.LastWriteTimeUtc) {
          $fileHash += $date.ToString("s")
        }
      }
      $_=$summary.Add($fileHash)
  }
  $utf8 = new-object System.Text.UTF8Encoding($false)
  $summaryBytes = $utf8.GetBytes("$summary")
  $hashAlg = [System.Security.Cryptography.HashAlgorithm]::Create($algorithm)
  $retBytes = $hashAlg.ComputeHash($summaryBytes);
  $ret = "$($retBytes | % { $_.ToString("X2") })".Replace(" ","")
  TroubleShoot-Info "Hash $algorithm for folder " -Highlight $rootFolder " (" -Highlight $filesCount " files) took " -Highlight "$($startAt.ElapsedMilliseconds.ToString("n0"))" " ms"
  return $ret;
}

# Include File: [\Includes\Get-Speedy-Software-Product-List.ps1]
function Get-Speedy-Software-Product-List() {
  $ret=@();
  $origins=@(
    @{ Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="" },
    @{ Path="HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="" },
    @{ Path="HKCU:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="X86" },
    @{ Path="HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="X86" },
    @{ Path="HKCU:\Software\WowAA32Node\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="ARM32" },
    @{ Path="HKLM:\Software\WowAA32Node\Microsoft\Windows\CurrentVersion\Uninstall"; Origin="ARM32" }
  );
  foreach($origin in $origins) {
    $keys = Get-ChildItem $origin.Path -EA SilentlyContinue
    if ($keys) {
      foreach($key in $keys) {
        # Write-Host "$($key.Name): $key"
        $ret += New-Object PSObject -Property @{
            Name    = "$($key.GetValue('DisplayName'))".Trim()
            Vendor  = "$($key.GetValue('Publisher'))".Trim()
            Version = "$($key.GetValue('DisplayVersion'))".Trim()
            IdentifyingNumber = [System.IO.Path]::GetFileName("$($key.Name)".Trim())
            Origin  = $origin.Origin
        }
      }
    }
  }
  return $ret | where { "$($_.Name)" -ne "" -and "$($_.Vendor)" -ne "" } | Sort-Object Vendor, Name, Version, Origin -Unique
}

# Get-Speedy-Software-Product-List | ft
# $localDbList = Get-Speedy-Software-Product-List | ? { $_.Name -match "LocalDB" -and $_.Vendor -match "Microsoft" }

# Include File: [\Includes\Get-System-Drive.ps1]
function Get-System-Drive() { $ret = "$($Env:SystemDrive)"; $c = "$([System.IO.Path]::DirectorySeparatorChar)"; if (-not ($ret.EndsWith($c))) { $ret += $c; }; return $ret; }
  

# Include File: [\Includes\Get-Windows-Power-Plans.ps1]
function Get-Windows-Power-Plans() {
  if ((Get-Os-Platform) -ne "Windows") { return @(); }
  $rawOutput = (& powercfg.exe "-l") | Out-String
  # Write-Host $rawOutput
  $lines = "$rawOutput".Split([char]13,[char]10) | ? { "$_" -match ":" } | % { @(@("$_".Split(":")) | Select -Skip 1) -join " " } | % { "$_".Trim() }
  foreach($line in $lines) {
    $guid = "$line".Split(" ") | % { "$_".Trim() } | ? { "$_".Length -gt 0 } | Select -First 1
    $pSpace = "$line".IndexOf(" ");
    if ($pSpace -gt 1) {
      $name = "$line".SubString($pSpace).Trim()
      $isActive = "$line".EndsWith("*")
      if ($isActive) { $name = "$name".TrimEnd("*"); }
      $name = "$name".Trim().TrimStart("(").TrimEnd(")")
      [PsCustomObject] @{ "Id" = $guid; Name = $name; IsActive = $isActive };
    }
  }
}

function Get-Windows-Active-Power-Plan() {
  Get-Windows-Power-Plans | ? { $_.IsActive } | Select -First 1
}

function Get-Windows-Active-Power-Plan-Name() {
  (Get-Windows-Active-Power-Plan).Name
}

function Set-Windows-Power-Plan-by-Name([string] $newPowerPlanName) {
  $allPlans = @(Get-Windows-Power-Plans)
  $newPlan = $allPlans | ? { $_.Name -eq $newPowerPlanName } | Select -First 1
  if ($newPlan) {
    & powercfg.exe @("/s", "$($newPlan.Id)") | Out-Host
  } else {
    Write-Host "Warning! Unable to set power plan '$newPowerPlanName'. Not Found." -ForeGroundColor DarkRed
  }
}

# Get-Windows-Active-Power-Plan-Name; 
# Get-Windows-Active-Power-Plan
# Get-Windows-Power-Plans | ft *

# Set-Windows-Power-Plan-by-Name "High Performance"
# Set-Windows-Power-Plan-by-Name "ZXC PPlan"
# Set-Windows-Power-Plan-by-Name "Balanced"




# Include File: [\Includes\Has-Cmd.ps1]
function Has-Cmd {
  param([string] $arg)
  if ("$arg" -eq "") { return $false; }
  [bool] (Get-Command "$arg" -ErrorAction SilentlyContinue)
}

function Select-WMI-Objects([string] $class) {
  if (Has-Cmd "Get-CIMInstance")     { $ret = Get-CIMInstance $class; } 
  elseif (Has-Cmd "Get-WmiObject")   { $ret = Get-WmiObject   $class; } 
  if (-not $ret) { Write-Host "Warning ! Missing neither Get-CIMInstance nor Get-WmiObject" -ForegroundColor DarkRed; }
  return $ret;
}
# Include File: [\Includes\IIf.ps1]
# function IIf([bool] $flag, $trueResult, $falseResult) {
#   if ($flag) { return $trueResult; } else { return $falseResult; }
# }

# https://stackoverflow.com/a/54702474
Function IIf($If, $Then, $Else) {
  If ($If) { 
    If ($Then -is [scriptblock]) { ForEach-Object -InputObject $If -Process $Then } 
    Else { $Then } 
  } Else {
    If ($Else -is [scriptblock]) { ForEach-Object -InputObject $If -Process $Else }
    Else { $Else }
  }
}

# Include File: [\Includes\Is-BuildServer.ps1]
function Is-BuildServer() {
  return "$(Try-BuildServerType)" -ne "";
}

function Try-BuildServerType() {
  $simpleKeys = @(
     "APPVEYOR",
     "bamboo_planKey",
     "BITBUCKET_COMMIT",
     "BITRISE_IO",
     "BUDDY_WORKSPACE_ID",
     "BUILDKITE",
     "CIRCLECI",
     "CIRRUS_CI",
     "CODEBUILD_BUILD_ARN",
     "DRONE",
     "DSARI",
     "GITHUB_ACTIONS",
     "GITLAB_CI",
     "GO_PIPELINE_LABEL",
     "HUDSON_URL",
     "MAGNUM",
     "SAILCI",
     "SEMAPHORE",
     "SHIPPABLE",
     "TDDIUM",
     "STRIDER",
     "TDDIUM",
     "TEAMCITY_VERSION",
     "TF_BUILD",
     "TRAVIS");
  
  foreach($varName in $simpleKeys) {
    $val=[Environment]::GetEnvironmentVariable($varName);
    if ("$val" -ne "" -and $val -ne "False") { return $varName; }
  }

  return $null;
}
# Write-Host "Try-BuildServerType: [$(Try-BuildServerType)], Is-BuildServer: $(Is-BuildServer)"

# Include File: [\Includes\Is-File-Not-Empty.ps1]
function Is-File-Not-Empty([string] $fileName) {
  try { $fi = new-object System.IO.FileInfo($fileName); return $fi.Length -gt 0; } catch {}; return $fasle; 
}


# Include File: [\Includes\Is-Intel-Emulation-Available.ps1]
# On non-arm returns $false
function Is-Intel-Emulation-Available([int] $bitCount <# 32|64 #> = 64) {
  $systemRoot="$($ENV:SystemRoot)"
  $fileOnly = if ($bitCount -eq 64) { "xtajit64.dll" } else { "xtajit.dll" }; 
  $fullName=Combine-Path $systemRoot "System32" $fileOnly;
  return [bool] (Is-File-Not-Empty $fullName)
}



# Include File: [\Includes\Is-SshClient.ps1]
function Is-SshClient() {
  $simpleKeys = @(
     "SSH_CLIENT",
     "SSH_CONNECTION",
     "SSH_TTY"
     );

  foreach($varName in $simpleKeys) {
    $val=[Environment]::GetEnvironmentVariable($varName);
    if ("$val" -ne "" -and $val -ne "False") { return $true; }
  }

  return $null;
}

# Include File: [\Includes\Is-Vc-Runtime-Installed.ps1]
function Is-Vc-Runtime-Installed([int] $major, [string] $arch) {
  $vcList = Get-Installed-VC-Runtimes
  # Does not support x86 v8 (2005) on x86 Windows
  $found = $vcList | where { ($_.Version.StartsWith($major.ToString("0")+".")) -and ($_.Name.ToLower().IndexOf($arch.ToLower()) -ge 0 -or $_.Origin -eq $arch) }
  # return $found.Length -gt 0; v6+
  # return @($found).Length -gt 0; v5+
  return "$($found)" -ne ""; # v2+
}

# Include File: [\Includes\Lazy-Aggregator.ps1]
function Update-Lazy-Aggregator([string] $storageFileName, [string] $keyName, [HashTable] $properties) {
    # TODO:
}
# Include File: [\Includes\Measure-Action.ps1]
function Measure-Action {
  Param(
    [string] $Title,
    [ScriptBlock] $Action
  )

  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  try { Invoke-Command -ScriptBlock $action; $err=$null; } catch { $err=$_.Exception; }
  $msec = $startAt.ElapsedMilliseconds;
  $ea = $ErrorActionPreference
  $ErrorActionPreference = "SilentlyContinue"
  if (-not $err) {
    Write-Host "Success. " -ForeGroundColor Green -NoNewLine;
    Write-Host "'$title'"  -ForeGroundColor Cyan -NoNewLine;
    Write-Host " took $($msec.ToString("n0")) ms"
  } else {
    # Write-Host $err.GetType()
    Write-Host "Fail. $($err.Message) " -ForeGroundColor Red -NoNewLine;
    Write-Host "'$title'"  -ForeGroundColor Magenta -NoNewLine;
    Write-Host " took $($msec.ToString("n0")) ms"
  }
  $ErrorActionPreference=$ea
}

# Measure-Action "Test OK" { }; Measure-Action "Test Error" { $x = 5 / 0 }

# Include File: [\Includes\Out-String-And-TrimEnd.ps1]
Function Out-String-And-TrimEnd
{
  Param ([int] $Skip=0, [int] $Take=2000000000)
  Begin { $n=0; $list = New-Object System.Collections.Generic.List[System.Object]}
  Process { $n++; if (-not ($n -le $Skip -or $n -gt ($Skip+$Take))) { $list.Add("$_"); } }
  End { return [string]::join([System.Environment]::NewLine, $list.ToArray()).TrimEnd(@([char]13,[char]10)) }
}

# Include File: [\Includes\Query-Download-File-Size.ps1]
function Query-Download-File-Size([string] $url, [int] $waitTimeout = 5000) {
  if ((Get-Os-Platform) -eq "Windows") { $curlExe = "curl.exe" } Else { $curlExe = "curl" }

  $okCurl=$false; try { & "$curlExe" "-h" *| out-null; $okCurl=$? } catch {}
  if (-not $okCurl) { return }

  $tempFile = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "Temp" "$([System.Guid]::newGuid().ToString("N"))"
  $__ = Create-Directory-for-File $tempFile
  # write-Host "tempFile = $tempFile"
  $arguments = @("-I", "-k", "-f", "-S", "-L", "`"$url`"")
  try {
      # -WorkingDirectory $workingDirectory
      $app = Start-Process "$curlExe" -ArgumentList $arguments -PassThru -WindowStyle "Hidden" -RedirectStandardOutput "$($tempFile).output" -RedirectStandardError "$($tempFile).error"
      # Write-Host "app.Id: $($app.Id)"
      $isExited = [bool] ($app.WaitForExit($waitTimeout));
      $appExitCode = $app.ExitCode
      # Write-Host "appExitCode: $appExitCode"
      # Write-Host "isExited = $isExited"
      if (-not $isExited) {
        $app.Kill()
        return;
      }

      $isOutputFileExists = [System.IO.File]::Exists("$($tempFile).output")
      # Write-Host "isOutputFileExists = $isOutputFileExists"


      if (-not $isOutputFileExists) { return } 
      $content = Get-Content -Path "$($tempFile).output" -Raw
      $lines = $content.Split(@([char] 13, [char] 10))
      [System.Array]::Reverse($lines)
      foreach($line in $lines) {
        if ($line.ToLower().StartsWith("content-length:")) {
          $rawLength = $line.Substring(16)
          [long]$length = 0
          $isNumber = [Int64]::TryParse($rawLength, [ref]$length)
          if ($isNumber -and ($length -gt 0)) { return $length }
        }
      }
  }
  finally {
    $__ = @("$($tempFile).output", "$($tempFile).error") | % { Remove-Item "$_" -Force -EA SilentlyContinue }
  }
}

# Query-Download-File-Size "https://download.microsoft.com/download/dea8c210-c44a-4a9d-9d80-0c81578860c5/ENU/SQLServer2025-x64-ENU.exe"

# Include File: [\Includes\Query-VSWhere.ps1]
function Get-VSWhere-Exe([string] $tag) {
  if (-not $GLOBAL:_VSWHERE_EXE_FULL_PATH_BY_TAG) { $GLOBAL:_VSWHERE_EXE_FULL_PATH_BY_TAG = @{} }
  $dictionary = $GLOBAL:_VSWHERE_EXE_FULL_PATH_BY_TAG;
  $key = $tag;
  if (-not $key) { $key="latest" }
  if (-not $dictionary[$key]) {
    $exe = Get-VSWhere-Exe-Implementation $tag;
    $dictionary[$key] = $exe;
  }
  return $dictionary[$key];
}

function Get-VSWhere-Exe-Implementation([string] $tag) {
  $urlLatest = @("https://github.com/microsoft/vswhere/releases/latest/download/vswhere.exe", "https://github.com/microsoft/vswhere/releases/download/3.1.7/vswhere.exe")
  $url = if ($tag) { "https://github.com/microsoft/vswhere/releases/download/$tag/vswhere.exe" } else { @($urlLatest) }
  $cacheKey = if (-not $tag) { "latest" } Else { $tag }
  $ret = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "Visual Studio Bootstrapper" "vswhere-$cacheKey.exe";
  $isOk = Download-File-FailFree-and-Cached $ret @($url)
  return (IIF $isOk $ret $null);
}

function Query-VSWhere-as-Text([string[]] $arguments) {
  if (-not $arguments) { $arguments = @() }
  $ret = & "$(Get-VSWhere-Exe)" @($arguments)  | out-string
  return $ret
}

function Query-VSWhere-as-JSON([string[]] $arguments) {
  if (-not $arguments) { $arguments = @() }
  $arguments += @("-format", "json")
  # Troubleshoot-Info "Arguments [" -Highlight "$arguments" "]"
  $jsonString = Query-VSWhere-as-Text @($arguments)
  $json = $jsonString | ConvertFrom-Json
  $ret = @();
  foreach($vs in $json) {
    # Edition by productId
    $productId = $vs.productId
    $edition = if ($productId) { ("$productId".Split(".") | Select -Last 1) } Else { "Unknown" }
    $edition = $edition.Replace("BuildTools", "Build Tools")
    Add-Member -InputObject $vs -MemberType "NoteProperty" -Name "Edition" -Value $edition;
    # YEAR by displayName
    $displayName = $vs.DisplayName
    $year = if ($displayName) { ("$displayName".Split(" ") | Select -Last 1) } Else { "Unknown" }
    Add-Member -InputObject $vs -MemberType "NoteProperty" -Name "Year" -Value $year; 
    # VERSION by catalog.productSemanticVersion
    $rawVersion = if ($vs.catalog -and $vs.catalog.productSemanticVersion) { $vs.catalog.productSemanticVersion } Else { $null }
    Add-Member -InputObject $vs -MemberType "NoteProperty" -Name "Version" -Value (Get-VS-Version-By-ProductSemanticVersion-of-Catalog $rawVersion); 
    $ret += @($vs)
  }
  return @($ret | Sort-Object -Property @{ Expression = { To-Sortable-Version-String $_.InstallationVersion }; Descending = $true }, @{Expression = 'Year'; Descending = $true}, @{Expression = { Get-VS-Edition-Order $_.Edition }; Ascending = $true})
}

function Get-VS-Version-By-ProductSemanticVersion-of-Catalog([string] $rawVersion) {
  $ret = "";
  foreach($ch in "$rawVersion".ToCharArray()) { 
    $isProper = [bool] ("0123456789.".IndexOf("$ch") -ge 0)
    if (-not $isProper) { break }
    $ret += "$ch"
  }
  return $ret
}

function Get-VS-Edition-Order([string] $edition) {
  $o = @{ "Enterprise" = 1; "Professional" = 2; "Community" = 3; "Build Tools" = 4 }
  if ($edition) { $o[$edition] } 
}

function Find-VisualStudio-MSBuild([string] $year = "latest", [string] $edition = "any", [string] $arch = "best" <# x86|x64|arm64|best #>, [bool] $allowPrerelease = $false, [string[]] $arguments = @("-products", "*", "-all", "-prerelease")) {
  # currentArch: x86|arm64|x64
  $currentArch = Get-CPU-Architecture-Suffix-for-Windows
  $vsList = @(@(Query-VSWhere-as-JSON $arguments) | Select-Object -Property Year, Edition, Version, InstallationVersion, DisplayName, ProductId, InstallationPath, IsPreRelease)
  foreach($vs in $vsList) {
    $isYear = if (($vs.Year -eq $year) -or $year -eq "latest" -or (-not $year)) { $true }
    $isEdition = if (($vs.Edition -eq $edition) -or $edition -eq "any" -or (-not $edition)) { $true }
    if ( (-not $isYear) -or (-not $isEdition) ) { continue; }
    $installationPath = $vs.InstallationPath
    $baseMsBuildPath = Combine-Path $installationPath "MSBuild\Current\Bin"
    $baseMsBuildPathAlt = Combine-Path $installationPath "MSBuild\15.0\Bin"
    $candidate_x86   = @( @{ Arch = "x86"; Path = $baseMsBuildPath }, @{ Arch = "x86"; Path = $baseMsBuildPathAlt } );
    $candidate_x64   = @( @{ Arch = "x64"; Path = (Combine-Path $baseMsBuildPath "amd64") }, @{ Arch = "x64"; Path = (Combine-Path $baseMsBuildPathAlt "amd64") } );
    $candidate_arm64 = @{ Arch = "arm64"; Path = (Combine-Path $baseMsBuildPath "arm64") };
    if ($arch -eq "x86")   { $candidates = @($candidate_x86) }
    elseif ($arch -eq "x64")   { $candidates = @($candidate_x64) }
    elseif ($arch -eq "arm64") { $candidates = @($candidate_arm64) }
    else {
      if ($currentArch -eq "x86") { $candidates = @($candidate_x86) }
      if ($currentArch -eq "x64") { $candidates = @($candidate_x64) + @($candidate_x86) }
      if ($currentArch -eq "arm64") { 
        $candidates = @($candidate_arm64)
        if (Is-Intel-Emulation-Available 64) { $candidates += @($candidate_x64) }
        if (Is-Intel-Emulation-Available 32) { $candidates += @($candidate_x86) }
      }
    }
    foreach($candidate in $candidates) { 
      $msbuildPath = Combine-Path ($candidate.Path) "msbuild.exe"
      if ((-not $allowPrerelease) -and ($vs.isPrerelease)) { continue }
      $isMsBuildExists = [System.IO.File]::Exists($msbuildPath);
      if (-not $isMsBuildExists) { continue; }
      return $msbuildPath
    }
  }
}

function Demo-Find-VisualStudio-MSBuild([bool] $allowPrerelease) { 
  $jit = Find-VisualStudio-MSBuild
  $archList = "best arm64 x64 x86".Split(" ")
  $years = "2017 2019 2022 2026 latest".Split(" ")
  $editions = "Enterprise;Professional;Community;Build Tools;any".Split(";")
  foreach($year in $years) { foreach($edition in $editions) {
    Write-Host "'$($year)' `"$($edition)`""
    foreach($arch in $archList) {
       $msbuild = Find-VisualStudio-MSBuild $year $edition $arch -allowPreRelease $allowPrerelease
       if ($msbuild) { $msbuild = "`"$msbuild`"" }
       Write-Host ("       {0,-6} | {1}" -f "$($arch)", $msbuild)
    }
  }}
}

function Demo-Query-VSWhere() {
  Say "vswhere as Text"
  Query-VSWhere-as-Text "-nologo" | Out-Host
  Say "vswhere as json"
  Query-VSWhere-as-JSON | Out-Host
  Say "vswhere as json [-all] plus format"
  @(Query-VSWhere-as-JSON "-all") | Select-Object -Property Year, Edition, Version, InstallationVersion, DisplayName, ProductId, InstallationPath | ft -autosize | Out-String -Width 1234 | Out-Host
  Say "vswhere as json [-products * -all] plus format"
  @(Query-VSWhere-as-JSON "-products", "*", "-all") | Select-Object -Property Year, Edition, Version, InstallationVersion, DisplayName, ProductId, InstallationPath | ft -autosize | Out-String -Width 1234 | Out-Host
  Say "vswhere as json [-products * -all -prerelease] plus format"
  @(Query-VSWhere-as-JSON "-products", "*", "-all", "-prerelease") | Select-Object -Property Year, Edition, Version, InstallationVersion, DisplayName, ProductId, InstallationPath | ft -autosize | Out-String -Width 1234 | Out-Host
}

# Demo-Find-VisualStudio-MSBuild

# Include File: [\Includes\Remove-Windows-Service-If-Exists.ps1]
function Remove-Windows-Service-If-Exists([string] $serviceName, [string] $humanName) {
  # Delete Existing?
  $serviceStatus = [string](Get-Service -Name $serviceName -EA SilentlyContinue).Status
  # & sc.exe query "$serviceName" | out-null; $?
  if ($serviceStatus) { 
    if ($serviceStatus -ne "Stopped") {
      Say "Stopping existing $humanName"
      & net.exe stop $serviceName
    }
    Say "Deleting existing $humanName"
    & sc.exe delete $serviceName
  }
}

# Remove-Windows-Service-If-Exists "PG$9_26_X86" "Postgres SQL Windows Service"

# Include File: [\Includes\Reverse-Pipe.ps1]
function Reverse-Pipe() { $copy=@($input); for($i = $copy.Length - 1; $i -ge 0; $i--) { $copy[$i] } }

# $null | Reverse-Pipe
# $() | Reverse-Pipe
# @(42) | Reverse-Pipe
# @(1,2,3,4,"42") | Reverse-Pipe

# Include File: [\Includes\Run-Remote-Script.ps1]
function Get-FileName-by-Uri([string] $url) {
  $uri = [uri]$url
  $ret = $uri.Segments[-1]
  if ($ret -eq "download" -and $uri.Segments.Count -gt 1) {
    $ret = $uri.Segments[-2]
    $ret="$ret".TrimEnd("/")
  }
  return $ret
}

function Run-Remote-Script() {
  $pars = @($args)
  $url=$null
  $runner=""
  $passthrowArgs=@()
  for($p=0; $p -lt $pars.Length; $p++) {
    $vType="'null'"; if ($v -ne $null) { $vType = "$($v.GetType().Name)" }
    # Write-Host "[DEBUG ARGS] v=[$v], $vType" -ForegroundColor Yellow
    $v = $pars[$p];
    if (($p -le 1) -and ($v -eq "-r" -or $v -eq "--runner")) {
      if ($p+1 -lt $pars.Length) {
        $runner=$pars[$p+1];
        $p++;
        continue;
      } Else {
        throw "Run-Remote-Script Arguments Error: -r|--runner requires a value"
      }
    }
    Else {
      if ($url -eq $null -or -not $url) { 
        $url=$v
      } Else {
        $passthrowArgs += $v
      }
    }
  }


  $fileOnly = Get-FileName-by-Uri $url
  $folder = Combine-Path (Get-PS1-Repo-Downloads-Folder) "Scripts"
  $fileFullName = Combine-Path $folder $fileOnly
  $runnerParameter=""
  if (-not $runner) {
    if ("$fileFullName".ToLower().EndsWith(".ps1")) {
      $runner="$([System.Diagnostics.Process]::GetCurrentProcess().MainModule.FileName)"
      # or if (([System.IO.Path]::GetFileName($runner)) -eq "powershell.exe")
      if ($PSVersionTable.PSEdition -and $PSVersionTable.PSEdition -eq "Desktop" -or ([System.IO.Path]::GetFileName($runner)) -eq "powershell.exe") {
        $runnerParameter=" -f"
      }
    }
    elseif ("$fileFullName".ToLower().EndsWith(".sh")) {
      $runner="bash"
    }
    else {
      $err="[Run-Remote-Script] Abort. Unable to infer runner for remote script '$url', file is '$fileFullName'"
      Write-Line -TextRed "$err"
      throw $err;
    }
  }
  Write-Line "Invoking " -TextCyan "$runner$runnerParameter" " " -TextGreen "$url" " " -TextGreen "$passthrowArgs" 
  # Write-Host "RUNNER: [$runner]"
  # Write-Host "URL: [$url]"
  # Write-Host "Arguments (Count = $($passthrowArgs.Length)): $passthrowArgs"
  # Write-Host "Local File: $fileFullName"
  $okDownload = Download-File-Managed "$url" "$fileFullName"
  # Write-Host "okDownload: $okDownload"
  if ($okDownload) {
      $a=@($runnerParameter, $fileFullName) + @($passthrowArgs)
      $a=@($a | ? { "$_" })
      & "$runner" @($a)
      # Incorrect version if $runner contains space
      # $allWorld = $runner.Split(" ") + @($runnerParameter) + @($fileFullName) + $passthrowArgs;
      # $allWorld = @($allWorld | ? { "$_" })
      # & $allWorld[0] @($allWorld | Select-Object -Skip 1) | Out-Host
      if (-not $?) {
        Write-Line -TextRed "Run-Remote-Script FAIL: '$url'"
      }
  }
}

# Include File: [\Includes\Say.ps1]
function Say { # param( [string] $message )
    if ($Global:_Say_Stopwatch -eq $null) { $Global:_Say_Stopwatch = [System.Diagnostics.Stopwatch]::StartNew(); }
    $milliSeconds=$Global:_Say_Stopwatch.ElapsedMilliseconds
    if ($milliSeconds -ge 3600000) { $format="HH:mm:ss"; } else { $format="mm:ss"; }
    $elapsed="[$((new-object System.DateTime(0)).AddMilliseconds($milliSeconds).ToString($format))]"
    if (-not (Is-Ansi-Supported)) {
      Write-Host "$($elapsed) " -NoNewline -ForegroundColor Magenta
      Write-Host "$args" -ForegroundColor Yellow
    } else {
      $esc = [char] 27; 
      Write-Host "$esc[95;1m$($elapsed) " -NoNewline -ForegroundColor Magenta
      Write-Host "$esc[93;1m$esc[1m$($args)$($esc)[m" -ForegroundColor Yellow
    }
}
$Global:_Say_Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

# https://ss64.com/nt/syntax-ansi.html
function Is-Ansi-Supported() {
  if ((Get-Os-Platform) -ne "Windows") { return $true; }
  $buildServerType = Try-BuildServerType;
  if ("$buildServerType" -eq "GITHUB_ACTIONS" -or "$buildServerType" -eq "TF_BUILD") { return $true; }
  $rawReleaseId = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseId -EA SilentlyContinue | % {$_.ReleaseId}
  if ($rawReleaseId) { 
    $releaseId = [int] $rawReleaseId;
    return ($releaseId -ge 1809); # 1909 
  }
  return $false;
}

function Get-Windows-Release-Id() {
  if ((Get-Os-Platform) -ne "Windows") { return $null; }
  $rawReleaseId = Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion' -Name ReleaseId -EA SilentlyContinue | % {$_.ReleaseId}
  if ($rawReleaseId) { 
    $releaseId = [int] $rawReleaseId;
    return $releaseId;
  }
  return $null;
}

# Include File: [\Includes\Set-Property-Smarty.ps1]
function Set-Property-Smarty(
  [object] $object,    <# either [Hashtable] or [PSCustomObject] #>
  [string] $property,  <# name of the property #>
  [object] $value
)
{
  $GLOBAL:Set_Property_Smarty_Counter = $GLOBAL:Set_Property_Smarty_Counter + 1
  if ($object -eq $null) { $object = [PSCustomObject]@{}; } # OR THROW ERROR
  if ($GLOBAL:DEBUG_Set_Property_Smarty) { Write-Host "[DEBUG $($GLOBAL:Set_Property_Smarty_Counter)] Argument `$object is $($object.GetType())"; $object | Get-Member | % {[PSCustomObject]$_} | format-table -Property "Name", "MemberType", "Definition" | out-host; }
  if ($object -is [pscustomobject]) {
    if ($GLOBAL:DEBUG_Set_Property_Smarty) { Write-Host "[DEBUG $($GLOBAL:Set_Property_Smarty_Counter)] arg is [PSCustomObject]"; }
    $hasProperty = ($null -ne ($object | Get-Member | ? { $_.Name -eq "$property" } | Select -First 1))
    if ($hasProperty) {
      $object."$property" = $value;
    } else {
      $memberType = If ($value -is [ScriptBlock]) { "ScriptMethod"; } else { "NoteProperty"; }
      $__ = Add-Member -InputObject $object -MemberType $memberType -Name "$property" -Value $value
    }
  }
  elseif ($object -is [hashtable]) {
    if ($GLOBAL:DEBUG_Set_Property_Smarty) { Write-Host "[DEBUG $($GLOBAL:Set_Property_Smarty_Counter)] arg is [HashTable]"; }
    $object[$property] = $value;
  }
  else {
    Write-Host "Set-Property-Smarty accept only [HashTable] or [PSCustomObject] first argument `$object" -ForeGroundColor Red
  }
  if ($GLOBAL:DEBUG_Set_Property_Smarty) { Write-Host "[DEBUG $($GLOBAL:Set_Property_Smarty_Counter)] UPDATED `$object is $($object.GetType())"; $object | Get-Member | % {[PSCustomObject]$_} | format-table -Property "Name", "MemberType", "Definition" | out-host; }
}

function Test-Set-Property-Smarty() {
  # $GLOBAL:DEBUG_Set_Property_Smarty = $true

  Write-Host "TEST HASHTABLE" -ForegroundColor Magenta
  $ht = @{X=1;T="Yes"}; Set-Property-Smarty $ht "P" "Added"; $ht | ft | out-host

  Write-Host ""; Write-Host "TEST PSCustomObject" -ForegroundColor Magenta
  $ps = [PSCustomObject]@{X=1;T="Yes"}; 
  Set-Property-Smarty $ps "M2" {"M2() is invoked "}; 
  Set-Property-Smarty $ps "P2" "Added"; 
  Set-Property-Smarty $ps "P3" "V3"; 
  $ps | Get-Member | % {[PSCustomObject]$_} | format-table -Property "Name", "MemberType", "Definition" | out-host; 
  Write-Host $ps
  Write-Host $ps.M2()
}

# Test-Set-Property-Smarty

# Include File: [\Includes\Setup-VisualStudio.ps1]
$VisualStudio_Setup_Metadata = @{
  # 2017
  "2017 Enterprise"   = @{ Url = "https://aka.ms/vs/15/release/vs_enterprise.exe";  TestOrder = 14; Nickname = "Entrprs17" }
  "2017 Professional" = @{ Url = "https://aka.ms/vs/15/release/vs_professional.exe"; TestOrder = 44; Nickname = "Pro17"     }
  "2017 Community"    = @{ Url = "https://aka.ms/vs/15/release/vs_community.exe";    TestOrder = 34; Nickname = "Commnty17" }
  "2017 Build Tools"  = @{ Url = "https://aka.ms/vs/15/release/vs_buildtools.exe";   TestOrder = 24; Nickname = "BTools17"  }

  # 2019
  "2019 Enterprise"   = @{ Url = "https://aka.ms/vs/16/release/vs_enterprise.exe";  TestOrder = 13; Nickname = "Entrprs19" }
  "2019 Professional" = @{ Url = "https://aka.ms/vs/16/release/vs_professional.exe"; TestOrder = 44; Nickname = "Pro19"     }
  "2019 Community"    = @{ Url = "https://aka.ms/vs/16/release/vs_community.exe";    TestOrder = 33; Nickname = "Commnty19" }
  "2019 Build Tools"  = @{ Url = "https://aka.ms/vs/16/release/vs_buildtools.exe";   TestOrder = 23; Nickname = "BTools19"  }

  # 2022
  "2022 Enterprise"   = @{ Url = "https://aka.ms/vs/17/release/vs_enterprise.exe";  TestOrder = 22; Nickname = "Entrprs22" } #12
  "2022 Professional" = @{ Url = "https://aka.ms/vs/17/release/vs_professional.exe"; TestOrder = 43; Nickname = "Pro22"     }
  "2022 Community"    = @{ Url = "https://aka.ms/vs/17/release/vs_community.exe";    TestOrder = 32; Nickname = "Commnty22" }
  "2022 Build Tools"  = @{ Url = "https://aka.ms/vs/17/release/vs_buildtools.exe";   TestOrder = 12; Nickname = "BTools22"  } #22 
  
  # 2026
  "2026 Enterprise"   = @{ Url = "https://aka.ms/vs/stable/vs_enterprise.exe";  TestOrder = 11; Nickname = "Entrprs26" }
  "2026 Professional" = @{ Url = "https://aka.ms/vs/stable/vs_professional.exe"; TestOrder = 41; Nickname = "Pro26"     }
  "2026 Community"    = @{ Url = "https://aka.ms/vs/stable/vs_community.exe";    TestOrder = 31; Nickname = "Commnty26" }
  "2026 Build Tools"  = @{ Url = "https://aka.ms/vs/stable/vs_buildtools.exe";   TestOrder = 21; Nickname = "BTools26"  }
}

foreach($vsid in $VisualStudio_Setup_Metadata.Keys) {
  $VisualStudio_Setup_Metadata[$vsid]["ExeWithoutExtension"] = "VisualStudio-$($vsid.Replace(" ", "-"))-Bootstrapper"
}

function Get-VSID-List-In-Test-Order() {
  @($VisualStudio_Setup_Metadata.Keys | Sort-Object -Property @{ Expression = { $VisualStudio_Setup_Metadata[$_].TestOrder }; Ascending = $true } | % { "$_" })
}

function Get-VisualStudio-Setup-Process-Names() { @("setup") }

function Find-Processes([string[]] $names) { 
  $all = [System.Diagnostics.Process]::GetProcesses()
  $ret = $all | ? { if ($names.Length -eq 0) { return $true }; $processName = $_.ProcessName; return $null -ne ($names | ? { $_ -eq $processName }) }
  @($ret | % { "$($_.ProcessName)" })
}

function Has-VisualStudio-Setup-Process() {
  return [bool] (@(Find-Processes (Get-VisualStudio-Setup-Process-Names)).Length -gt 0)
}

# timeout - milliseconds, 0 means "do not wait"
# True if completed, otherwise Not Completed
function Wait-For-Processes-Completed([string[]] $names, [int] $timeout = 7200*1000) {
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  do {
    $foundCount = [bool] @(Find-Processes @($names)).Length
    if ($foundCount -eq 0) { return $true }
    [System.Threading.Thread]::Sleep(100)
  } while ($startAt.ElapsedMilliseconds -lt $timeout)
  return $false
}

function Wait-For-VisualStudio-Setup-Is-Running([int] $timeout = 5*60*1000) {
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  do {
    $foundCount = [bool] @(Find-Processes (Get-VisualStudio-Setup-Process-Names)).Length
    if ($foundCount -gt 0) { return $true }
    [System.Threading.Thread]::Sleep(100)
  } while ($startAt.ElapsedMilliseconds -lt $timeout)
  return $false
}

function Wait-For-VisualStudio-Setup-Completed([int] $timeout = 7200*1000) {
  return Wait-For-Processes-Completed (Get-VisualStudio-Setup-Process-Names) $timeout
}

function Get-VisualStudio-Bootstrapper-Exe([string] $VSID) {
  $meta = $VisualStudio_Setup_Metadata["$VSID"]
  # $meta | ft -AutoSize | out-host
  $url = if ($meta) { $meta.Url } Else { $null }
  if ((-not $url) -or (-not $meta.ExeWithoutExtension)) {
    Write-Host "[Get-VisualStudio-Bootstrapper] ABORT. Unknown Visual Studio ID '$VSID'"
    return $false;
  }

  $algorithm="SHA512"
  $exe = "$($meta.ExeWithoutExtension).exe"
  $ret = Combine-Path "$(Get-PS1-Repo-Downloads-Folder)" "Visual Studio Bootstrapper" "$exe";
  $isOk = Download-File-FailFree-and-Cached $ret @("$url")
  return (IIF $isOk $ret $null);
}

function Test-Get-VisualStudio-Bootstrapper-Exe() {
  $vsidList = @($VisualStudio_Setup_Metadata.Keys | % { "$_" })
  $vsidList = Get-VSID-List-In-Test-Order;
  foreach($vsid in $vsidList) {
    $exe = Get-VisualStudio-Bootstrapper-Exe -VSID $vsid
    Write-Host "[$vsid]: '$exe'" -ForegroundColor Green
  }
}

function Start-Interactive-VisualStudio-Setup([string] $VSID) {
  Start-Process (Get-VisualStudio-Bootstrapper-Exe $VSID)
}

function Format-Components-as-Args([string[]] $components) {
  return (($components | % { "--add $_" }) -join " ")
}

<# quotes are prohibited for nockname #>
function Build-VisualStudio-Setup-Arguments([string] $type, [string] $nickname) {
   $isQuiet = [bool] (Is-SshClient) -or (Is-BuildServer)
   $quietArg = if ($isQuiet) { "--quiet" } else { "--passive" }
   # --nickname SHOULD NOT be used with --remove
   $nicknameArgs = if ($nickname) { @("--nickname", "$nickname") } Else { @() }
   # Write-Host "nickname args: [$nicknameArgs]"
   $cacheArgs = @();
   $cacheFolder = "$ENV:VS_SETUP_CACHE_FOLDER"
   if ($cacheFolder) { $cacheArgs = @("--path", "cache=`"$cacheFolder`"") }
   $removeNonEnglish = @("cs-CZ de-DE es-ES fr-FR it-IT ja-JP ko-KR pl-PL pt-BR ru-RU tr-TR zh-CN zh-TW".Split(" ") | % { "--removeProductLang $_" }) -join " "
   $addEnglish = "--addProductLang en-US"
   # NET Core SDK: "Microsoft.NetCore.Component.SDK"
   $commonComponents = @(
       "Microsoft.Net.Component.3.5.DeveloperTools",
       "Microsoft.Net.Component.4.TargetingPack",
       "Microsoft.Net.Component.4.5.TargetingPack",
       "Microsoft.Net.Component.4.5.1.TargetingPack",
       "Microsoft.Net.Component.4.5.2.TargetingPack",
       "Microsoft.Net.Component.4.6.1.TargetingPack",
       "Microsoft.Net.Component.4.6.2.TargetingPack",
       "Microsoft.Net.Component.4.6.TargetingPack",
       "Microsoft.Net.Component.4.7.1.TargetingPack",
       "Microsoft.Net.Component.4.7.2.TargetingPack",
       "Microsoft.Net.Component.4.7.TargetingPack",
       "Microsoft.Net.Component.4.8.TargetingPack",
       "Microsoft.Net.Component.4.8.1.TargetingPack",
       "Microsoft.VisualStudio.Component.IISExpress",       # Missing for Build Tools
       "Microsoft.VisualStudio.Component.MSODBC.SQL",
       "Microsoft.VisualStudio.Component.MSSQL.CMDLnUtils", # Missing for Build Tools
       "Microsoft.Component.MSBuild",
       "Microsoft.VisualStudio.Component.NuGet",
       "Microsoft.VisualStudio.Component.SQL.SSDTBuildSku"  # SQL Server Data Tools (SSDT) and .sqlproj targets
   );
   if ($type -eq "Basic Components") {
      # NON-BUILDTOOLS: Microsoft.VisualStudio.Workload.ManagedDesktop, Microsoft.VisualStudio.Workload.NetWeb
      # BUILDTOOLS: Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools Microsoft.VisualStudio.Workload.WebBuildTools
      $components = @("Microsoft.VisualStudio.Workload.ManagedDesktop", "Microsoft.VisualStudio.Workload.NetWeb", "Microsoft.VisualStudio.Workload.ManagedDesktopBuildTools", "Microsoft.VisualStudio.Workload.WebBuildTools");
      $components += $commonComponents;
      $componentsArg = Format-Components-as-Args $components;
      $list = "$componentsArg $quietArg --includeRecommended --includeOptional --wait --force --norestart $addEnglish $removeNonEnglish"
      $arguments = @($list.Split(" ") | ? { "$_" -ne "" })
      $arguments += $cacheArgs
      $arguments += $installFolderArgs
      $arguments = $nicknameArgs + $arguments
      return $arguments;
   }
   if ($type -eq "Mini") {
      $componentsArg = Format-Components-as-Args $commonComponents;
      $list = "--includeRecommended --includeOptional $componentsArg $quietArg --wait --force --norestart $addEnglish $removeNonEnglish"
      $arguments = @($list.Split(" ") | ? { "$_" -ne "" })
      $arguments += $cacheArgs
      $arguments += $installFolderArgs
      $arguments = $nicknameArgs + $arguments
      # Write-Host $arguments
      return $arguments;
   }
}

function Setup-VisualStudio([string] $VSID, [string[]] $arguments) {
<#
    .SYNOPSIS

    Visual Studio ID     Name                                  Version                     
    ----------------     ----                                  -------                     
    2017 Build Tools     Visual Studio Build Tools 2017 (4)    15.9.78                     
    2019 Build Tools     Visual Studio Build Tools 2019 (4)    16.11.53                    
    2022 Build Tools     Visual Studio Build Tools 2022 (4)    17.14.22 (December 2025)    
    2026 Build Tools     Visual Studio Build Tools 2026 (4)    18.1.0                      
    2017 Community       Visual Studio Community 2017 (3)      15.9.78                     
    2019 Community       Visual Studio Community 2019 (3)      16.11.53                    
    2022 Community       Visual Studio Community 2022 (3)      17.14.22 (December 2025)    
    2026 Community       Visual Studio Community 2026 (3)      18.1.0                      
    2017 Professional    Visual Studio Professional 2017       15.9.78                     
    2019 Professional    Visual Studio Professional 2019       16.11.53                    
    2022 Professional    Visual Studio Professional 2022       17.14.22 (December 2025)    
    2026 Professional    Visual Studio Professional 2026       18.1.0                      
    2017 Enterprise      Visual Studio Enterprise 2017 (2)     15.9.78                     
    2019 Enterprise      Visual Studio Enterprise 2019 (2)     16.11.53                    
    2022 Enterprise      Visual Studio Enterprise 2022 (2)     17.14.22 (December 2025)    
    2026 Enterprise      Visual Studio Enterprise 2026 (2)     18.1.0                      

    setx VS_SETUP_CACHE_FOLDER T:\VS-Cache
    $ENV:VS_SETUP_CACHE_FOLDER = "T:\VS-Cache"

    $ENV:VS_SETUP_INSTALL_FOLDER = "T:\Micorosft Visual Studio"
    setx VS_SETUP_INSTALL_FOLDER "T:\Micorosft Visual Studio"

    # Interactive Setup
    Setup-VisualStudio "2026 Enterprise"

    # Command line msbuild, target frameworks, sqlcmd and iis express
    Setup-VisualStudio "2026 Community" "Mini"

    # IDE with Web and Managed Desktop plus "Mini"
    Setup-VisualStudio "2026 Enterprise" "Basic Components"

    # Custom workloads and components
    Setup-VisualStudio "2026 Community" "--add Microsoft.VisualStudio.Workload.Azure --addProductLang en-US --includeRecommended --includeOptional --wait --force --passive --norestart".Split(" ")
    Setup-VisualStudio "2026 Community" "--add Microsoft.Component.MSBuild --addProductLang en-US --includeRecommended --includeOptional --wait --force --passive --norestart".Split(" ")
    See details: https://learn.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community?
#>
  $exe = (Get-VisualStudio-Bootstrapper-Exe $VSID)
  if (-not $exe) { return }
  # $nickname = "$VSID".Replace(" ", "").ToLower(); if ($nickname.Length -gt 9) { $nickname = $nickname.Substring(0,9) }
  $nickname = $VisualStudio_Setup_Metadata["$VSID"]["Nickname"]

  if ($arguments -and ($arguments.Length -eq 1)) {
    Write-Host "Installing [$vsid] as nickname = '$nickname'"
    $foundArgs = Build-VisualStudio-Setup-Arguments $arguments[0] $nickname;
    if ($foundArgs -and ($foundArgs.Length -gt 0)) { 
      $arguments = $foundArgs
      $installFolder = "$ENV:VS_SETUP_INSTALL_FOLDER"; 
      if ($installFolder) {
        if ($installFolder -match "{VSID}") { $installFolder = "$installFolder".Replace("{VSID}", "$vsid") } Else { $installFolder = Combine-Path $installFolder "$vsid" }
        $arguments = @(@($arguments) + @("--path", "install=`"$installFolder`"") | ? { $_ })
      }
    }
  }

  $isSetupRinning = Wait-For-VisualStudio-Setup-Is-Running -Timeout 1
  if ($isSetupRinning) { 
    Write-Host "VS Setup Abort. Another setup is already running" -ForeGroundColor Red;
    return 
  }

  # Write-Host "`"$exe`" $arguments" -ForegroundColor Yellow
  Write-Host "$(Format-Command-Line "^" "$exe" $arguments)" -ForegroundColor Yellow
  # Write-Host "$($arguments -join "`r`n")" -ForegroundColor Magenta
  if ($arguments -and ($arguments.Length -gt 0)) { $__ = Start-Process $exe -ArgumentList @($arguments | ? { $_ }) } Else { $__ = Start-Process $exe }
  # wating for bootstrapper.exe forward control to setup.exe
  return Wait-For-VisualStudio-Setup-Is-Running -Timeout (5*60*1000)
}

function Format-Command-Line([string] $newLine, [string] $command, [string[]] $parts) {
  $parts = @("`"$($command)`"") + ($parts)
  $ret = ""; $len = 0;
  foreach($part in $parts) {
    if ($len -gt 180) { $ret += "$($newLine)$([Environment]::NewLine)    "; $len=4 }
    $ret += "$part "; $len += "$part".Length + 1;
  }
  return "$ret".TrimEnd()
}
# Format-Command-Line "^" "\xxx\yyy\cmd" "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm", "-aasdasdasd", "-dfhgfhfhg", "-bnmbmbmbnmbnm"


function Find-VisualStudio-Installed-Products() {
  @(Get-Speedy-Software-Product-List | ? { $_.Vendor -match "Microsoft" -and $_.Name -like "Visual*" -and $_.Name -match "Studio" } | Select-Object -Property Name, Version)
}

function Test-Setup-VisualStudio([string] $kind = "Basic Components" <# or Mini #>, [switch] $nocache) {
  # Set-ExecutionPolicy RemoteSigned; Install-Module SqlServer-Version-Management -Force -AllowClobber; if (Test-Path T:\) { setx VS_SETUP_CACHE_FOLDER T:\VS-Cache; $ENV:VS_SETUP_CACHE_FOLDER = "T:\VS-Cache" }
  # @("$ENV:SYSTEMDRIVE\Program Files\Microsoft Visual Studio", "$ENV:SYSTEMDRIVE\Program Files (x86)\Microsoft Visual Studio") | % { New-Item -Path "$_" -ItemType Directory -Force; & "compact.exe" /c /s:"$_"; }
  $vsidList = @($VisualStudio_Setup_Metadata.Keys | % { "$_" } | Sort-Object -Descending)
  $vsidList = Get-VSID-List-In-Test-Order;
  if ((Get-CPU-Architecture-Suffix-for-Windows) -eq "x86") {
    # Remove 2022 and 2026 except Built Tools on 32-bit x86 Windows
    $vsidList = @($vsidList | ? { ($_ -match "2017") -or  ($_ -match "2019") -or ($_ -match "Build Tools")} )
  }
  $setupTitle = { "$_" }
  $setupAction = {
    Say "EDITION: $_"; 
    $vsid = $_
    $nickname = $VisualStudio_Setup_Metadata["$VSID"]["Nickname"]
    $commandLineArgs = Build-VisualStudio-Setup-Arguments $kind $nickname
    if ($nocache) { $commandLineArgs = $commandLineArgs + "--nocache"}
    Setup-VisualStudio $vsid @($commandLineArgs | ? { $_ })
    $okStarted = Wait-For-VisualStudio-Setup-Is-Running -Timeout (5*60*1000)
    Write-Host "Setup STARTED Success? $okStarted"
    $okCompleted = Wait-For-VisualStudio-Setup-Completed -Timeout (7200*1000)
    Write-Host "Setup FINISHED Success? $okCompleted"
    Find-VisualStudio-Installed-Products | ft -autosize | Out-String -Width 1234 | out-host
  }

  $errors = @($vsidList | Try-Action-ForEach -ActionTitle "TEST VISUAL STUDIO SETUP" -Action $setupAction -ItemTitle $setupTitle)
  $totalErrors = $errors.Count;

  if ($totalErrors -gt 0) { throw "Failed counter = $totalErrors" }
}

# Test-Get-VisualStudio-Bootstrapper-Exe

# Has-VisualStudio-Setup-Process
# Wait-For-VisualStudio-Setup-Completed 1
# Wait-For-Processes-Completed (Get-VisualStudio-Setup-Process-Names) (7200*1000)

# @(Find-Processes "No-Such-Process").Length
# @(Find-Processes "Explorer").Length
# @(Find-Processes "Chrome").Length
# @(Find-Processes "Chrome", "Explorer").Length


# Include File: [\Includes\Start-Stopwatch.ps1]
function Start-Stopwatch() {
  $ret = [PSCustomObject] @{
    StartAt = [System.Diagnostics.Stopwatch]::StartNew();
  };
  $ret | Add-Member -Force -MemberType ScriptMethod -name GetElapsed -value {
      $milliSeconds = $this.StartAt.ElapsedMilliseconds
      if ($milliSeconds -lt 9000) { return "{0:f2}" -f ($milliSeconds / [double] 1000); }
      if ($milliSeconds -lt 60000) { return "{0:f1}" -f ($milliSeconds / [double] 1000); }
      if ($milliSeconds -ge 3600000) { $format="HH:mm:ss"; } else { $format="mm:ss.f"; }
      return "$((new-object System.DateTime(0)).AddMilliseconds($milliSeconds).ToString($format))"
  }
  # legacy powershell does not override ToString properly
  $ret | Add-Member -Force -MemberType ScriptMethod -name ToString -value { $this.GetElapsed(); }
  return $ret;
}

<# 
  $x = Start-Stopwatch; Sleep -Milliseconds 123; "[$($x.GetElapsed()) seconds]"
#>

# Include File: [\Includes\To-Boolean.ps1]
function To-Boolean() { param([string] $name, [string] $value)
  if (($value -eq "True") -Or ($value -eq "On") -Or ($value -eq "1") -Or ("$value".ToLower().StartsWith("enable"))) { return $true; }
  if (("$value" -eq "") -Or ($value -eq "False") -Or ($value -eq "Off") -Or ($value -eq "0") -Or ("$value".ToLower().StartsWith("disable"))) { return $false; }
  Write-Host "Validation Error! Invalid $name parameter '$value'. Boolean parameter accept only True|False|On|Off|Enable|Disable|1|0" -ForegroundColor Red
  return $false;
}

# Include File: [\Includes\To-Sortable-Version-String.ps1]
function To-Sortable-Version-String([string] $arg) {
  $ret = New-Object System.Text.StringBuilder;
  $numberBuffer = New-Object System.Text.StringBuilder;
  for($i=0; $i -lt $arg.Length; $i++) {
    $c = $arg.Substring($i, 1);
    if ($c -ge "0" -and $c -le "9") {
      $__ = $numberBuffer.Append($c)
    }
    else {
      if ($numberBuffer.Length -gt 0) { $__ = $ret.Append($numberBuffer.ToString().PadLeft(42,"0")); $numberBuffer.Length = 0; }
      $__ = $ret.Append($c)
    }
  }
  # same
  if ($numberBuffer.Length -gt 0) { $__ = $ret.Append($numberBuffer.ToString().PadLeft(42,"0")) }
  return $ret.ToString();
}

function Test-Version-Sort() {
  @("PG-9.6.24", "PG-10.1", "PG-11.3", "PG-11.12", "PG-16.4") | % { To-Sortable-Version-String $_ }

  $objects = @(
    @{Version = "PG-9.6.24"; InstalledDate = [DateTime] "2020-01-01"}, 
    @{Version = "PG-10.1";   InstalledDate = [DateTime] "2021-02-02"}, 
    @{Version = "PG-11.3";   InstalledDate = [DateTime] "2022-03-03"}, 
    @{Version = "PG-11.12";  InstalledDate = [DateTime] "2023-04-04"}, 
    @{Version = "PG-16.4";   InstalledDate = [DateTime] "2024-05-05"}
  );
  $objects |
    % { [pscustomobject] $_ } |
    Sort-Object -Property @{ Expression = { To-Sortable-Version-String $_.Version }; Descending = $true }, @{ Expression = "InstalleDate"; Descending = $false } |
    Format-Table * -AutoSize
}

# Test-Version-Sort

# Include File: [\Includes\Troubleshoot-Info.ps1]
function Troubleshoot-Info() {
  $enableTroubleShoot = To-Boolean "PS1_TROUBLE_SHOOT" "$($ENV:PS1_TROUBLE_SHOOT)"
  if (-not $enableTroubleShoot) { return; }
  $c = (Get-PSCallStack)[1]
  $cmd = $c.Command;
  # Write-Host -NoNewLine "[$cmd" -ForegroundColor DarkCyan
  $toWrite = @("-TextDarkCyan", "[$cmd");
  $line=$null; 
  if ($c.Location) { 
    # $line = ":$($c.Location.Split(32) | Select -Last 1)"; 
    $lineRaw = "$($c.Location.Split(32) | Select -Last 1)"; 
    try { $line = [int]::Parse($lineRaw); $line=":$line" } catch { $line="" }
  }
  if ($line) {
    # Write-Host -NoNewLine "$line" -ForegroundColor DarkCyan;
    $toWrite += "$line"
  }
  # Write-Host -NoNewLine "] " -ForegroundColor DarkCyan
  $toWrite += @("] ", "-Reset");
  $color="Gray";
  $args | % {
    if ($_ -eq "-Highlight") { 
      $color = "Cyan";
    } else { 
      # if ($color) { Write-Host -NoNewLine "$_" -ForegroundColor $color; } else { Write-Host -NoNewLine "$_"; }
      if ($color) { 
        # Write-Host -NoNewLine "$_" -ForegroundColor $color; 
        $toWrite += $("-Text$color", "$_");
      } else { 
        # Write-Host -NoNewLine "$_"; 
        $toWrite += $("-Reset", "$_");
      }
      $color = "Gray"
      $toWrite += "-Reset"
    }
  }
  Write-Line -DirectArgs $toWrite;
  # $toWrite
}

<#
function Troubleshoot-Info-Prev([string] $message) {
  $enableTroubleShoot = To-Boolean "PS1_TROUBLE_SHOOT" "$($ENV:PS1_TROUBLE_SHOOT)"
  if (-not $enableTroubleShoot) { return; }
  $c = (Get-PSCallStack)[1]
  $cmd = $c.Command;
  Write-Host -NoNewLine "[$cmd" -ForegroundColor DarkGreen
  $line=$null; if ($c.Location) { $line = ":$($c.Location.Split(32) | Select -Last 1)"; }
  if ($line) {
    Write-Host -NoNewLine "$line" -ForegroundColor Green;
  }
  Write-Host -NoNewLine "] " -ForegroundColor DarkGreen
  Write-Host "$message"
}
#>

# Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow Gray DarkGray Blue Green Cyan Red Magenta Yellow White
# Include File: [\Includes\Try-And-Retry.ps1]
function Try-And-Retry([string] $title, <# [ScriptBlock] #> $action, [int] $retryCount = 3, [int] $pauseMilliseconds = 1000) {
  if ($action -is [string]) {
        $action = [scriptblock]::Create($action)
  }
  
  for($retry=1; $retry -le $retryCount; $retry++) {
    $exitCode = 0;
    $err=$null;
    try { 
       $Global:LASTEXITCODE = 0;
       $ret = Invoke-Command -ScriptBlock $action; 
       $exitCode = $Global:LASTEXITCODE; 
       $err = $null; 
       if ($exitCode) { $err = new-object Exception("Command Failed. Exit Code $exitCode"); }
    } catch { $err=$_.Exception; }
    if ($err -eq $null) {
      return $ret;
    }
    if ($retry -eq $retryCount) { $msg = "The action `"$title`" failed $retry times. $($err.Message)"; Write-Host $msg -ForeGroundColor Red; throw new-object Exception($msg); return; }
    Write-Host "The action `"$($title)`" failed. Retrying, $($retry+1) of $retryCount. Error reason is $($err.Message)" -ForeGroundColor Red
    [System.Threading.Thread]::Sleep($pauseMilliseconds)
  }
}
# Try-And-Retry "Success 42" { 42; }
# Try-And-Retry "Download httttt://xxxx" { & curl.exe httttt://xxxx }
# Try-And-Retry "Download https://google.com" { & curl.exe "-I" https://google.com }

# Include File: [\Includes\Write-Line.ps1]
function Get-ANSI-Colors() {
  $isAzurePipeline = (Try-BuildServerType) -eq "TF_BUILD";
  $Esc=[char]27;
  $ANSI_COLORS = @{ 
    Reset     = "$($Esc)[0m"
    Bold      = "$($Esc)[1m"
    Underline = "$($Esc)[4m"
    Inverse   = "$($Esc)[7m"
    
    TextBlack       = "$($Esc)[30m"
    TextDarkBlue    = "$($Esc)[34m"
    TextDarkGreen   = "$($Esc)[32m"
    TextDarkCyan    = "$($Esc)[36m"
    TextDarkRed     = "$($Esc)[31m"
    TextDarkMagenta = "$($Esc)[35m"
    TextDarkYellow  = "$($Esc)[33m"
    # 98 is incorrent on azure pipeline
    TextGray        = IIF $isAzurePipeline "$($Esc)[90m$($Esc)[98m" "$($Esc)[98m" #?
    TextDarkGray    = "$($Esc)[90m" #?
    TextBlue        = "$($Esc)[94m"
    TextGreen       = "$($Esc)[92m"
    TextCyan        = "$($Esc)[96m"
    TextRed         = "$($Esc)[91m"
    TextMagenta     = "$($Esc)[95m"
    TextYellow      = "$($Esc)[93m"
    TextWhite       = "$($Esc)[97m"

    BackBlack       = "$($Esc)[40m"
    BackDarkBlue    = "$($Esc)[44m"
    BackDarkGreen   = "$($Esc)[42m"
    BackDarkCyan    = "$($Esc)[46m"
    BackDarkRed     = "$($Esc)[41m"
    BackDarkMagenta = "$($Esc)[45m"
    BackDarkYellow  = "$($Esc)[43m"
    BackGray        = "$($Esc)[100m" #?
    BackDarkGray    = "$($Esc)[108m" #?
    BackBlue        = "$($Esc)[104m"
    BackGreen       = "$($Esc)[102m"
    BackCyan        = "$($Esc)[106m"
    BackRed         = "$($Esc)[101m"
    BackMagenta     = "$($Esc)[105m"
    BackYellow      = "$($Esc)[103m"
    BackWhite       = "$($Esc)[107m"
  }
  $ANSI_COLORS
}

# Write-Line "Hello " -TextRed -Bold "World"
Function Write-Line([string[]] $directArgs = @()) {
  $ansiColors = Get-ANSI-Colors;
  $isAnsiSupported = Is-Ansi-Supported;
  $directArgs += @($args);
  $arguments = @($directArgs);
  $text="Gray";
  $back="Black";
  $ansi="";
  foreach($arg in $arguments) {
    $isControl = $false;
    $isReset = $false;
    if ($arg.StartsWith("-")) {
      if ($arg.Length -gt 1) {
        $key = $arg.SubString(1);
        if ($ansiColors -and $ansiColors[$key]) {
          $ansiValue = $ansiColors[$key];
          $ansi += $ansiValue;
          $isReset = ($key -eq "Reset");
          if ($isReset) { $text="Gray"; $back="Black"; <# $ansi += $ansiColors["Reset"] #> }
          if ($key -like "Text*") { $text = $key.SubString(4) }
          if ($key -like "Back*") { $back = $key.SubString(4) }
          $isControl = $true;
        }
      }
    }
    if (-not $isControl) {
      if ($isAnsiSupported) { Write-Host "$($ansi)$($arg)" -NoNewLine -ForegroundColor $text -BackgroundColor $back }
      # if ($isAnsiSupported) { Write-Host "$($ansi)$($arg)" -NoNewLine }
      else { Write-Host "$($arg)" -NoNewLine -ForegroundColor $text -BackgroundColor $back }
    }
    # if ($isReset) { $ansi = ""; } TODO: After Text
  }
  Write-Host "";
}


function Show-Text-Matrix() {
  $colors = "Black Blue DarkBlue Green DarkGreen Cyan DarkCyan Red DarkRed Magenta DarkMagenta Yellow DarkYellow DarkGray Gray White".Split(" ");
  foreach($back in $colors) {
    $line = @("{0,11}: " -f $back);

    foreach($text in $colors) {
      $line += @("-Reset", "|", "-Text$($text)", "-Back$($back)", " $text ")
    }
    
    Write-Line -DirectArgs $line
  }
}

Write-Line "Env Variable " -TextMagenta "'The_Variable'" -Reset " set to " -TextGreen "'The_Value'"

Write-Line -TextMagenta -Underline -Bold "ANSI" -Reset " (bold underline magenta)"
Show-Text-Matrix

function Is-Ansi-Supported() { $false }

Write-Host "Classic"
Show-Text-Matrix

# Write-Line "That's All. " -TextMagenta -Underline -Bold "Bye"
# Write-Line -Underline "Bye Bye"

foreach($ver in @(2301, 2201, 1604)) {
  $exe = Get-Full7z-Exe-FullPath-for-Windows $null $ver
  Write-Host "7z $($ver): [$exe]" -ForeGroundColor Green
}
