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
function Download-File-FailFree-and-Cached([string] $fullName, [string[]] $urlList, [string] $algorithm="SHA512") {
  
  if ((Is-File-Not-Empty "$fullName") -and (Is-File-Not-Empty "$fullName.$algorithm")) { 
    $hashActual = Get-Smarty-FileHash "$fullName" $algorithm
    $hashExpected = Get-Content -Path "$fullName.$algorithm"
    if ($hashActual -eq $hashExpected -and "$hashActual" -ne "") {
      Troubleshoot-Info "File already downloaded: '" -Highlight "$fullName" "'"
      return $true;
    }
  }
  $isOk = [bool] ((Download-File-FailFree $fullName $urlList) | Select -Last 1)
  if ($isOk) { 
    $hashActual = Get-Smarty-FileHash "$fullName" $algorithm
    echo "$hashActual" > "$($fullName).$algorithm"
    return $true; 
  }

  return $false;
}

# Include File: [\Includes\Download-File-Managed.ps1]
function Download-File-Managed([string] $url, [string]$outfile) {
  $dirName=[System.IO.Path]::GetDirectoryName($outfile)
  Create-Directory "$dirName";
  $okAria=$false; try { & aria2c.exe -h *| out-null; $okAria=$? } catch {}
  if ($okAria) {
    Troubleshoot-Info "Starting download `"" -Highlight "$url" "`" using aria2c as `"" -Highlight "$outfile" "`""
    # "-k", "2M",
    $startAt = [System.Diagnostics.Stopwatch]::StartNew()
    & aria2c.exe @("--allow-overwrite=true", "--check-certificate=false", "-x", "16", "-j", "16", "-d", "$($dirName)", "-o", "$([System.IO.Path]::GetFileName($outfile))", "$url");
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

function Download-File-FailFree([string] $outFile, [string[]] $urlList) {
  foreach($url in $urlList) {
    $isOk = Download-File-Managed $url $outFile | Select -Last 1;
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

# Include File: [\Includes\Get-Cpu-Name.ps1]
function Get-Cpu-Name-Implementation {
  $platform = Get-Os-Platform
  if ($platform -eq "Windows") {
    $proc = Select-WMI-Objects "Win32_Processor" | Select -First 1;
    return "$($proc.Name)".Trim()
  }

  if ($platform -eq "MacOS") {
    return (& sysctl "-n" "machdep.cpu.brand_string" | Out-String-And-TrimEnd)
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
    return $ret
  }

  $ret = $null;
  try { $ret = Get-Nix-Uname-Value "-m"; } catch {}
  if ($ret) { return "$ret"; }

  return "Unknown"
}

function Get-Cpu-Name {
  [OutputType([string])] param()

  if (-not $Global:_Cpu_Name) { $Global:_Cpu_Name = "$(Get-Cpu-Name-Implementation)"; }
  return $Global:_Cpu_Name;
}

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
  pushd "$($toDirectory)"
  $mini7z = "$(Get-Mini7z-Exe-FullPath-for-Windows)"
  # "-o`"$plainFolder`""
  $commandLine=@("x", "-y", "`"$fromArchive`"")
  $singleCore7z=@(); $memInfo = Get-Memory-Info; $procCount = ([Environment]::ProcessorCount); if ($memInfo -and ($memInfo.Free) -and ($memInfo.Free -lt (640*$procCount))) { $singleCore7z=@("-mmt=1") }
  $commandLine += $singleCore7z
  Troubleshoot-Info "fromArchive: '$fromArchive'; commandLine: '$commandLine'"
  # ok on pwsh and powersheel
  & "$mini7z" @commandLine
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
    Write-Host "'$title' took $($msec.ToString("n0")) ms"
  } else {
    # Write-Host $err.GetType()
    Write-Host "Fail. $($err.Message)" -ForeGroundColor Red -NoNewLine;
    Write-Host " '$title' took $($msec.ToString("n0")) ms"
  }
  $ErrorActionPreference=$ea
}

# Include File: [\Includes\Out-String-And-TrimEnd.ps1]
Function Out-String-And-TrimEnd
{
  Param ([int] $Skip=0, [int] $Take=2000000000)
  Begin { $n=0; $list = New-Object System.Collections.Generic.List[System.Object]}
  Process { $n++; if (-not ($n -le $Skip -or $n -gt ($Skip+$Take))) { $list.Add("$_"); } }
  End { return [string]::join([System.Environment]::NewLine, $list.ToArray()).TrimEnd(@([char]13,[char]10)) }
}

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
function Try-And-Retry([string] $title, [ScriptBlock] $action, [int] $retryCount = 3, [int] $pauseMilliseconds = 1000) {
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
          if ($isReset) { $text="Gray"; $back="Black"; }
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

# Include Directive: [ ..\Includes.SqlServer\*.ps1 ]
# Include File: [\Includes.SqlServer\$SqlServer2010DownloadLinks.ps1]
$SqlServer2010DownloadLinks = @(
  @{ 
    Version="2014-x64"; #SP3
    Core     ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x64_ENU.exe" 
    Advanced ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPRADV_x64_ENU.exe" #SP3, 
    # SP1 does not work on Pipeline
    # Developer="https://archive.org/download/sql-server-2014-enterprise-sp-1-x-64/SQL_Server_2014_Enterprise_SP1_x64.rar" #SP1
    # DeveloperFormat="ISO-In-Archive"
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2014-x64-ENU.7z", "https://archive.org/download/sql_server_2014_sp3_developer_edition_x64.7z/sql_server_2014_sp3_developer_edition_x64.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2014_sp3_developer_edition_x64.7z/download") #SP3, 12.0.6024
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/ENU/x64/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2014-x86"; #SP3
    Core     ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x86_ENU.exe" 
    Advanced ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPRADV_x86_ENU.exe"
    # Developer="https://archive.org/download/microsoft-sql-server-2014-enterprise-sp-3-32-bit/Microsoft%20SQL%20Server%202014%20Enterprise%20SP3%20%2832Bit%29.zip"
    # DeveloperFormat="ISO-In-Archive"
    Developer=("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2014-x86-ENU.7z", "https://archive.org/download/sql_server_2014_sp3_developer_edition_x86.7z/sql_server_2014_sp3_developer_edition_x86.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2014_sp3_developer_edition_x86.7z/download")
    DeveloperFormat="Archive"
    LocalDB  ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/ENU/x86/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2012-x64"; #SP4
    Core ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPR_x64_ENU.exe" 
    Advanced="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPRADV_x64_ENU.exe" 
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2012-x64-ENU.7z", "https://archive.org/download/sql_server_2012_sp4_developer_x86_x64/sql_server_2012_sp4_developer_x64.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2012_sp4_developer_edition_x64.7z/download") # 11.0.7001.0 SP4
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/ENU/x64/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2012-x86"; #SP4
    Core ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPR_x86_ENU.exe" 
    Advanced="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPRADV_x86_ENU.exe"
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2012-x86-ENU.7z", "https://archive.org/download/sql_server_2012_sp4_developer_x86_x64/sql_server_2012_sp4_developer_x86.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2012_sp4_developer_edition_x86.7z/download") # 11.0.7001.0 SP4
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/ENU/x86/SqlLocalDB.msi"
    CU=@(
    )
  };

  @{ 
    Version="2008R2-x64"; #SP2
    Core    ="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x64_ENU.exe" 
    Advanced="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRADV_x64_ENU.exe" 
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008R2-x64-ENU.7z", "https://archive.org/download/sql_server_2008r2_sp3_developer_edition_x86_x64_ia64/sql_server_2008r2_sp3_developer_edition_x64.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008r2_sp3_developer_edition_x64.7z/download")
    DeveloperFormat="Archive"
    CU=@(
      @{ Id="SP3"; Url="https://download.microsoft.com/download/D/7/A/D7A28B6C-FCFE-4F70-A902-B109388E01E9/ENU/SQLServer2008R2SP3-KB2979597-x64-ENU.exe" }
    )
  };
  @{ 
    Version="2008R2-x86"; #SP2
    Core    ="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x86_ENU.exe" 
    Advanced="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRADV_x86_ENU.exe"
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008R2-x86-ENU.7z", "https://archive.org/download/sql_server_2008r2_sp3_developer_edition_x86_x64_ia64/sql_server_2008r2_sp3_developer_edition_x86.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008r2_sp3_developer_edition_x86.7z/download")
    DeveloperFormat="Archive"
    CU=@(
      @{ Id="SP3"; Url="https://download.microsoft.com/download/D/7/A/D7A28B6C-FCFE-4F70-A902-B109388E01E9/ENU/SQLServer2008R2SP3-KB2979597-x86-ENU.exe" }
    )
  };
  # https://archive.org/download/en_sql_server_2008_r2_developer_x86_x64_ia64_dvd_522665

  # 2008 SP2
  @{ 
    Version="2008-x64"; 
    # DONE: Updated for the direct publication
    # Core  ="https://web.archive.org/web/20160617214727/https://download.microsoft.com/download/0/F/D/0FD88169-F86F-46E1-8B3B-56C44F6E9505/SQLEXPR_x64_ENU.exe"  #SP3
    Core    ="https://archive.org/download/sql-server-express-2008-x86-x64-sp4/SQL-Core-2008-x64-ENU.exe"
    Advanced="https://download.microsoft.com/download/e/9/b/e9bcf5d7-2421-464f-94dc-0c694ba1b5a4/SQLEXPRADV_x64_ENU.exe" #RTM
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008-x64-ENU.7z", "https://archive.org/download/sql_server_2008_developer_edition_x86_x64/sql_server_2008_rtm_developer_edition_x64.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008_rtm_developer_edition_x64.7z/download") # RTM
    DeveloperFormat="Archive"
    CU=@(
      # x64 is alive
      @{ Id="SP4"; Url="https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x64-ENU.exe" }
      # https://web.archive.org/web/20200812071912/https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x64-ENU.exe
    )
    
  };
  @{ 
    Version ="2008-x86"; #SP2
    # DONE: Updated for the direct publication
    # Core  ="https://web.archive.org/web/20160617214727/https://download.microsoft.com/download/0/F/D/0FD88169-F86F-46E1-8B3B-56C44F6E9505/SQLEXPR_x86_ENU.exe" #SP3
    Core    ="https://archive.org/download/sql-server-express-2008-x86-x64-sp4/SQL-Core-2008-x86-ENU.exe"
    Advanced="https://download.microsoft.com/download/e/9/b/e9bcf5d7-2421-464f-94dc-0c694ba1b5a4/SQLEXPRADV_x86_ENU.exe" #RTM
    Developer=@("https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008-x86-ENU.7z", "https://archive.org/download/sql_server_2008_developer_edition_x86_x64/sql_server_2008_rtm_developer_edition_x86.7z", "https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008_rtm_developer_edition_x86.7z/download") # RTM
    DeveloperFormat="Archive"
    CU=@(
      # x86 is removed
      # @{ Id="SP4"; Url="https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x86-ENU.exe" }
      # It is not reliable
      # @{ Id="SP4"; Url="https://web.archive.org/web/20200804042408/https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x86-ENU.exe" }
      # Explicit web archive publication
      @{ Id="SP4"; Url="https://archive.org/download/sql-server-express-2008-x86-x64-sp4/SQLServer2008SP4-KB2979596-x86-ENU.exe" }
    )
  };
  @{ 
    Version="2005-x86"; 
    Core    ="https://archive.org/download/sql_server_express_2005_x86_sp4_9.0.5000/sql_server_express_2005_x86_sp4_9.0.5000.exe";
    # Core    ="https://sourceforge.net/projects/db-engine/files/database-engine-x86-9.0.5000.exe/download";  #SP4
    # Advanced="https://ia601402.us.archive.org/34/items/Microsoft_SQL_Server_2005/en_sql_2005_express_adv.exe" #SP1
    # Advanced="https://archive.org/download/Microsoft_SQL_Server_2005/en_sql_2005_express_adv.exe" #SP1
    Advanced="https://archive.org/download/SQLEXPR_ADV_2005_SP2/SQLEXPR_ADV.EXE"
    CU=@(
      # Core already SP4
      @{ Id="SP4"; Url="https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/01/sqlserver2005expressadvancedsp4-kb2463332-x86-enu_b8640fde879a23a2372b27f158d54abb5079033e.exe" }
    )
  };
)
<#
              (sp2) https://archive.org/download/SQLEXPR_ADV_2005_SP2/SQLEXPR_ADV.EXE
was: 9.0.2047 (sp1) https://ia601402.us.archive.org/34/items/Microsoft_SQL_Server_2005/en_sql_2005_express_adv.exe
now: 9.0.5000 (sp4) https://catalog.s.download.windowsupdate.com/msdownload/update/software/svpk/2011/01/sqlserver2005expressadvancedsp4-kb2463332-x86-enu_b8640fde879a23a2372b27f158d54abb5079033e.exe
#>

<# Developer Edition, Small 64M Dictionary
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008-x64-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008-x86-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008R2-x64-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2008R2-x86-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2012-x64-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2012-x86-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2014-x64-ENU.7z
https://archive.org/download/sql_server_developer_edition_legacy/SQL-Developer-2014-x86-ENU.7z
#>

# Include File: [\Includes.SqlServer\$SqlServerAlreadyUpdatedList.ps1]
$SqlServerAlreadyUpdatedList = @(
  @{ Version = "2008R2-x64"; MediaType = "Developer"; },
  @{ Version = "2008R2-x86"; MediaType = "Developer"; },
  @{ Version = "2005-x86";   MediaType = "Core"; }
);

# Include File: [\Includes.SqlServer\$SqlServerDownloadLinks.ps1]
$SqlServerDownloadLinks = @(
   @{
      Version="2025"
      LocalDB="https://archive.org/download/sql_server_2025_prerelease_developer_edition/SqlLocalDB.msi"
      Developer=@(
         "https://archive.org/download/sql_server_2025_prerelease_developer_edition/SQLServer2025-x64-ENU.box",
         "https://archive.org/download/sql_server_2025_prerelease_developer_edition/SQLServer2025-x64-ENU.exe")
   },
   @{
      Version="2022"
      Advanced="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLEXPRADV_x64_ENU.exe"
      Core="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLEXPR_x64_ENU.exe"
      LocalDB="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SqlLocalDB.msi"
      Developer=@(
         "https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLServer2022-DEV-x64-ENU.box",
         "https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLServer2022-DEV-x64-ENU.exe")
      CU=@(
        # @{ Id="CU14"; Url="https://download.microsoft.com/download/9/6/8/96819b0c-c8fb-4b44-91b5-c97015bbda9f/SQLServer2022-KB5038325-x64.exe"; }
        # @{ Id="CU15"; 
        #   Url=@(
        #    "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2024/09/sqlserver2022-kb5041321-x64_1b40129fb51df67f28feb2a1ea139044c611b93f.exe",
        #    "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/sqlserver2022-kb5041321-x64_1b40129fb51df67f28feb2a1ea139044c611b93f.exe"
        #   );
        # }
        # CU17
        @{ Id="CU17"; 
           Url=@(
            "https://download.microsoft.com/download/9/6/8/96819b0c-c8fb-4b44-91b5-c97015bbda9f/SQLServer2022-KB5048038-x64.exe",
            "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/SQLServer2022-KB5048038-x64.exe"
           );
         }
      )
   },
   @{
      Version="2019"
      Advanced="https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLEXPRADV_x64_ENU.exe"
      Core="https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLEXPR_x64_ENU.exe"
      LocalDB="https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SqlLocalDB.msi"
      Developer=@(
         "https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLServer2019-DEV-x64-ENU.box",
         "https://download.microsoft.com/download/8/4/c/84c6c430-e0f5-476d-bf43-eaaa222a72e0/SQLServer2019-DEV-x64-ENU.exe")
      CU=@(
        # @{ Id="CU30"; 
        #   Url=@(
        #    "https://download.microsoft.com/download/6/e/7/6e72dddf-dfa4-4889-bc3d-e5d3a0fd11ce/SQLServer2019-KB5049235-x64.exe",
        #    "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/SQLServer2019-KB5049235-x64.exe"
        #   );
        # }
        # @{ Id="CU28"; Url="https://download.microsoft.com/download/6/e/7/6e72dddf-dfa4-4889-bc3d-e5d3a0fd11ce/SQLServer2019-KB5039747-x64.exe"; }
        # CU31 
        # https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2025/02/sqlserver2019-kb5049296-x64_df5a52a752a86ff79331698949a99e8a53c97d97.exe
        # https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/sqlserver2019-kb5049296-x64_df5a52a752a86ff79331698949a99e8a53c97d97.exe
        @{ Id="CU31"; 
           Url=@(
            "https://catalog.s.download.windowsupdate.com/c/msdownload/update/software/updt/2025/02/sqlserver2019-kb5049296-x64_df5a52a752a86ff79331698949a99e8a53c97d97.exe",
            "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/sqlserver2019-kb5049296-x64_df5a52a752a86ff79331698949a99e8a53c97d97.exe"
           );
         }
      )

   },
   @{
      Version="2017"
      Advanced="https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLEXPRADV_x64_ENU.exe"
      Core="https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLEXPR_x64_ENU.exe"
      LocalDB="https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SqlLocalDB.msi"
      Developer=@(
         "https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLServer2017-DEV-x64-ENU.box",
         "https://download.microsoft.com/download/E/F/2/EF23C21D-7860-4F05-88CE-39AA114B014B/SQLServer2017-DEV-x64-ENU.exe")
      CU=@(
        @{ Id="CU31"; 
           Url=@(
             "https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB5016884-x64.exe",
             "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/SQLServer2017-KB5016884-x64.exe"
           );
         }
      )
   },
   @{
      Version="2016"
      Advanced="https://download.microsoft.com/download/f/9/8/f982347c-fee3-4b3e-a8dc-c95383aa3020/sql16_sp3_dlc/en-us/SQLEXPRADV_x64_ENU.exe"
      Core="https://download.microsoft.com/download/f/9/8/f982347c-fee3-4b3e-a8dc-c95383aa3020/sql16_sp3_dlc/en-us/SQLEXPR_x64_ENU.exe"
      LocalDB="https://download.microsoft.com/download/f/9/8/f982347c-fee3-4b3e-a8dc-c95383aa3020/sql16_sp3_dlc/en-us/SqlLocalDB.msi"
      Developer=@(
        "https://download.microsoft.com/download/f/9/8/f982347c-fee3-4b3e-a8dc-c95383aa3020/sql16_sp3_dlc/en-us/SQLServer2016SP3-FullSlipstream-DEV-x64-ENU.box",
        "https://download.microsoft.com/download/f/9/8/f982347c-fee3-4b3e-a8dc-c95383aa3020/sql16_sp3_dlc/en-us/SQLServer2016SP3-FullSlipstream-DEV-x64-ENU.exe")
      CU=@(
        @{ Id="1.KB5040946"; 
           Url=@(
             "https://download.microsoft.com/download/d/a/1/da18aac1-2cd0-4c52-b30d-39c3172cd156/SQLServer2016-KB5040946-x64.exe",
             "https://archive.org/download/sql_server_2016_2017_2019_2022_comulative_updates/SQLServer2016-KB5040946-x64.exe"
           );
         }
      )
   }
);

$SqlServerDownloadLinks_Via_Manager = @(
  @{ 
    Version="2016";
    BaseDev    ="https://download.microsoft.com/download/c/5/0/c50d5f5e-1adf-43eb-bf16-205f7eab1944/SQLServer2016-SSEI-Dev.exe"; #SP3, 3.0 Gb
    BaseExpress="https://download.microsoft.com/download/f/a/8/fa83d147-63d1-449c-b22d-5fef9bd5bb46/SQLServer2016-SSEI-Expr.exe" #SP3, 
    CU=@(
      @{ Id="1.KB5040946"; Url="https://download.microsoft.com/download/d/a/1/da18aac1-2cd0-4c52-b30d-39c3172cd156/SQLServer2016-KB5040946-x64.exe"; }
    )
  };
  @{
    Version="2017";
    BaseDev    ="https://download.microsoft.com/download/5/A/7/5A7065A2-C81C-4A31-9972-8A31AC9388C1/SQLServer2017-SSEI-Dev.exe";
    BaseExpress="https://download.microsoft.com/download/5/E/9/5E9B18CC-8FD5-467E-B5BF-BADE39C51F73/SQLServer2017-SSEI-Expr.exe"
    CU=@(
      @{ Id="CU31"; Url="https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB5016884-x64.exe"; }
    )
  };
  @{ 
    Version="2019";
    BaseDev    ="https://download.microsoft.com/download/d/a/2/da259851-b941-459d-989c-54a18a5d44dd/SQL2019-SSEI-Dev.exe";
    BaseExpress="https://download.microsoft.com/download/7/f/8/7f8a9c43-8c8a-4f7c-9f92-83c18d96b681/SQL2019-SSEI-Expr.exe"
    CU=@(
      @{ Id="CU28"; Url="https://download.microsoft.com/download/6/e/7/6e72dddf-dfa4-4889-bc3d-e5d3a0fd11ce/SQLServer2019-KB5039747-x64.exe"; }
    )
  };
  @{ 
    Version="2022";
    BaseDev    ="https://download.microsoft.com/download/c/c/9/cc9c6797-383c-4b24-8920-dc057c1de9d3/SQL2022-SSEI-Dev.exe";
    BaseExpress="https://download.microsoft.com/download/5/1/4/5145fe04-4d30-4b85-b0d1-39533663a2f1/SQL2022-SSEI-Expr.exe"
    CU=@(
      @{ Id="CU14"; Url="https://download.microsoft.com/download/9/6/8/96819b0c-c8fb-4b44-91b5-c97015bbda9f/SQLServer2022-KB5038325-x64.exe"; }
    )
  };
)

# $SqlServerDownloadLinks | ConvertTo-Json -Depth 32

# Include File: [\Includes.SqlServer\Clean-Up-Sql-Server-Databases.ps1]
function Clean-Up-Sql-Server-Databases([string] $title, [string] $connectionString, <# or #>[string] $instance, [ScriptBlock] $filter, [int] $timeoutSec = 30) {
  if (-not $connectionString) { $connectionString = "Server=$($instance);Integrated Security=SSPI;Connection Timeout=$timeoutSec;Pooling=False" }
  $startAt = [System.Diagnostics.Stopwatch]::StartNew();

  $builder = new-object System.Data.SqlClient.SqlConnectionStringBuilder($connectionString);
  $dataSource = $builder.DataSource
  Write-Host "Clean up SQL Server '$dataSource'"

  $dbList = @();

  $sql = "Select name [Name] From sys.databases db Where Cast(Case When db.name in ('master','model','msdb','tempdb') Then 1 Else db.is_distributor End AS bit) = 0 Order By 1;"
  $con = New-Object System.Data.SqlClient.SqlConnection($connectionString);
  $con.Open();
  $cmd = new-object System.Data.SqlClient.SqlCommand($sql, $con)
  $cmd.CommandTimeout = $timeoutSec;
  $dataAdapter = new-object System.Data.SqlClient.SqlDataAdapter($cmd);
  $dataTable = new-object System.Data.DataTable;
  $__ = $dataAdapter.Fill($dataTable);
  foreach($row in $dataTable.Rows) {
    $dbName = $row["Name"]
    $dbList += [PSCustomObject] @{DataSource = $dataSource; Database = $dbName; Description = "[$dbName] at '$dataSource'"} 
  }

  $dbList | ft -Property Database -AutoSize | Out-String -Width 1234 | Out-Host

  foreach($db in $dbList) {
    $toKill = If ($null -eq $filter) { $false } Else { ForEach-Object -InputObject $db -Process $filter | Select -First 1 }
    if ($toKill) {
      Write-Host "Deleting DB $($db.Description)"
      $sqlDelete = @"
Begin Try 
   IF SERVERPROPERTY('EngineEdition') <> 5 EXEC(N'ALTER DATABASE [$($db.Database)] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;')
End Try 
Begin Catch 
  Print 'db already offline or does not exists' 
End Catch 
Exec(N'Drop Database [$($db.Database)]');
"@;
      $cmd = new-object System.Data.SqlClient.SqlCommand($sqlDelete, $con)
      $cmd.CommandTimeout = $timeoutSec;
      $__ = $cmd.ExecuteNonQuery();
      Write-Host "Database successfully deleted: $($db.Description)" -ForeGroundColor DarkGreen
    } else {
      Write-Host "Keep Existing DB $($db.Description)"
    }
  }
}

# Clean-Up-Sql-Server-Databases -Title "Local Default SQL Server" -Instance "(local)"
# Clean-Up-Sql-Server-Databases -Title "Local Default SQL Server" -Instance "(local)" -Filter { $_.Database -match "Test" }


# Include File: [\Includes.SqlServer\Create-LocalDB-Instance.ps1]
# Using latest SQLLocalDB.exe
function Create-LocalDB-Instance([string] $instanceName, [string] $optionalVersion) {
  $pars = @("create", "`"$instanceName`"");
  if ($optionalVersion) { $pars += $optionalVersion }
  $title = "Create LocalDB instance `"$instanceName`""
  if ($optionalVersion) { $title += " version $optionalVersion" }
  return Invoke-LocalDB-Executable -Title $title -Version "Latest" -Parameters @($pars)
}

function Delete-LocalDB-Instance([string] $instanceName) {
  if ("$instanceName" -like "(LocalDB)\*" -and "$instanceName".Length -gt 10) { $instanceName = "$instanceName".SubString(10) }
  # STOP instance by kill
  $pars = @("stop", "`"$instanceName`"", "-k");
  $title = "Stop (by kill) LocalDB Instance `"$instanceName`""
  $__ = Invoke-LocalDB-Executable -Title $title -Version "Latest" -Parameters @($pars)
  # Delete instance
  $pars = @("delete", "`"$instanceName`"");
  $title = "Delete LocalDB Instance `"$instanceName`""
  return Invoke-LocalDB-Executable -Title $title -Version "Latest" -Parameters @($pars)
}

function Test-Create-Delete-LocalDB-Instance() {
  Write-Host "DELETING Custom Instances" -ForegroundColor Magenta
  $__ = Find-LocalDb-SqlServers |
       % { "$($_.Instance)" } |
       ? { "$_" -match "LocalDB-" } |
       % { Write-Host "Deleting $_" -ForegroundColor Yellow; Delete-LocalDB-Instance "$_" }

  Find-LocalDb-SqlServers | Populate-Local-SqlServer-Version |
     ft -AutoSize |
     Out-String -Width 1234 |
     Out-Host

  Write-Host "CREATING Custom Instances" -ForegroundColor Magenta
  foreach($localDb in Find-LocalDb-Versions) {
    $instance = "LocalDB-v$($localDb.ShortVersion)"
    Write-Host "Creating Instance $instance version $($localDb.ShortVersion)"
    $isCreated = Create-LocalDB-Instance `
      -InstanceName $instance `
      -OptionalVersion $localDb.ShortVersion
  }

  Find-LocalDb-SqlServers | Populate-Local-SqlServer-Version |
     ft -AutoSize |
     Out-String -Width 1234 |
     Out-Host
}

# Include File: [\Includes.SqlServer\Download-2010-SQLServer-and-Extract.ps1]
function Download-2010-SQLServer-and-Extract {
  Param(
    [string] $version,  # (2014|2012|2008R2|2008)-(x86|x64)
    [string] $mediaType # Core|Advanced|LocalDB (localdb is missing for 2008R2)
  )

  $rootMedia=Combine-Path "$(Get-SqlServer-Media-Folder)" "SQL-$version-$mediaType-Compressed"
  $rootSetup=Combine-Path "$(Get-SqlServer-Setup-Folder)" "SQL-$version-$mediaType"
  $mediaPath = $rootMedia
  $ext = IIf ($mediaType -eq "LocalDB") ".msi" ".exe"
  $exeName = "SQL-$mediaType-$Version-ENU$ext"
  $exeArchive = Combine-Path $mediaPath $exeName
  $setupPath="$rootSetup"
  if ($mediaType -eq "LocalDB") { 
    $exeArchive = Combine-Path $setupPath $exeName
    $mediaPath = $null;
  }

  Write-Host "Download Media for '$version $mediaType'"
  $url="";
  $isDeveloper = [bool]($mediaType -eq "Developer");
  foreach($meta in $SqlServer2010DownloadLinks) {
    if ($meta.Version -eq $version) {
      $url = $meta[$mediaType]
      $urlFormat=$meta["$($mediaType)Format"]
      if ($urlFormat) {
        $ext = ".$urlFormat".ToLower();
        $ext = Try-Get-FileExtension-by-Uri $url;
        $exeName = "SQL-$mediaType-$Version-ENU$ext"
        $exeArchive = Combine-Path $mediaPath $exeName
      }
    }
  }
  if (-not $url) {
    Write-Host "Unknown SQL Server version $version $mediaType" -ForegroundColor DarkRed;
    return @{};
  }

  Write-Host "Downloading media for version $version $mediaType. URL(s) is '$url'. Setup file is '$exeArchive'";
  $isDownloadOk = Download-File-FailFree-and-Cached $exeArchive @($url)
  if (-not $isDownloadOk) {
    Write-Host "Download media for version $version $mediaType failed. URL(s) is '$url'" -ForegroundColor DarkRed;
    return @{};
  }

  $ret = @{ Version=$version; MediaType=$mediaType; };
  if ($mediaType -eq "LocalDB") {
    $ret["Launcher"] = $exeArchive;
    $ret["Setup"] = $setupPath;
  }
  else 
  {
    if ($null -eq $urlFormat)
    {
      $isExtractOk = ExtractSqlServerSetup "SQL Server $version $mediaType" $exeArchive $setupPath "/Q"
      if ($isExtractOk) {
        $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
        $ret["Setup"] = $setupPath;
        $ret["Media"] = $mediaPath;
      } else {
        return @{};
      }
    } elseif ($urlFormat -eq "ISO-In-Archive") {
      $isoFolder = Combine-Path $mediaPath "iso"
      Write-Host "Extracting '$exeArchive' to '$isoFolder'"
      $isExtract1Ok = Extract-Archive-by-Default-Full-7z "$exeArchive" "$isoFolder"
      $isoFile = Get-ChildItem -Path "$isoFolder" -Filter "*.iso" | Select -First 1
      Write-Host "ISO found: '$($isoFile.FullName)' ($($isoFile.Length.ToString("n0")) bytes). Extracting it to '$setupPath'";
      $isExtract2Ok = Extract-Archive-by-Default-Full-7z "$($isoFile.FullName)" "$setupPath"
      $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
      $ret["Setup"] = $setupPath;
      $ret["Media"] = $mediaPath;
    } elseif ($urlFormat -eq "Archive") {
      Write-Host "Extracting '$exeArchive' to '$setupPath'"
      $isExtract1Ok = Extract-Archive-by-Default-Full-7z "$exeArchive" "$setupPath"
      $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
      $ret["Setup"] = $setupPath;
      $ret["Media"] = $mediaPath;
    } else {
      Write-Host "Warning! Unknown format '$urlFormat' for '$url')" -ForegroundColor DarkRed
    }
  }

  ApplyCommonSqlServerState $ret;
  return $ret;
}

# Include File: [\Includes.SqlServer\Download-Fresh-SQLServer-and-Extract.ps1]
function Download-Fresh-SQLServer-and-Extract {
  Param(
    [string] $version,  # 2016|2017|2019|2022
    [string] $mediaType # LocalDB|Core|Advanced|Developer
  )

  $rootMedia=Combine-Path "$(Get-SqlServer-Media-Folder)" "SQL-$version-$mediaType-Compressed"
  $rootSetup=Combine-Path "$(Get-SqlServer-Setup-Folder)" "SQL-$version-$mediaType"
  if ($mediaType -eq "LocalDB") {
     $mediaPath = $rootSetup
  } else {
     $mediaPath = $rootMedia
  }
  $setupPath="$rootSetup"

  Write-Host "Download and Extract SQL Server $version media '$mediaType' to `"$setupPath`""
  $url="";
  foreach($meta in $SqlServerDownloadLinks) {
    if ($meta.Version -eq $version) {
      $url = $meta["$mediaType"]
    }
  }
  if (-not $url) {
    Write-Host "Unknown SQL Server version $version" -ForegroundColor DarkRed;
    return @{};
  }

  Troubleshoot-Info "URL(s) IS " -Highlight "$url"
  $urlList = IIF ($url -is [array]) $url @($url);
  foreach($nextUrl in $urlList) {
    $fileName=[System.IO.Path]::GetFileName($nextUrl); # TODO: trim /download at the end
    $fileFull = Combine-Path $mediaPath $fileName
    $isDownloadOk = Download-File-FailFree-and-Cached $fileFull @($nextUrl)
    if (-not $isDownloadOk) {
      Write-Host "Download bootstrapper for version $version failed. Unable to download URL '$nextUrl' as '$fileFull'" -ForegroundColor DarkRed;
      return @{};
    }
  }
  
  $ext = IIF ($mediaType -eq "LocalDB") "msi" "exe"
  $exeArchive = Get-ChildItem -Path "$mediaPath" -Filter "*.$ext" | Select -First 1
  Write-Host "(Exe|Msi) Archive `"$exeArchive`""
  $ret = @{ Version=$version; MediaType=$mediaType; };
  if ($mediaType -eq "LocalDB") {
    $ret["Launcher"] = Combine-Path $setupPath $exeArchive;
    $ret["Setup"] = $setupPath;
  }
  else
  {
    $quietArg = IIF ((Is-BuildServer) -or (Is-SshClient)) "/Q" "/QS"
    $isExtractOk = ExtractSqlServerSetup "SQL Server $version $mediaType" $exeArchive.FullName $setupPath "$quietArg"
    if ($isExtractOk) {
      $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
      $ret["Setup"] = $setupPath;
      $ret["Media"] = $mediaPath;
    } else {
      return @{};
    }
  }

  ApplyCommonSqlServerState $ret;
  return $ret;
}



























function Download-Fresh-SQLServer-and-Extract-Via-Manager {
  Param(
    [string] $version,  # 2016|2017|2019|2022
    [string] $mediaType # LocalDB|Core|Advanced|Developer
  )

  $key="SQL-$version-$mediaType"
  $root=Combine-Path "$(Get-SqlServer-Downloads-Folder)" $key
  if ($mediaType -eq "LocalDB") {
     $mediaPath = $root
  } else {
     $mediaPath = Combine-Path "$(Get-SqlServer-Downloads-Folder)" "SQL-Setup-Compressed" "SQL-$Version-$mediaType" 
  }
  $setupPath="$root"

  Write-Host "Download Bootstrapper for '$key'"
  $url="";
  $isDeveloper = [bool]($mediaType -eq "Developer");
  foreach($meta in $SqlServerDownloadLinks) {
    if ($meta.Version -eq $version) {
      $url = IIf $isDeveloper $meta.BaseDev $meta.BaseExpress
    }
  }
  if (-not $url) {
    Write-Host "Unknown SQL Server version $version" -ForegroundColor DarkRed;
    return @{};
  }

  $exeBootstrap = Combine-Path "$(Get-SqlServer-Downloads-Folder)" "SQL-Setup-Bootstrapper" "SQL-$Version-$(IIf $isDeveloper "Developer" "Express")-Bootstapper.exe"

  $isRawOk = Download-File-FailFree-and-Cached $exeBootstrap @($url)
  if (-not $isRawOk) {
    Write-Host "Download bootstrapper for version $version failed. URL is '$url'" -ForegroundColor DarkRed;
    return @{};
  }
  
  Write-Host "Download SQL Server $version media '$mediaType'"
  $mt = IIf $isDeveloper "CAB" $mediaType;
  # echo Y | "%outfile%" /ENU /Q /Action=Download /MEDIATYPE=%MT% /MEDIAPATH="%Work%\SETUPFILES"
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  $hideProgressBar=IIF (Is-BuildServer) " /HIDEPROGRESSBAR" "";
  & cmd.exe @("/c", "echo Y | `"$exeBootstrap`" /ENU /Q$hideProgressBar /Action=Download /MEDIATYPE=$mt /MEDIAPATH=`"$mediaPath`"")
  # & "$exeBootstrap" @("/ENU", "/Q", "/Action=Download", "/MEDIATYPE=$mt", "/MEDIAPATH=`"$mediaPath`"");
  if (-not $?) {
    Write-Host "Media download for version $version $mediaType. failed" -ForegroundColor DarkRed;
    return @{};
  }
  
  try { $length = Get-Folder-Size $mediaPath; } catch {}; $milliSeconds = $startAt.ElapsedMilliseconds;
  $size=""; if ($length -gt 0) { $size=" ($($length.ToString("n0")) bytes)"; }
  $speed=""; if ($length -gt 0 -and $milliSeconds -gt 0) { $speed=" Speed is $(($length*1000/1024/$milliSeconds).ToString("n0")) Kb/s."; }
  $duration=""; if ($milliSeconds -gt 0) {$duration=" It took $(($milliSeconds/1000.).ToString("n1")) seconds."; }
  Write-Host "Media '$mediaPath'$($size) download complete.$($duration)$($speed)"

  $ret = @{ Version=$version; MediaType=$mediaType; };
  if ($mediaType -eq "LocalDB") {
    $ret["Launcher"] = Combine-Path $mediaPath "en-US" "SqlLocalDB.msi";
    $ret["Setup"] = $setupPath;
  }
  else
  {
    $exeArchive = Get-ChildItem -Path "$mediaPath" -Filter "*.exe" | Select -First 1
    $quietArg = IIF (Is-BuildServer) "/Q" "/QS"
    $isExtractOk = ExtractSqlServerSetup "SQL Server $version $mediaType" $exeArchive.FullName $setupPath "$quietArg"
    if ($isExtractOk) {
      $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
      $ret["Setup"] = $setupPath;
      $ret["Media"] = $mediaPath;
    } else {
      return @{};
    }
  }

  ApplyCommonSqlServerState $ret;
  return $ret;
}

# Include File: [\Includes.SqlServer\Download-SQLServer-and-Extract.ps1]
function Download-SQLServer-and-Extract {
  Param(
    [string] $version,  # 2016|2017|2019|2022
    [string] $mediaType # LocalDB|Core|Advanced|Developer
  )
  $major = ($version.Substring(0,4)) -as [int];
  $is2020 = $major -ge 2016;
  if ($is2020) { 
    Download-Fresh-SQLServer-and-Extract $version $mediaType;
  } else {
    Download-2010-SQLServer-and-Extract $version $mediaType;
  }
}

function ApplyCommonSqlServerState([Hashtable] $ret) {
  if ($ret.Launcher) {
    try { $size = (New-Object System.IO.FileInfo($ret.Launcher)).Length; } catch {Write-Host "Warning $($_)"; }
    $ret["LauncherSize"] = $size;
  }
  if ($ret.Setup) {
    $ret["SetupSize"] = Get-Folder-Size $ret.Setup;
    if (Is-SqlServer-Setup-Cache-Enabled) { 
      $ret["SetupHash"] = Get-Smarty-FolderHash $ret.Setup "SHA512"
    }
  }
  if ($ret.Media) {
    $ret["MediaSize"] = Get-Folder-Size $ret.Media;
    # $ret["MediaHash"] = Get-Smarty-FolderHash $ret.Media "SHA512"
  }
}

function ExtractSqlServerSetup([string] $title, [string] $exeArchive, [string] $setupPath, [string] $quietArg <# /QS (Fresh) | /Q (prev) #>) {
  Write-Host "Extracting $title using [$($exeArchive)] to [$($setupPath)]"
  $extractStatus = Execute-Process-Smarty "$title Unpacker" "$($exeArchive)" @("$quietArg", "/X:`"$setupPath`"") -WaitTimeout 1800
  # $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  # $extractApp = Start-Process "$($exeArchive)" -ArgumentList @("$quietArg", "/x:`"$setupPath`"") -PassThru
  # if ($extractApp -and $extractApp.Id) {
  #   Wait-Process -Id $extractApp.Id
  #   if ($extractApp.ExitCode -ne 0) {
  #     Write-Host "Extracting $title failed. Exit code $($extractApp.ExitCode)." -ForegroundColor DarkRed;
  #     return $false;
  #   }
  # } else {
  #   Write-Host "Extracting $title. failed." -ForegroundColor DarkRed;
  #   return $false;
  # }
  # Write-Host "Extraction of $title took $($startAt.ElapsedMilliseconds.ToString("n0")) ms"
  return ($extractStatus.ExitCode -eq 0);
}

# Include File: [\Includes.SqlServer\Download-SqlServer-Update.ps1]
function Download-SqlServer-Update {
  Param(
    [string] $version,  # 2005...2022
    [string] $mediaType, # LocalDB|Core|Advanced|Developer
    [object] $update # {Id=;Url=;}
  )
  $ret = $update.Clone();
  $key="SQL-$version-Update-$($update.Id)"
  $archivePath = Combine-Path "$(Get-SqlServer-Media-Folder)" $key
  $archiveName = [System.IO.Path]::GetFileName($update.Url); # TODO: trim /download at the end
  $archiveFullName = Combine-Path $archivePath $archiveName;
  Write-Host "Downloading SQL Server update '$($update.Id)' for version $version $mediaType. URL(s) is '$($update.Url)'"
  # $isDownloadOk = Download-File-FailFree-and-Cached $archiveFullName @("$($update.Url)")
  $isDownloadOk = Download-File-FailFree-and-Cached $archiveFullName @($update.Url)
  if (-not $isDownloadOk) {
    Write-Host "Download SQL Server update '$($update.Id)' for version $version $mediaType failed. URL is '$($update.Url)'" -ForegroundColor DarkRed;
    return $ret;
  }

  $ret["UpdateId"] = $update.Id;
  $ret["UpdateFolder"] = $archivePath;
  $ret["UpdateLauncher"] = $archiveFullName;
  $ret["UpdateSize"] = (new-object System.IO.FileInfo($archiveFullName)).Length;
  return $ret;
}

<#
Name           Value                                                                                                             
----           -----                                                                                                             
Url            https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB5016884-x64.exe
Id             CU31                                                                                                              
UpdateId       CU31                                                                                                              
UpdateSize     561206208                                                                                                         
UpdateFolder   C:\SQL-Downloads\SQL-2017-CU31                                                                                    
UpdateLauncher C:\SQL-Downloads\SQL-2017-CU31\SQLServer2017-KB5016884-x64.exe                                                    
#>

# Include File: [\Includes.SqlServer\Enumerate-SQLServer-Downloads.ps1]
function Enumerate-SQLServer-Downloads() {
  $versions = "2005-x86", "2008-x86", "2008-x64", "2008R2-x86", "2008R2-x64", "2012-x86", "2012-x64", "2014-x86", "2014-x64", "2016", "2017", "2019", "2022";
  [array]::Reverse($versions);
  $mediaTypes = "LocalDB", "Core", "Advanced", "Developer";
  [array]::Reverse($mediaTypes);
  foreach($version in $versions) {
  foreach($mediaType in $mediaTypes) {
    $meta = Find-SQLServer-Meta $version $mediaType;
    if ($meta) {
      $meta;
    }
  }}
}

function Enumerate-Plain-SQLServer-Downloads() {
  foreach($meta in Enumerate-SQLServer-Downloads) {
    $baselineKeywords="$($meta.Version) $($meta.MediaType)"
    if ("$($meta.CU)") {
      foreach($update in $meta.CU) {
        $counter++;
        @{ Version=$meta.Version; MediaType=$meta.MediaType; UpdateId=$update.Id; Update=$update; Keywords="$baselineKeywords $($update.Id)"; NormalizedKeywords="$baselineKeywords Update"; };
      }
    }
    @{ Version=$meta.Version; MediaType=$meta.MediaType; Keywords="$baselineKeywords"; NormalizedKeywords="$baselineKeywords"};
  }
}

# Include File: [\Includes.SqlServer\Find-LocalDb-SqlServer.ps1]
# Super Fast
function Find-LocalDb-SqlServer() {
  $parentKey = Get-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server Local DB\Installed Versions" -EA SilentlyContinue
  $candidates = @();
  if ($parentKey) {
    foreach($subName in $parentKey.GetSubKeyNames()) { $candidates += $subName; }
  }
  [Array]::Sort($candidates);
  $last = $candidates | Select -Last 1;
  if (-not $last) { return; }
  if ($last -like "11.*") { $instance="(LocalDB)\v11.0" } else { $instance="(LocalDB)\MSSqlLocalDB" };
  @{ InstallerVersion = $last; Instance = $instance; }
}

function Start-LocalDb-SqlServer([int] $timeoutSec = 60) {
  $localDb = Find-LocalDb-SqlServer;
  $startAt = [System.Diagnostics.Stopwatch]::StartNew();
  if ($localDb) { 
    $conStr = "Data Source=$($localDb.Instance);Integrated Security=True;Pooling=false;Timeout=2";
    do {
        try { 
        $con = New-Object System.Data.SqlClient.SqlConnection($conStr);
        $con.Open();
        return $true;
        } catch {
        }
    } while($startAt.ElapsedMilliseconds -le ($timeoutSec * 1000));
    Write-Host "Warning! can't start SQL Server Local DB v$($localDb.Version) '$($localDb.Instance)' during $($startAt.ElapsedMilliseconds / 1000) seconds" -ForegroundColor DarkRed
  }
}

# Find-LocalDb-SqlServers
# Start-LocalDb-SqlServer -timeout 1


# Include File: [\Includes.SqlServer\Find-LocalDb-SqlServers.ps1]
function Find-LocalDb-Versions([switch] $PopulateInstances) {
  $parentKey = Get-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server Local DB\Installed Versions" -EA SilentlyContinue
  $candidates = @();
  if ($parentKey) {
    # Write-Host $parentKey.PSPath
    foreach($subName in $parentKey.GetSubKeyNames()) { 
      $parentInstance = Get-ItemProperty -Path "$($parentKey.PSPath)\$subName" -Name ParentInstance -EA SilentlyContinue | % {$_.ParentInstance}
      if ($parentInstance) {
        # Version value
        $versionKey1 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\$parentInstance\Setup"
        # CurrentVersion value
        $versionKey2 = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\$parentInstance\MSSQLServer\CurrentVersion"
        $version1 = Get-ItemProperty -Path "$versionKey1" -Name Version -EA SilentlyContinue | % {$_.Version}
        $version2 = Get-ItemProperty -Path "$versionKey2" -Name CurrentVersion -EA SilentlyContinue | % {$_.CurrentVersion}
        $version = $null;
        if ($version1) { $version = $version1 } 
        elseif ($version2) { $version = $version2 } 
      }
      $verInternal = $subName.Replace(".", "") # 16.0 --> 160
      $pathToolsKey = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server\$verInternal\Tools\ClientSetup"
      $pathTools = Get-ItemProperty -Path "$pathToolsKey" -Name Path -EA SilentlyContinue | % {$_.Path}
      if ($pathTools) { 
        $exe = "$pathTools\SQLLocalDB.exe".Replace("\\", "\")
        $localDbExe = $null;
        try { if (([System.IO.File]::Exists($exe))) { $localDbExe = $exe } } catch { }
      }

      $newItem = [pscustomobject] @{ 
        ShortVersion = $subName; 
        InstallerVersion = $version; 
        ParentInstance = $parentInstance; 
        Exe = $localDbExe;
      };
      # $newItem | Add-Member -MemberType ScriptMethod -Name "GetInstances" -Value { ParseNonEmptyTrimmedLines((& "$($this.Exe)" @("i") | Out-String)) }
      $candidates += $newItem
    }
  }
  $ret = @($candidates | ? { "$($_.ShortVersion)" -and "$($_.InstallerVersion)" -and "$($_.ParentInstance)" -and "$($_.Exe)" } | Sort-Object -Property ShortVersion -Descending);
  foreach($localDb in $ret) {
    if ($populateInstances) {
      # $instances = @($localDb.GetInstances());
      $instances = ParseNonEmptyTrimmedLines((& "$($localDb.Exe)" @("i") | Out-String))
      $localDb | Add-Member -MemberType NoteProperty -Name "Instances" -Value $instances;
    }
  }
  $ret
}

function Find-LocalDb-SqlServers() {
  $versions = @(Find-LocalDb-Versions -PopulateInstances);
  $instances = @()
  foreach($version in $versions) { foreach($i in $version.Instances) { $instances += $i; } }
  $instances = @($instances | Sort-Object | Get-Unique)
  # $instances = @(Find-LocalDb-Versions -PopulateInstances | Select -First 1 | % { $_.Instances })
  $instances = @($instances | ? { "$_".Length -gt 0 })
  foreach($instance in $instances) {
    [pscustomobject] @{ Instance = "(LocalDB)\$($instance)"}
  }
}

function Test-Show-LocalDb-Versions-with-Instances() {
  Write-Host "LOCALDB VERSIONS" -ForeGroundColor Magenta
  Find-LocalDb-Versions |
    ft -Property ShortVersion, InstallerVersion, Exe -AutoSize |
    Out-String -Width 1234 |
    Out-Host

  for($i=1; $i -le 2; $i++) {
    Write-Host "LOCALDB VERSIONS+INSTANCES MATRIX #$($i)" -ForeGroundColor Magenta
    Find-LocalDb-Versions -PopulateInstances |
      ft -Property ShortVersion, InstallerVersion, Instances, Exe -AutoSize |
      Out-String -Width 1234 |
      Out-Host
  }

  # Find-LocalDb-SqlServers -PopulateInstances | ft -Property ShortVersion, Version, Exe, Instances -AutoSize | Out-Host
  # $withInstances = Find-LocalDb-SqlServers | % { $_ | Add-Member -MemberType NoteProperty -Name "Instances" -Value $_.GetInstances(); $_ }
  # $withInstances | ft -Property ShortVersion, Version, Exe, Instances -AutoSize | Out-Host

  Write-Host "LOCALDB INSTANCES" -ForeGroundColor Magenta
  Find-LocalDb-SqlServers | ft -AutoSize | Out-String -Width 1234 | Out-Host
  
  Write-Host "LOCALDB INSTANCES with MediumVersion" -ForeGroundColor Magenta
  Find-LocalDb-SqlServers | Populate-Local-SqlServer-Version | ft -AutoSize | Out-String -Width 1234 | Out-Host
  
  $instances = @(Find-LocalDb-SqlServers)
  Write-Host "Total $($instances.Count) instance(s): $instances"
  foreach($instance in $instances) {
    $ver = Query-SqlServer-Version -Title "LocalDB `"$instance`"" -Instance "$($instance.Instance)" -Timeout 60
    Write-Line -TextYellow $instance.Instance -TextGreen " $ver"
  }
}

# Test-Show-LocalDb-Versions-with-Instances

# Include File: [\Includes.SqlServer\Find-Local-SqlServers.ps1]
# Super Fast
function Find-Local-SqlServers() {
  $candidates = @(@{RegPath="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MSSQLServer";Service="MSSQLSERVER";Instance="(local)";});
  $regNamebase = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft SQL Server"
  $namedKey = Get-Item -Path $regNamebase -EA SilentlyContinue
  if ($namedKey) {
    foreach($subName in $namedKey.GetSubKeyNames()) { $candidates += @{RegPath="$($regNamebase)\$subName";Service="MSSQL`$$($subName)"; Instance="(local)\$subName";}}
  }
  # $candidates | % { [pscustomObject] $_ } | ft -AutoSize | out-Host
  foreach($candidate in $candidates) { 
    $currentVersion = Get-ItemProperty -Path "$($candidate.RegPath)\MSSQLServer\CurrentVersion" -Name CurrentVersion -EA SilentlyContinue | % {$_.CurrentVersion}
    if ($currentVersion) { $candidate["InstallerVersion"] = $currentVersion; }

    $regService = Get-Item -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\$($candidate.Service)" -EA SilentlyContinue
    if ($regService) { $candidate["ServiceExists"] = $true; }
  }
  # Write-Host "FINAL" -ForegroundColor DarkGreen
  # $candidates | % { [pscustomObject] $_ } | ft -AutoSize | out-Host
  $candidates | 
     ? { $_.ServiceExists } | 
     % { $_.Remove("ServiceExists"); $_.Remove("RegPath"); $_; } |
     % { [PSCustomObject] $_ }
}

# pipe only
function Populate-Local-SqlServer-Version($timeout = 60) {
  foreach($sqlServer in $input) {
    $mediumVersion = Query-SqlServer-Version -Title "$($sqlServer.Instance) v$($sqlServer.InstallerVersion)" -Instance "$($sqlServer.Instance)" -Timeout $timeout;
    $__ = Set-Property-Smarty $sqlServer "Version" $mediumVersion
    $sqlServer
  }
}

function Test-Find-Local-SqlServers() {
  
  Write-Host "Find-Local-SqlServers as is" -ForeGroundColor Magenta
  Find-Local-SqlServers | 
    ft -AutoSize | 
    Out-String -Width 1234 | 
    Out-Host

  # Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | ft -AutoSize
  Write-Host "Find-Local-SqlServers --> Windows Services" -ForeGroundColor Magenta
  Find-Local-SqlServers | 
    % { Get-Service -Name $_.Service } | 
    ft -AutoSize | 
    Out-String -Width 1234 | 
    Out-Host

  Write-Host "STOP SERVICES" -ForeGroundColor Magenta
  # Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | % { if ($_.Status -ne "Stopped") { Write-Host "Stopping $($_.Name)"; Stop-Service "$($_.Name)" -Force }}
  Find-Local-SqlServers | 
    % { $_.Service } | 
    % { Get-Service -Name $_ } | 
    ? { $_.Status -ne "Stopped" } |
    % { Write-Host "Stopping $($_.Name)"; Stop-Service "$($_.Name)" -Force }

  Write-Host "START SERVICES" -ForeGroundColor Magenta
  # Get-Service -Name (Find-Local-SqlServers | % {$_.Service}) | % { if ($_.Status -ne "Running") { Write-Host "Starting $($_.Name)"; Start-Service "$($_.Name)" }}
  Find-Local-SqlServers | 
    % { $_.Service } | 
    % { Get-Service -Name $_ } | 
    ? { $_.Status -ne "Running" } |
    % { Write-Host "Starting $($_.Name)"; Start-Service "$($_.Name)" }

  Write-Host "Find-Local-SqlServers | Populate-Local-SqlServer-Version" -ForeGroundColor Magenta
  Find-Local-SqlServers | 
    Populate-Local-SqlServer-Version |
    ft -AutoSize | 
    Out-String -Width 1234 | 
    Out-Host

}

# Test-Find-Local-SqlServers

# Include File: [\Includes.SqlServer\Find-SQLServer-Meta.ps1]
function Find-SQLServer-Meta([string] $version, [string] $mediaType) {
  $ret = @{ Version = $version; MediaType = $mediaType; }

  $missingParticular = $null -ne ($SqlServerAlreadyUpdatedList | where { $_.Version -eq $version -and $_.MediaType -eq $mediaType});
  $isMissingUpdates = $missingParticular -or ($mediaType -eq "LocalDB");

  foreach($meta in $SqlServerDownloadLinks) {
    if ($meta.Version -eq $version) {
      # In case of via manager
      # $url = IIf ($mediaType -eq "Developer") $meta.BaseDev $meta.BaseExpress
      $url = $meta["$mediaType"]
      $ret["Url"] = $url;
      if (-not $isMissingUpdates) { $ret["CU"] = $meta.CU; }
      return $ret;
    }
  }

  foreach($meta in $SqlServer2010DownloadLinks) {
    if ($meta.Version -eq $version) {
      $url = $meta[$mediaType];
      if ("$url") { 
        $ret["Url"] = $url;
        if (-not $isMissingUpdates) { $ret["CU"] = $meta.CU; }
        return $ret;
      }
    }
  }
}

# Include File: [\Includes.SqlServer\Find-SqlServer-SetupLogs.ps1]
function Find-SqlServer-SetupLogs() {
  $sysDrive = "$($ENV:SystemDrive)"
  $folders = @("$sysDrive\Program Files", "$sysDrive\Program Files (x86)", "C:\Program Files", "C:\Program Files (x86)", "$($Env:ProgramFiles)", "${Env:ProgramFiles(x86)}")
  $folders = ($folders | sort | Get-Unique)
  $ret=@()
  foreach($folder in $folders) {
    $sqlFolder=[System.IO.Path]::Combine($folder, "Microsoft SQL Server");
    if ([System.IO.Directory]::Exists($sqlFolder)) {
    	$subDirs = Get-ChildItem -Path $sqlFolder -Directory -Force -ErrorAction SilentlyContinue
    	foreach($subDir in $subDirs) {
    	  $ver=$subDir.Name
    	  $verSubFolder=$subDir.FullName
    	  $logFolder=[System.IO.Path]::Combine($verSubFolder, "Setup Bootstrap\LOG");
    	  if ([System.IO.Directory]::Exists($logFolder)) {
    	    $ret += [System.IO.Path]::GetFullPath($logFolder)
    	  }
    	}
    }
  }
  $ret = $ret | sort | Get-Unique
  # "C:\Program Files (x86)\Microsoft SQL Server\90\Setup Bootstrap\LOG"
  # "C:\Program Files\Microsoft SQL Server\150\Setup Bootstrap\Log"
  $ret
}

# (Find-SqlServer-SetupLogs).Length; Find-SqlServer-SetupLogs


# Include File: [\Includes.SqlServer\Get-Builtin-Windows-Group-Name.ps1]
# Windows Only
function Get-Builtin-Windows-Group-Name([string] $groupKind) {
   if ((Get-Os-Platform) -ne "Windows") { return }
   $sid="";
   #users: S-1-5-32-545, administrators: S-1-5-32-544, power users: S-1-5-32-547
   if     ($groupKind -eq "Users")          { $sid="S-1-5-32-545"; }
   elseif ($groupKind -eq "Administrators") { $sid="S-1-5-32-544"; }
   elseif ($groupKind -eq "PowerUsers")     { $sid="S-1-5-32-547"; }
   $ret=""
   if ($sid) {
     $group = Select-WMI-Objects "Win32_Group";
     $ret = ($group | where { $_.SID -eq "$sid" } | Select -First 1).Name;
   }
   return $ret;
}
# @("Administrators", "PowerUsers", "Users") | % { "$($_): '$(Get-Builtin-Windows-Group-Name $_)'" }
# Get-WmiObject Win32_Group | ft *
# Include File: [\Includes.SqlServer\Get-SqlServer-Downloads-Folder.ps1]
function Get-SqlServer-Setup-Folder() {
  return (GetPersistentTempFolder "SQLSERVERS_SETUP_FOLDER" "SQL-Setup");
}

function Get-SqlServer-Media-Folder() {
  return (GetPersistentTempFolder "SQLSERVERS_MEDIA_FOLDER" "SQL Media");
}

# Include File: [\Includes.SqlServer\Install-SQLServer.ps1]
<# 

META
----
LauncherSize   133032                                                                                                                          
SetupHash      2D975BB24E872383C63D676105DFAF548972FA82970A8DB0AAC4E161555C8411466850F1442DDD988542FDB1B2205C08C1A8A97EEB9F1DD3AF7B49BFB80D7A21
SetupSize      1349103806                                                                                                                      
Version        2022                                                                                                                            
MediaType      Developer                                                                                                                       
Setup          C:\Users\VSSADM~1\AppData\Local\Temp\PS1 Repo Downloads\SQL-2022-Developer                                                 
Launcher       C:\Users\VSSADM~1\AppData\Local\Temp\PS1 Repo Downloads\SQL-2022-Developer\Setup.exe                                       
MediaSize      1233861846                                                                                                                      
MediaHash      70DF481879338B608231D7FD0F518642CFAF481708E2EA6343DC217C56D5AF7182008EDB8CDF4D96652D44BD7A4B7FA6F3CD1CBAF7A8E3771760B169390F46F4
Media          C:\Users\VSSADM~1\AppData\Local\Temp\PS1 Repo Downloads\SQL-Setup-Compressed\SQL-2022-Developer                         

UPDATE
------
UpdateFolder   C:\Users\VSSADM~1\AppData\Local\Temp\PS1 Repo Downloads\SQL-2022-CU14                                        
Url            https://download.microsoft.com/download/9/6/8/96819b0c-c8fb-4b44-91b5-c97015bbda9f/SQLServer2022-KB5038325-x64.exe
UpdateSize     463846640                                                                                                         
UpdateId       CU14                                                                                                              
UpdateLauncher C:\Users\VSSADM~1\AppData\Local\Temp\PS1 Repo Downloads\SQL-2022-CU14\SQLServer2022-KB5038325-x64.exe        

#>

function Install-SQLServer {
  Param(
    [object] $meta,
    [object] $update, # optional nullable, 
    [string] $instanceName,
    [string[]] $optionsOverride = @()
  )

  # check if sql server server already installed
  if ($meta.MediaType -ne "LocalDB") {
    $localSqlServers = @(Find-Local-SqlServers)
    $localSqlServer = $localSqlServers | ? {
      if ($instanceName -eq "MSSQLSERVER" -and $_.Instance -eq "(local)") { return $true; }
      if ("(local)\$($instanceName)" -eq $_.Instance) { return $true; }
    } | Select -First 1;
    if ($localSqlServer) {
      Write-Host "SQL Server $($instanceName) already installed. Its Installer version is $($localSqlServer.InstallerVersion). Skipping.";
      return;
    }
  }

  if (-not $meta.LauncherSize) {
    $err="[Install-SQLServer] Invalid `$meta argument. Probably download failed";
    Write-Host $err;
    $meta | Format-Table-Smarty
    return @{ Error=$err; }
  }

  if ($meta.MediaType -eq "LocalDB") {
     Write-Host "Installing LocalDB MSI `"$($meta.Launcher)`" Version $($meta.Version)"
     $logDir = if ("$($ENV:SYSTEM_ARTIFACTSDIRECTORY)") { "$($ENV:SYSTEM_ARTIFACTSDIRECTORY)" } else { "$($ENV:TEMP)" }
     $setupCommandLine = @("/c", "msiexec.exe", "/i", "`"$($meta.Launcher)`"", "IACCEPTSQLLOCALDBLICENSETERMS=YES", "/qn", "/L*v", "SqlLocalDB-Setup-$($meta.Version).log");
     $setupStatus = Execute-Process-Smarty "SQL LocalDB $($meta.Version) Setup" "cmd.exe" $setupCommandLine -WaitTimeout 1800
     $setupStatus | Format-Table-Smarty | Out-Host
     return $setupStatus;
  }

  if ($update) {
    $isUpdateValid = ("$($update.UpdateSize)" -and "$($update.UpdateFolder)" -and "$($update.UpdateLauncher)")
    if (-not $isUpdateValid) {
      $err="[Install-SQLServer] Invalid `$update argument. Probably download failed";
      Write-Host $err;
      $update | Format-Table-Smarty | Out-Host
      return @{ Error = $err };
    }
  }

  $sqlAdministratorsGroup = Get-Builtin-Windows-Group-Name "Administrators";
  if (-not $sqlAdministratorsGroup) { $sqlAdministratorsGroup = "Administrators"; }
  $sqlAdministratorsGroup = "BUILTIN\$($sqlAdministratorsGroup)";

  $defaultOptions = @{
    InstallTo = Combine-Path "$(Get-System-Drive)" "SQL";
    Password = "Meaga`$tr0ng";
    Tcp = 1;
    NamedPipe = 1;
    SysAdmins = "$sqlAdministratorsGroup";
    Features = "SQLENGINE,FullText";
    Collation = ""; # Depends on System Language, todo: SQL_Latin1_General_CP1_CI_AS or SQL_Latin1_General_CP1_CI_AS
    DbDir = "";         #
    DbLogDir = "";      #
    TempDbDir = "";     # Using /Slash optional overrides
    TempDbLogDir = ""   #
    BackupDir = "";     #
    Startup = "Automatic"; # Manual | Disabled
  }
  $options = $defaultOptions.Clone();
  # Apply $args
  $extraArguments=@();
  foreach($a in $optionsOverride) {
    try { $p="$a".IndexOf("="); $k="$a".SubString(0,$p); if (($p+1) -eq "$a".Length) { $v=""; } else { $v="$a".SubString($p+1); }} catch { $k=""; $v=""; }
    $v = "$v" -replace "{InstanceName}", $instanceName;
    if ("$k" -ne "" -and (-not "$k".StartsWith("/")) ) { 
      $options[$k] = $v; 
      Write-Host "Overridden option '$k' = `"$v`""; 
    } elseif ("$k" -ne "" -and "$k".StartsWith("/") ) { 
      $extraArguments += "$($k)=`"$v`""
      Write-Host "Overridden extra argument '$k' = `"$v`""; 
    }

  }

  $major = ($meta.Version.Substring(0,4)) -as [int];
  $is2020 = $major -ge 2016;
  $setupArg=@();
  $title = "SQL Server $($meta.Version) $($meta.MediaType) Setup"
  if ($major -eq 2005) {
    # SQL_Engine,SQL_Data_Files,SQL_Replication,SQL_FullText,SQL_SharedTools
    $argFeatures = IIf ($meta.MediaType -eq "Core") "SQL_Engine" "SQL_Engine,SQL_FullText";
    $argSQLAUTOSTART = IIf ($options.Startup -eq "Automatic") "1" "0"
    # /qb for unattended with basic UI
    
    $setupArg = "/qn", "ADDLOCAL=$argFeatures", "INSTANCENAME=`"$instanceName`"", 
         "DISABLENETWORKPROTOCOLS=0", # 0: All, 1: None, 2: TCP only
         "SECURITYMODE=SQL", "SAPWD=`"$($options.Password)`"", 
         "INSTALLSQLDIR=`"$($options.InstallTo)`"",
         "SQLAUTOSTART=$argSQLAUTOSTART";

    $setupStatus = Execute-Process-Smarty "SQL Server $($meta.Version) $($meta.MediaType) Setup" $meta.Launcher $setupArg -WaitTimeout 3600
    $setupStatus | Format-Table-Smarty | Out-Host
    $err=$setupStatus.Error;

    # Exec Patch
    if ($update) {
      $title = "SQL Server $($meta.Version) Upgrade to $($update.UpdateId)"
      $updateCommandLine = @("/QUIET", "/Action=Patch", "/InstanceName=$instanceName");
      $upgradeResult = Execute-Process-Smarty "$title" $update.UpdateLauncher $updateCommandLine
      $upgradeResult | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
      if ($upgradeResult.Error) { $err += " " + $upgradeResult.Error; }
    }

    if ($err) { return @{ Error = $err }; }

    # Write-Host "Workaround for 2005 logs"; sleep 1; & taskkill.exe @("/t", "/f", "/im", "setup.exe");
  } else {
<# 2008
"%AppData%\Temp\%KEY%\Setup\Setup.exe" /Q /INDICATEPROGRESS /Action=Install ^
  /ADDCURRENTUSERASSQLADMIN ^
  /FEATURES=SQL ^
  /INSTANCENAME=%NEW_SQL_INSTANCE_NAME% ^
  /SECURITYMODE=SQL /SAPWD=`1qazxsw2 ^
  /SQLSVCACCOUNT="NT AUTHORITY\SYSTEM" ^
  /INSTANCEDIR="%SystemDrive%\SQL" ^
  /INSTALLSHAREDDIR="%SystemDrive%\SQL\x64b" ^
  /INSTALLSHAREDWOWDIR="%SystemDrive%\SQL\x86b" ^
  /SQLSYSADMINACCOUNTS="BUILTIN\ADMINISTRATORS" ^
  /TCPENABLED=1 /NPENABLED=1
 
#>
    $argFeatures = IIf ($meta.MediaType -eq "Advanced") "SQL_Engine,SQL_FullText" "SQL_Engine";
    $argQuiet = IIf (((Is-BuildServer) -or (Is-SshClient)) -or $meta.Version -like "2005*" -or $meta.Version -like "2008-*") "/Q" "/QUIETSIMPLE";
    $argProgress = "/INDICATEPROGRESS";
    $argProgress = "";
    $argADDCURRENTUSERASSQLADMIN = IIf ($meta.MediaType -eq "Developer") "" "/ADDCURRENTUSERASSQLADMIN";
    # 2008 and R2: The setting 'IACCEPTROPENLICENSETERMS' specified is not recognized.
    $argIACCEPTROPENLICENSETERMS = IIF ($major -le 2014) "" "/IACCEPTROPENLICENSETERMS";
    
    # 2008 & 2008 R2 Dev 10.50.6000.34: /AGTSVCACCOUNT="NT AUTHORITY\SYSTEM" required on Windows 2016+
    $argAGTSVCACCOUNT = IIF (($meta.Version -like "2008*") -and $meta.MediaType -eq "Developer") "/AGTSVCACCOUNT=`"NT AUTHORITY\SYSTEM`"" "";
    
    # 2008-xXX features
    $argFeatures = "$($options.Features)"
    if ($meta.Version -match "2008-") { 
      # For Developer use command line "Features=..."
      If ($meta.MediaType -eq "Core") { $argFeatures = "SQLENGINE" } 
      If ($meta.MediaType -eq "Advanced") { $argFeatures = "SQLENGINE,FULLTEXT" } 
    }

    $argENU = IIf ($meta.Version -match "2008-") "" "/ENU"
    $argIACCEPTSQLSERVERLICENSETERMS = IIf ($meta.Version -match "2008-") "" "/IAcceptSQLServerLicenseTerms"

    $hasUpdateSourceArgument = ($major -ge 2012);
    $argUpdateEnabled = IIF ([bool]"$update" -and $hasUpdateSourceArgument) "/UpdateEnabled=True" ""
    $argUpdateSource = If ("$update" -and $hasUpdateSourceArgument) { "/UpdateSource=`"$($update.UpdateFolder)`"" } else { "" };

    $argSQLCOLLATION = IIF ([bool]$options.Collation) "/SQLCOLLATION=`"$($options.Collation)`"" ""
    $argSQLSVCSTARTUPTYPE = IIF ([bool]$options.Startup) "/SQLSVCSTARTUPTYPE=`"$($options.Startup)`"" ""

    $argX86 = IIf ($meta.Version -match "2008-x86" -and $meta.MediaType -eq "Developer" -and (Get-CPU-Architecture-Suffix-for-Windows) -eq "x64") "/X86" "";

    # AddCurrentUserAsSQLAdmin can be used only by Express SKU or set using ROLE.
    $setupArg = "$argQuiet", "$argENU", "$argProgress", "/ACTION=Install",
    "/INSTANCENAME=`"$instanceName`"", 
    "$argX86",
    "/FEATURES=`"$argFeatures`"", 
    "$argIACCEPTSQLSERVERLICENSETERMS", "$argIACCEPTROPENLICENSETERMS", 
    "$argUpdateEnabled", "$argUpdateSource",
    "$argSQLCOLLATION",
    "/INSTANCEDIR=`"$($options.InstallTo)`"", 
    "/SECURITYMODE=`"SQL`"", 
    "/SAPWD=`"$($options.Password)`"", 
    "/SQLSVCACCOUNT=`"NT AUTHORITY\SYSTEM`"", "$argAGTSVCACCOUNT",
    "$argSQLSVCSTARTUPTYPE", 
    "/BROWSERSVCSTARTUPTYPE=AUTOMATIC",
    "$argADDCURRENTUSERASSQLADMIN", 
    "/SQLSYSADMINACCOUNTS=`"$($sqlAdministratorsGroup)`"",
    "/TCPENABLED=$($options.Tcp)", "/NPENABLED=$($options.NamedPipe)";

    # TODO: Remove Existing
    $setupArg += @($extraArguments)

    # Perform Setup, plus upgrade if 2012+
    $setupStatus = Execute-Process-Smarty "$title" $meta.Launcher $setupArg -WaitTimeout 3600
    $setupStatus | Format-Table-Smarty | Out-Host
    
    $err = $setupStatus.Error;

    if ("$update" -and (-not $hasUpdateSourceArgument)) {
      $title = "SQL Server $($meta.Version) Upgrade to $($update.UpdateId)"
      if ($meta.Version -like "2008R2*") { 
        Say "Starting $title"
        $updateCommandLine = @("/QUIET", "/IAcceptSQLServerLicenseTerms", "/Action=Patch", "/InstanceName=$instanceName"); # SP3 ok
        $upgradeResult = Execute-Process-Smarty "$title" $update.UpdateLauncher $updateCommandLine
        $upgradeResult | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
      }
      else {
        # OK on "2008"
        Say "Starting $title"
        $updateCommandLine = @("/QUIET", "/Action=Patch", "/InstanceName=$instanceName");
        $upgradeResult = Execute-Process-Smarty "$title" $update.UpdateLauncher $updateCommandLine
        $upgradeResult | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
      }

      if ($upgradeResult -and $upgradeResult.Error) { $err += " " + $upgradeResult.Error; }
      if ($err) { return @{ Error = $err }; }
    }
  }
}

# Include File: [\Includes.SqlServer\Invoke-LocalDB-Executable.ps1]
# Version: Latest | 16 | 15 | 14 | 13 | 12 | 11 (16.0, 15.0, ... also supported)
# If Version is "Latest" or $version is not installed then Latest cli is used
function Invoke-LocalDB-Executable([string] $title, [string] $version, [string[]] $parameters) {
  $localDbList = Find-LocalDb-Versions
  $exe = $localDbList | Select -First 1 | % { $_.Exe }
  if ($version) { 
    $exe2 = $localDbList | ? { $_.ShortVersion -like "$version*" } | Select -First 1 | % { $_.Exe }
    if ($exe2) { $exe = $exe2 }
  }
  if ($exe) {
    $pars = @($parameters);
    $pars += @($args);
    Troubleshoot-Info "[$title] `"$exe`" $($pars -join " ")"
    & "$exe" @($pars) | Out-Host
    return $?
  } else {
    Write-Line -TextDarkRed "SQLLocalDB.Exe Not Found for version `"$version`" or any version is missing"
  }
  return $false
}

function Stop-LocalDB-Instance([string] $title, [string] $version, [string] $instance, [switch] $noWait) {
  if (-not $title) { $title = "LocalDB Instance '$instance'" }
  $p = @("stop", "`"$instance`"");
  if ($noWait) { $p += "-i" }
  $__ = Invoke-LocalDB-Executable -Title $title -Version $version -Parameters $p
}

# Stop-LocalDB-Instance -Instance "MSSQLLocalDB" -NoWait

# Include File: [\Includes.SqlServer\Invoke-SqlServer-Command.ps1]
function Invoke-SqlServer-Command([string] $title, [string] $connectionString, <# or #>[string] $instance, [string] $sqlCommand, [int] $timeoutSec = 30) {
  if (-not $connectionString) { $connectionString = "Server=$($instance);Integrated Security=SSPI;Connection Timeout=10;Pooling=False" }
  $startAt = [System.Diagnostics.Stopwatch]::StartNew();
  $exception = $null;

  try { 
    $con = New-Object System.Data.SqlClient.SqlConnection($connectionString);
    $con.Open();
    
    $cmd = new-object System.Data.SqlClient.SqlCommand($sqlCommand, $con)
    $cmd.CommandTimeout = $timeoutSec * 1000;
    $__ = $cmd.ExecuteNonQuery();
    $cmd.Dispose();

    $con.Close()
    return;
  } catch { $exception = $_.Exception; <# Write-Host $_.Exception -ForegroundColor DarkGray #> }

  Write-Host "Warning! Can't invoke SQL Command on SQL Server '$($title)' during $($startAt.ElapsedMilliseconds / 1000) seconds$([Environment]::NewLine)$($exception)" -ForegroundColor DarkRed
}

# Invoke-SqlServer-Command -Title "MSSQLSERVER" -Instance "(local)" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 160; "max server memory (MB)" = 4096 }

# Include File: [\Includes.SqlServer\Is-SqlServer-Setup-Cache-Enabled.ps1]
function Is-SqlServer-Setup-Cache-Enabled() { $false; }
# Include File: [\Includes.SqlServer\ParseNonEmptyTrimmedLines.ps1]
# return array of strings
function ParseNonEmptyTrimmedLines([string] $raw) {
  foreach($line in "$raw".Split([char] 13, [char] 10)) {
    $l = "$line".Trim()
    if ($l.Length -gt 0) { $l }
  }
}
# ParseNonEmptyTrimmedLines "`r`n1`r2`n3`r`n`r`n"

# Include File: [\Includes.SqlServer\Parse-SqlServers-Input.ps1]
function Parse-SqlServers-Input { param( [string] $list)
    # Say "Installing SQL Server(s) by tags: $list"
    $rawServerList = "$list".Replace("`r"," ").Replace("`n"," ").Split(@([char]44, [char]59));
    foreach($sqlDef in $rawServerList) {
        $arr = $sqlDef.Split(@([char]58));
        $sqlKey = "$($arr[0])".Trim();
        if ($arr.Length -gt 1) { $instanceName=$arr[1].Trim(); } else {  $instanceName=$null; }
        $tags=@("$sqlKey".Split([char]32) | % {$_.Trim()} | where { $_.Length -gt 0 } )
        if ($tags.Count -gt 0) {
            $version = "$($tags[0])";
            try { $major = $version.Substring(0,4) -as [int] } catch {}
            $versionHasBits = ($version -like "*-x86" -or $version -like "*-x64")
            if ((-not $versionHasBits) -and ($major -le 2014)) { 
              $version += IIF ($major -eq 2005) "-x86" "-$(Get-CPU-Architecture-Suffix-for-Windows)"; 
            }
            $missingDeveloper = ($version -like "2005*" -or $version -like "2014-x86" -or $version -like "2008-*");
            $mediaType = IIF ($tags.Count -ge 2) $tags[1] (IIF $missingDeveloper "Advanced" "Developer")
            $rawUpdate = IIF ($tags.Count -ge 3) $tags[2] ""

            if ($instanceName -eq $null -and $mediaType -ne "LocalDB") {
              $instanceName = $mediaType.Substring(0,3).ToUpper() + "_" + $version.Replace("-", "_");
            }
            if ($instanceName -ne $null) {
              $instanceName = "$($instanceName.ToUpper())"
            }

            $normalizedMeta = Find-SQLServer-Meta $version $mediaType
            if (-not $normalizedMeta) {
              Write-Warning "Unknwon SQL Server version $version mediatype $mediaType" 
            }
            else {
              # Version and MediaType are clarified. 
              # First (latest) update if not found
              if ($rawUpdate) {
                $update = $normalizedMeta.CU | ? { $_.Id -eq $rawUpdate } | Select -First 1;
                if (-not $update) { $update = $normalizedMeta.CU | Select -First 1; }
                $updateId = IIF ([bool]"$update") $update.Id $null;
              } else {
                $updateId = $null;
                $update = $null;
              }

              @{Version = $version; MediaType = $mediaType; UpdateId = "$updateId"; Update = $update; InstanceName = $instanceName; Definition=$sqlKey }
            }
        }
    }
}
<#
  2014 --> 2014-x64 Developer on x64, 
#>
# Include File: [\Includes.SqlServer\Publish-SQLServer-SetupLogs.ps1]
function Publish-SQLServer-SetupLogs([string] $toFolder, $compression=9) {
  if ((Get-Os-Platform) -ne "Windows") { Write-Host "Publish-SQLServer-SetupLogs() function is Windows only. Skipping."; return; }
  if ("$toFolder" -ne "") { New-Item -ItemType Directory -Path "$toFolder" -EA SilentlyContinue | out-null; }
  $folders = Find-SqlServer-SetupLogs
  $sevenZip = Get-Full7z-Exe-FullPath-for-Windows -Version "1900"
  foreach($logsFolder in $folders) {
    $archiveName=$logsFolder.Substring([System.IO.Path]::GetPathRoot($logsFolder).Length).Replace("\", ([char]8594).ToString())
    Say "Pack '$logsFolder' as `"$toFolder\$archiveName.7z`""
    $commandLine = @("a", "-y", "-mx=$compression", "-ms=on", "-mqs=on", "$toFolder\$archiveName.7z", "$logsFolder\*")
    $singleCore7z=@(); $memInfo = Get-Memory-Info; $procCount = ([Environment]::ProcessorCount); if ($memInfo -and ($memInfo.Free) -and ($memInfo.Free -lt (640*$procCount))) { $singleCore7z=@("-mmt=1") }
    $commandLine += $singleCore7z
    & "$sevenZip" $commandLine | out-null
    if (-not $?) {
      Write-Host "Failed publishing '$archiveName' to folder '$toFolder'" -ForegroundColor DarkRed
      # return $false;
    }
    # return $true;
  }
}

# Include File: [\Includes.SqlServer\Query-SqlServer-Version.ps1]
function Query-SqlServer-Version([string] $title, [string] $connectionString, <# or #>[string] $instance, [int] $timeoutSec = 30) {
  if (-not $connectionString) { $connectionString = "Server=$($instance);Integrated Security=SSPI;Connection Timeout=3;Pooling=False" }
  $startAt = [System.Diagnostics.Stopwatch]::StartNew();
  $exception = $null;
  do {
    try { 
      $sql = @"
SELECT
Cast(ISNULL(ServerProperty('ProductVersion'), '') as nvarchar(222)) + ' ' + 
(Case ServerProperty('IsLocalDB') When 1 Then 'LocalDB' Else '' End) + ' ' + 
Cast(ISNULL(ServerProperty('Edition'), '') as nvarchar(222)) + ' ' + 
Cast(ISNULL(ServerProperty('ProductLevel'), '') as nvarchar(222)) + ' ' + 
Cast(ISNULL(ServerProperty('ProductUpdateLevel'), '') as nvarchar(222)) + 
(Case ServerProperty('IsFullTextInstalled') When 1 Then ' + Full-text' Else '' End);
"@;
      $con = New-Object System.Data.SqlClient.SqlConnection($connectionString);
      $con.Open();
      $cmd = new-object System.Data.SqlClient.SqlCommand($sql, $con)
      $cmd.CommandTimeout = 3;
      $rdr = $cmd.ExecuteReader()
      $__ = $rdr.Read()
      $ret = "$($rdr.GetString(0))"
      $ret = $ret.Trim().Replace("  ", " ").Replace("  ", " ").Replace("  ", " ")
      $con.Close()
      return $ret;
    } catch { $exception = $_.Exception; <# Write-Host $_.Exception -ForegroundColor DarkGray #> }
  } while($startAt.ElapsedMilliseconds -le ($timeoutSec * 1000));
  Write-Host "Warning! Can't query version of SQL Server '$($title)' during $($startAt.ElapsedMilliseconds / 1000) seconds$([Environment]::NewLine)$($exception)" -ForegroundColor DarkRed

}

# Query-SqlServer-Version -Title "FAKE" -Instance "(local)\22" -Timeout 2
# Query-SqlServer-Version -Title "SQL 2005" -Instance "(local)\SQL_2005_SP4_X86" -Timeout 2

# Include File: [\Includes.SqlServer\Set-SqlServer-Database-Files-Size.ps1]
# TODO:
function Set-SqlServer-Database-Files-Size([string] $title, [string] $connectionString, <# or #>[string] $instance, [string] $dbName, [string] $dataSize, [string] $dataGrow, [string] $logSize, [string] $logGrow, $timeout = 30)
{
  $sql = @"
Declare @type tinyint; Declare @name sysname; Declare @sql nvarchar(4000);
Declare @newSize varchar(1000); Declare @newGrow varchar(1000);
DECLARE FilesCursor Cursor Static FOR SELECT type, name FROM [$dbName].sys.database_files Where type in (0,1);
Open FilesCursor 
While 1=1
Begin
  Fetch Next From FilesCursor Into @type, @name;
  If @@FETCH_STATUS <> 0 Break;
  If @type = 0 Set @newSize = '$dataSize' Else Set @newGrow = '$dataGrow';
  If @type = 1 Set @newSize = '$logSize'  Else Set @newGrow = '$logGrow';
  Set @sql = 'ALTER DATABASE [$dbName] MODIFY FILE ( NAME = N''' + @name + ''', SIZE = ' + @newSize + ', FILEGROWTH = ' + @newGrow + ' );';
  -- Print @sql;
  exec (@sql);
End
Close FilesCursor;
Deallocate FilesCursor;
"@;

}

<#
USE [master]
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 23552KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'templog', SIZE = 9216KB , FILEGROWTH = 131072KB )
GO


USE [master]
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp3', FILEGROWTH = 11%)
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp6', FILEGROWTH = 12%)
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'temp8', FILEGROWTH = 131072KB )
GO
ALTER DATABASE [tempdb] MODIFY FILE ( NAME = N'tempdev', SIZE = 716800KB )
GO
#>

# Include File: [\Includes.SqlServer\Set-SQLServer-Options.ps1]
function Set-SQLServer-Options([string] $title, [string] $connectionString, <# or #>[string] $instance, [hashtable] $options, [int] $timeoutSec = 30) {
  if (-not $connectionString) { $connectionString = "Server=$($instance);Integrated Security=SSPI;Connection Timeout=10;Pooling=False" }
  $startAt = [System.Diagnostics.Stopwatch]::StartNew();
  $exception = $null;
  $keys = @($options | % { $_.Keys })
  $sqlCommands = @("exec sp_configure 'show advanced option', 1", "reconfigure with override;");
  foreach($key in $keys) { 
    $val = $options[$key];
    if ($val -is [bool]) { if ($val) { $val = 1 } else { $val = 0 } }
    $sqlCommands += "exec sp_configure '$key', $val"
  }
  $sqlCommands += "reconfigure with override;";

  do {
    try { 
      $con = New-Object System.Data.SqlClient.SqlConnection($connectionString);
      $con.Open();
      
      Write-Host "Connection to SQL Server $title is Ready for Configuration"
      foreach($sqlCommand in $sqlCommands) {
        $cmd = new-object System.Data.SqlClient.SqlCommand($sqlCommand, $con)
        $cmd.CommandTimeout = 30;
        try { 
          $__ = $cmd.ExecuteNonQuery();
          Write-Host "    ok: `"$sqlCommand`""
        } catch {
          Write-Host "  fail: `"$sqlCommand`". $($_.Exception.Message)"
        }
        $cmd.Dispose();
      }
      $con.Close()
      return;
    } catch { $exception = $_.Exception; <# Write-Host $_.Exception -ForegroundColor DarkGray #> }
  } while($startAt.ElapsedMilliseconds -le ($timeoutSec * 1000));
  Write-Host "Warning! Can't apply configuration for SQL Server '$($title)' during $($startAt.ElapsedMilliseconds / 1000) seconds$([Environment]::NewLine)$($exception)" -ForegroundColor DarkRed
}

# Set-SQLServer-Options -Title "MSSQLSERVER" -Instance "(local)" -Options @{ xp_cmdshell = $true; "clr enabled" = $false; "server trigger recursion" = $true; "min server memory (MB)" = 160; "max server memory (MB)" = 4096 }

# Include File: [\Includes.SqlServer\Setup-SqlServers.ps1]
function Setup-SqlServers() {
<#
.SYNOPSIS
SQL Server Setup and Management including Developer, Express, and LocalDB editions.
The intended use of this project is for Continuous Integration (CI) scenarios, where:
     1) A SQL Server or LocalDB needs to be installed without user interaction.
     2) A SQL Server or LocalDB installation doesn't need to persist across multiple CI runs.

By default it installs SQL Engine and full text search, 
adds current user to SQL Server Administrators, 
and turns on TCP/IP and Named Pipe protocols. Default sa password is 'Meaga$trong'.


.OUTPUTS
Returns array of errors, if occured on installation

.EXAMPLE
Setup-SqlServers "2022 Developer Updated: MSSQLSERVER, 2019 Advanced: ADV2019, 2017 Core Updated: CORE2017, 2016 Developer: DEV2016"
Command above installs
  SQL Server 2022 Developer Edition as default instance,
  SQL Server 2019 Express Edition RTM with Advanced Services as ADV2019 instance,
  SQL Server 2017 Express Edition 2017 as CORE2017 instance,
  and SQL Server 2016 Developer Edition as DEV2016 instance

Options:

#>
Param(
  [string] $sqlServers,
  [string[]] $optionsOverride = @()
)

   $optionsOverride += @($args)

   # Normilize input parameter $sqlServers
   $sqlServers = "$sqlServers".Replace("`r"," ").Replace("`n"," ").Trim();
   while($sqlServers.IndexOf("  ") -ge 0) { $sqlServers = $sqlServers.Replace("  "," ") }
   # lets rock
   Say "Setting up SQL Server(s) `"$sqlServers`".$([Environment]::NewLine)Cpu is '$(Get-Cpu-Name)'. $((Get-Memory-Info).Description)"
   $errors = @();

   $servers = Parse-SqlServers-Input $sqlServers
   $servers | % { [pscustomobject] $_ } | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
   $jsonReport = @();
   foreach($server in $servers) {
     $startAt = [System.Diagnostics.Stopwatch]::StartNew()
     Say "Downloading SQL Server '$($server.Version) $($server.MediaType)'"
     $setupMeta = Download-SQLServer-and-Extract $server.Version $server.MediaType;
     $setupMeta | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
     $resultGetUpdate = $null;
     if ($server.UpdateId) {
       Say "Downloading SQL Server Update $($server.UpdateId) for version '$($server.Version) $($server.MediaType)'"
       $resultGetUpdate = Download-SqlServer-Update $server.Version $server.MediaType $server.Update;
       $resultGetUpdate | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
     }
     $secondsDownload = $startAt.ElapsedMilliseconds / 1000.0;
     $startAt = [System.Diagnostics.Stopwatch]::StartNew()
     Say "Installing $($server.Version) $($server.MediaType)"
     $installStatus = Install-SQLServer $setupMeta $resultGetUpdate $server.InstanceName @($optionsOverride);
     Say "SQL Server '$($server.Definition)' Setup Finished. $((Get-Memory-Info).Description)"
     $secondsInstall = $startAt.ElapsedMilliseconds / 1000.0;
     $jsonReport += @{ Definition=$server.Definition; Version=$server.Version; MediaType=$server.MediaType; SecondsDownload = $secondsDownload; SecondsInstall = $secondsInstall; Cpu = $cpuName; }
     if ($installStatus -and $installStatus.Error) { $errors += "SQL Server '$($server.Definition)' Setup failed. $($installStatus.Error)"; }
   }

   if ("$($ENV:DEBUG_LOG_FOLDER)")
   {
      $reportJsonFullName = "$($ENV:DEBUG_LOG_FOLDER)\SQL Setup Benchmark.json"
      Create-Directory-for-File $reportJsonFullName
      $jsonReport | ConvertTo-Json | Out-File $reportJsonFullName -Force
   }

   return $errors;
}

# Include File: [\Includes.SqlServer\Try-Action-ForEach.ps1]
function Try-Action-ForEach([string] $actionTitle, [ScriptBlock] $action, [ScriptBlock] $itemTitle) {
  $inputCopy = @($input)
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()
  $index = 0;
  $totalErrors=0;
  $ret = @(); # errors
  $successNames = @()
  $failDetails = @()
  $quot1=[char]171; $quot2=[char]187; 
  $bullet=[char]8226; $arrow=[char]8594;
  foreach($inputItem in $inputCopy) {
    $theItemTitle = If ($null -eq $itemTitle) { "$inputItem" } Else { ForEach-Object -InputObject $inputItem -Process $itemTitle | Select -First 1 };
    $index++;
    $textCounter = "$index of $($inputCopy.Length)"
    Write-Host "$([Environment]::NewLine)STARTING $($textCounter): $($actionTitle) for $($quot1)$($theItemTitle)$($quot2)" -ForeGroundColor Yellow
    $itemStartAt = [System.Diagnostics.Stopwatch]::StartNew()
    $GLOBAL:LASTEXITCODE=0;
    $isOk = $null;
    $itemError=$null;
    try {
      $__ = ForEach-Object -InputObject $inputItem -Process $action
      if ($GLOBAL:LASTEXITCODE) {
        throw [InvalidOperationException] "Processing $theItemTitle failed, process exit code is $($GLOBAL:LASTEXITCODE)"
      }
      $isOk = $true;
      $successNames += $theItemTitle
    }
    catch {
      $itemError = $_.Exception.Message;
      $ret += [PSCustomObject] @{
        Index = $index;
        I = $inputItem;
        Error = $itemError;
        Title = $theItemTitle
      }
      Write-Host "Error On: $inputItem"
      $isOk = $false;
      $totalErrors++;
      $failDetails += [PSCustomObject] @{ Title = $theItemTitle; Error = $itemError};
    }

    $eta = ($startAt.Elapsed.TotalSeconds / $index * $inputCopy.Length) - $startAt.Elapsed.TotalSeconds;
    $color = If ($isOk) { "Green" } else { "Red" }
    $status = If ($isOk) { "Success" } else { "Fail" }
    Write-Host "$($status): $textCounter $($actionTitle) for $($quot1)$($theItemTitle)$($quot2) (ETA: $("{0:n1}" -f $eta)s)" -ForeGroundColor $color
    if ($itemError) { Write-Host "Error Message: $itemError" -ForeGroundColor Red }
    # Write-Host "ETA: $("{0:n1}" -f $eta)s"
    $host.ui.RawUI.WindowTitle = "ETA: $("{0:n1}" -f $eta)s. $textCounter. $($quot1)$($theItemTitle)$($quot2)"
    Set-Property-Smarty $inputItem "IsOK" $isOk
    Set-Property-Smarty $inputItem "Duration" ([Math]::Round($itemStartAt.Elapsed.TotalSeconds, 1))
  }

  $nl = "$([Environment]::NewLine)"
  Write-Host "Total Finished: $($inputCopy.Length); Failed: $totalErrors; Succeeded: $($inputCopy.Length - $totalErrors); Duration: $([Math]::Round($startAt.Elapsed.TotalSeconds, 1))s"
  if ($successNames.Length -gt 0) {
     Write-Host "$actionTitle Success: $($successNames.Length)"
     foreach($n in $successNames) { Write-Host "  $bullet $($quot1)$n$($quot2)" }
  } Else {
    Write-Host "$actionTitle Success: NONE"
  }
  if ($failDetails.Length -gt 0) {
     Write-Host "$actionTitle Fail: $($failDetails.Length)"
     foreach($n in $failDetails) { Write-Host "  $bullet $($quot1)$($n.Title)$($quot2) $arrow $($n.Error)" }
  } Else {
    Write-Host "$actionTitle Fail: NONE"
  }

  $ret
}

function Test-Try-Action-ForEach() {
  $items = 1..7 | % { [PSCustomObject] @{ Key = "Category $_" } }
  $itemTitle = { "$($_.Key)" }
  $action = { Sleep 0.2; If ($_.Key -match "3") { throw "$($_.Key) is not supported" } }
  $errors = @($items | Try-Action-ForEach -ActionTitle "Sleep" -Action $action -ItemTitle $itemTitle)
  Write-Host "`$errors.Length = $($errors.Count)"
  Write-Host $errors
}

# Test-Try-Action-ForEach

# Include File: [\Includes.SqlServer\Try-Get-FileName-by-Uri.ps1]
function Try-Get-FileName-by-Uri ([string] $url) {
  try { $uri = New-Object System.Uri $url; } catch { return $null; }
  $path = $uri.AbsolutePath;
  $parts = $path.Split("/");
  $ret = $parts | Select -Last 1;
  if ("$ret" -eq "download") { 
    $ret = $parts | Select -Last 2 | Select -First 1;
  }
  return "$ret";
}

function Try-Get-FileExtension-by-Uri ([string] $url) {
  $name = Try-Get-FileName-by-Uri $url;
  if ($name -eq $null) { return $null; }
  return ([System.IO.Path]::GetExtension($name));
}

# Include File: [\Includes.SqlServer\Uninstall-LocalDB-List.ps1]
function Uninstall-LocalDB-List([string[]] $patterns) {
  # $patterns
  # "*"
  # "2016", "2017"
  $localDbList = @(Get-Speedy-Software-Product-List | ? { $_.Name -match "LocalDB" -and $_.Vendor -match "Microsoft" })
  $names = @($localDbList | % { "$($_.Name)".Trim() })
  Write-Host "Uninstalling Microsoft LocalDB by patterns '$patterns'"
  Write-Host "Total LocalDB Installed: $($localDbList.Count), $names"

  $total = 0;
  foreach($localDb in $localDbList) {
    $isMatch = "$patterns" | ? { if ($_ -eq "*") { return $true }; $localDB.Name -match $_ };
    if ($isMatch) {
      Say "UNINSTALL '$($localDB.Name)'"
      $result = Execute-Process-Smarty "LocalDB Remover for '$($localDB.Name)'" "msiexec.exe" @("/qn", "/x", "$($localDB.IdentifyingNumber)", "/norestart");
      $result | Format-Table-Smarty | Out-Host
      $total++;
    }
  }
  Say "DONE. Total LocalDB Uninstalled: $total"
}

# Include File: [\Includes.SqlServer\Update-SqlServer-LocalDB-and-Shared-Tools.ps1]
# Supported 2016, 2017, 2019, 2022
function Update-SqlServer-LocalDB-and-Shared-Tools([string[]] $versions) {

  foreach($version in $versions) {
    $update=$null;
    $metaWithUpdate = Find-SQLServer-Meta $version "Core"
    if (($metaWithUpdate) -and ($metaWithUpdate["CU"])) {
      $update=$metaWithUpdate["CU"]
      $update=@($update) | Select -First 1
    }

    if ($update) {
      Write-Host "Installing Update $($update.Id) for shared tools and LocalDB $($version)" -ForegroundColor DarkGreen
      # $update | ConvertTo-Json -Depth 32 | Out-Host
    } else {
      Write-Host "Update for shared tools and LocalDB $($version) not found"
      continue;
    }

    $updateGot = Download-SqlServer-Update $version "Shared Tools" $update
    if ($updateGot -and $updateGot.UpdateLauncher) {
      $updateGot | ft -AutoSize | Out-Host
      $title = "Update Shared Tools and LocalDB version $($version)"
      $setupArg = @("/q", "/IAcceptSQLServerLicenseTerms", "/Action=Patch");
      $setupStatus = Execute-Process-Smarty "$title" $updateGot.UpdateLauncher $setupArg -WaitTimeout 3600
      $setupStatus | Format-Table-Smarty | Out-Host
      if ($setupStatus -and $upgradeResult.Error) { 
        Write-Host "$title incomplete" -ForegroundColor DarkRed
        # Write-Host ""
      }
    }
  }
}

# Update-SqlServer-LocalDB-and-Shared-Tools "2022", "2019", "2017", "2016", "2014", "2012"


$localDbList = @(Get-Speedy-Software-Product-List | ? { $_.Name -match "LocalDB" -and $_.Vendor -match "Microsoft" })
$names = $localDbList | % { $_.Name }
Write-Host "Total LocalDB Installed: $($localDbList.Count), $names"

foreach($localDb in $localDbList) {
  Say "UNINSTALL '$($localDB.Name)'"
  $result = Execute-Process-Smarty "LocalDB Remover for '$($localDB.Name)'" "msiexec.exe" @("/qn", "/x", "$($localDB.IdentifyingNumber)", "/norestart");
  $result | Format-Table-Smarty
}
Say "DONE"
