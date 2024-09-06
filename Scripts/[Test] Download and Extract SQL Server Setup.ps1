$ErrorActionPreference="Stop"

# Include Detected: [ ..\Includes\*.ps1 ]
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\$Full7zLinksMetadata.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\$VcRuntimeLinksMetadata.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Append-All-Text.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Bootstrap-Aria2-If-Required.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Combine-Path.ps1]
function Combine-Path($start) { foreach($a in $args) { $start=[System.IO.Path]::Combine($start, $a); }; $start }

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Create-Directory.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Demo-Test-of-Is-Vc-Runtime-Installed.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Demo-Test-of-Platform-Info.ps1]
function Demo-Test-of-Platform-Info() {
  echo "Memory $((Get-Memory-Info).Description)"
  echo "OS Platform: '$(Get-Os-Platform)'"
  if ("$(Get-Os-Platform)" -ne "Windows") { echo "UName System: '$(Get-Nix-Uname-Value "-s")'" }
  echo "CPU: '$(Get-Cpu-Name)'"
  Measure-Action "The Greeting Test Action" {echo "Hello World"}
  Measure-Action "The Fail Test Action" {$x=0; echo "Cant devide by zero $(42/$x)"; }
  Measure-Action "The CPU Name" {echo "CPU: '$(Get-Cpu-Name)'"}
}; # test

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Download-And-Install-Specific-VC-Runtime.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Download-File-FailFree-and-Cached.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Download-File-Managed.ps1]
function Download-File-Managed([string] $url, [string]$outfile) {
  $dirName=[System.IO.Path]::GetDirectoryName($outfile)
  Create-Directory "$dirName";
  $okAria=$false; try { & aria2c.exe -h *| out-null; $okAria=$? } catch {}
  if ($okAria) {
    Troubleshoot-Info "Starting download `"" -Highlight "$url" "`" using aria2c as `"" -Highlight "$outfile" "`""
    # "-k", "2M",
    $startAt = [System.Diagnostics.Stopwatch]::StartNew()
    & aria2c.exe @("--allow-overwrite=true", "--check-certificate=false", "-s", "12", "-x", "12", "-j", "12", "-d", "$($dirName)", "-o", "$([System.IO.Path]::GetFileName($outfile))", "$url");
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
  elseif (([System.Environment]::OSVersion.Version.Major) -eq 5) {
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


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Download-Specific-VC-Runtime.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-7z-Exe-FullPath-for-Windows.ps1]
function Get-Mini7z-Exe-FullPath-for-Windows() {
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Aria2c-Exe-FullPath-for-Windows.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-CPU-Architecture-Suffix-for-Windows.ps1]

# x86 (0), MIPS (1), Alpha (2), PowerPC (3), ARM (5), ia64 (6) Itanium-based systems, x64 (9), ARM64 (12)
function Get-CPU-Architecture-Suffix-for-Windows-Implementation() {
    # on multiple sockets x64
    if     (Has-Cmd "Get-CIMInstance") { $proc=Get-CIMInstance Win32_Processor; } 
    elseif (Has-Cmd "Get-WmiObject")   { $proc=Get-WmiObject   Win32_Processor; } 
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
      if     (Has-Cmd "Get-CIMInstance") { $os=Get-CIMInstance Win32_OperatingSystem; } 
      elseif (Has-Cmd "Get-WmiObject")   { $os=Get-WmiObject   Win32_OperatingSystem; } 
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Cpu-Name.ps1]
function Get-Cpu-Name-Implementation {
  $platform = Get-Os-Platform
  if ($platform -eq "Windows") {
    if (Has-Cmd "Get-CIMInstance")     { $proc=Get-CIMInstance Win32_Processor; } 
    elseif (Has-Cmd "Get-WmiObject")   { $proc=Get-WmiObject   Win32_Processor; } 
    return "$($proc.Name)"
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-DirectorySize.ps1]
function Get-DirectorySize([string] $path) {
  if ( Test-Path "$path"  -PathType Container) {
    $subFolderItems = Get-ChildItem "$path" -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum;
    return $subFolderItems.sum
  }
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Folder-Size.ps1]
function Get-Folder-Size([string] $folder) {
  if (Test-Path "$folder" -PathType Container) {
     $subFolderItems = Get-ChildItem "$folder" -recurse -force | Where-Object {$_.PSIsContainer -eq $false} | Measure-Object -property Length -sum | Select-Object Sum
     return $subFolderItems.sum;
  }
}


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Full7z-Exe-FullPath-for-Windows.ps1]
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
  $commandLine=@("x", "-y", "$fromArchive")
  Troubleshoot-Info "fromArchive: '$fromArchive'; commandLine: '$commandLine'"
  # ok on pwsh and powersheel
  & "$mini7z" @commandLine
  $isExtractOk = $?;
  return $isExtractOk;
}

function ExtractArchiveByDefault7zFull([string] $fromArchive, [string] $toDirectory, $extractCommand = "x") {
  New-Item -Path "$($toDirectory)" -ItemType Directory -Force -EA SilentlyContinue | Out-Null
  pushd "$($toDirectory)"
  $full7zExe = "$(Get-Full7z-Exe-FullPath-for-Windows)"
  Troubleshoot-Info "full7zExe: $full7zExe fromArchive $fromArchive"
  & "$full7zExe" @("$extractCommand", "-y", "$fromArchive")
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Github-Latest-Release.ps1]
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


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Github-Releases.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Installed-VC-Runtimes.ps1]
function Get-Installed-VC-Runtimes() {
  $softwareFilter = { $_.name -like "*Visual C++*" -and $_.vendor -like "*Microsoft*" -and ($_.name -like "*Runtime*" -or $_.name -like "*Redistributable*")}
  return Get-Speedy-Software-Product-List | where $softwareFilter
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Memory-Info.ps1]
function Get-Memory-Info {
  [OutputType([object])] param()

  $platform = Get-Os-Platform
  if ($platform -eq "Windows") {
    if (Has-Cmd "Get-CIMInstance")     { $os=Get-CIMInstance Win32_OperatingSystem; } 
    elseif (Has-Cmd "Get-WmiObject")   { $os=Get-WmiObject   Win32_OperatingSystem; } 
    $mem=($os | Where { $_.FreePhysicalMemory } | Select FreePhysicalMemory,TotalVisibleMemorySize -First 1);
    $total=[int] ($mem.TotalVisibleMemorySize / 1024);
    $free=[int] ($mem.FreePhysicalMemory / 1024);
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
  }

  if ($total) {
    $info="Total RAM: $($total.ToString("n0")) MB. Free: $($free.ToString("n0")) MB ($([Math]::Round($free * 100 / $total, 1))%)";
    return @{
        Total=$total;
        Free=$free;
        Description=$info;
    }
  }

  <#
     .OUTPUTS
     Object with 3 properties: [int] Total, [int] Free, [string] Description
  #>

}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Nix-Uname-Value.ps1]

# Linux/Darwin/FreeBSD, Error on Windows
function Get-Nix-Uname-Value {
  param([string] $arg)
  return (& uname "$arg" | Out-String-And-TrimEnd)
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Os-Platform.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-PS1-Repo-Downloads-Folder.ps1]
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

  If (Get-Os-Platform -eq "Windows") { $ret = "$($ENV:TEMP)" } else { $ret = "$($ENV:TMPDIR)" };
  $is1 = Test-Path -Path $ret -PathType Container -EA SilentlyContinue
  if (-not $is1) {
    New-Item -Path $ret -ItemType Directory -Force -EA SilentlyContinue | Out-null
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


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Smarty-FileHash.ps1]
# $algorithm: MD5|SHA1|SHA256|SHA384|SHA512
function Get-Smarty-FileHash([string] $fileName, [string] $algorithm = "MD5") {
  $fileExists = (Test-Path $fileName -PathType Leaf)
  if (-not $fileExists) { return $null; }
  $hashAlg = [System.Security.Cryptography.HashAlgorithm]::Create($algorithm)
  try {
    $fileStream = new-object System.IO.FileStream($fileName, "Open", "Read", "ReadWrite")
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


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Smarty-First.ps1]
function Get-Smarty-First-Obsolete($arg) {
  if ($arg -eq $null) { return new-object PSObject; }
  if ($arg -is [array]) { return $arg[0]; }
  return $arg;
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Smarty-FolderHash.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Speedy-Software-Product-List.ps1]
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
            Name    = "$($key.GetValue('DisplayName'))"
            Vendor  = "$($key.GetValue('Publisher'))"
            Version = "$($key.GetValue('DisplayVersion'))"
            IdentifyingNumber = [System.IO.Path]::GetFileName("$($key.Name)")
            Origin  = $origin.Origin
        }
      }
    }
  }
  return $ret | where { "$($_.Name)" -ne "" -and "$($_.Vendor)" -ne "" } | Sort-Object Vendor, Name, Version, Origin -Unique
}

# Get-Speedy-Software-Product-List | ft
# $localDbList = Get-Speedy-Software-Product-List | ? { $_.Name -match "LocalDB" -and $_.Vendor -match "Microsoft" }

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Has-Cmd.ps1]
function Has-Cmd {
  param([string] $arg)
  if ("$arg" -eq "") { return $false; }
  [bool] (Get-Command "$arg" -ErrorAction SilentlyContinue)
}


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\IIf.ps1]
function IIf([bool] $flag, $trueResult, $falseResult) {
  if ($flag) { return $trueResult; } else { return $falseResult; }
}
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Is-BuildServer.ps1]
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
     "CODEBUILD_BUILD_ARN"
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Is-File-Not-Empty.ps1]
function Is-File-Not-Empty([string] $fileName) {
  try { $fi = new-object System.IO.FileInfo($fileName); return $fi.Length -gt 0; } catch {}; return $fasle; 
}


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Is-Intel-Emulation-Available.ps1]
# On non-arm returns $false
function Is-Intel-Emulation-Available([int] $bitCount <# 32|64 #> = 64) {
  $systemRoot="$($ENV:SystemRoot)"
  $fileOnly = if ($bitCount -eq 64) { "xtajit64.dll" } else { "xtajit.dll" }; 
  $fullName=Combine-Path $systemRoot "System32" $fileOnly;
  return [bool] (Is-File-Not-Empty $fullName)
}



# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Is-Vc-Runtime-Installed.ps1]
function Is-Vc-Runtime-Installed([int] $major, [string] $arch) {
  $vcList = Get-Installed-VC-Runtimes
  # Does not support x86 v8 (2005) on x86 Windows
  $found = $vcList | where { ($_.Version.StartsWith($major.ToString("0")+".")) -and ($_.Name.ToLower().IndexOf($arch.ToLower()) -ge 0 -or $_.Origin -eq $arch) }
  # return $found.Length -gt 0; v6+
  # return @($found).Length -gt 0; v5+
  return "$($found)" -ne ""; # v2+
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Measure-Action.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Out-String-And-TrimEnd.ps1]
Function Out-String-And-TrimEnd
{
  Param ([int] $Skip=0, [int] $Take=2000000000)
  Begin { $n=0; $list = New-Object System.Collections.Generic.List[System.Object]}
  Process { $n++; if (-not ($n -le $Skip -or $n -gt ($Skip+$Take))) { $list.Add("$_"); } }
  End { return [string]::join([System.Environment]::NewLine, $list.ToArray()).TrimEnd(@([char]13,[char]10)) }
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Remove-Windows-Service-If-Exists.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Say.ps1]
function Say { # param( [string] $message )
    if ($Global:_Say_Stopwatch -eq $null) { $Global:_Say_Stopwatch = [System.Diagnostics.Stopwatch]::StartNew(); }
    $milliSeconds=$Global:_Say_Stopwatch.ElapsedMilliseconds
    if ($milliSeconds -ge 3600000) { $format="HH:mm:ss"; } else { $format="mm:ss"; }
    $elapsed="[$((new-object System.DateTime(0)).AddMilliseconds($milliSeconds).ToString($format))]"
    Write-Host "$($elapsed) " -NoNewline -ForegroundColor Magenta
    Write-Host "$args" -ForegroundColor Yellow
}
$Global:_Say_Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Smart-Format.ps1]
function Format-Table-Smarty
{ 
   $arr = (@($Input) | % { [PSCustomObject]$_} | Format-Table -AutoSize | Out-String -Width 2048).Split(@([char]13, [char]10)) | ? { "$_".Length -gt 0 };
   if (-not $arr) { return; }
   [string]::Join([Environment]::NewLine, $arr);
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Start-Stopwatch.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\To-Boolean.ps1]
function To-Boolean() { param([string] $name, [string] $value)
  if (($value -eq "True") -Or ($value -eq "On") -Or ($value -eq "1") -Or ("$value".ToLower().StartsWith("enable"))) { return $true; }
  if (("$value" -eq "") -Or ($value -eq "False") -Or ($value -eq "Off") -Or ($value -eq "0") -Or ("$value".ToLower().StartsWith("disable"))) { return $false; }
  Write-Host "Validation Error! Invalid $name parameter '$value'. Boolean parameter accept only True|False|On|Off|Enable|Disable|1|0" -ForegroundColor Red
  return $false;
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Troubleshoot-Info.ps1]
function Troubleshoot-Info() {
  $enableTroubleShoot = To-Boolean "PS1_TROUBLE_SHOOT" "$($ENV:PS1_TROUBLE_SHOOT)"
  if (-not $enableTroubleShoot) { return; }
  $c = (Get-PSCallStack)[1]
  $cmd = $c.Command;
  Write-Host -NoNewLine "[$cmd" -ForegroundColor DarkCyan
  $line=$null; if ($c.Location) { $line = ":$($c.Location.Split(32) | Select -Last 1)"; }
  if ($line) {
    Write-Host -NoNewLine "$line" -ForegroundColor DarkCyan;
  }
  Write-Host -NoNewLine "] " -ForegroundColor DarkCyan
  $color="";
  $args | % {
    if ($_ -eq "-Highlight") { 
      $color = "Cyan";
    } else { 
      if ($color) { Write-Host -NoNewLine "$_" -ForegroundColor $color; } else { Write-Host -NoNewLine "$_"; }
      $color = ""
    }
  }
  Write-Host ""
}

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

# Black DarkBlue DarkGreen DarkCyan DarkRed DarkMagenta DarkYellow Gray DarkGray Blue Green Cyan Red Magenta Yellow White
# Include Detected: [ ..\Includes.SqlServer\*.ps1 ]
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\$SqlServer2010DownloadLinks.ps1]
$SqlServer2010DownloadLinks = @(
  @{ 
    Version="2014-x64"; #SP3
    Core     ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x64_ENU.exe" 
    Advanced ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPRADV_x64_ENU.exe" #SP3, 
    # SP1 does not work on Pipeline
    # Developer="https://archive.org/download/sql-server-2014-enterprise-sp-1-x-64/SQL_Server_2014_Enterprise_SP1_x64.rar" #SP1
    # DeveloperFormat="ISO-In-Archive"
    Developer=@("https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2014_sp3_developer_edition_x64.7z/download", "https://archive.org/download/sql_server_2014_sp3_developer_edition_x64.7z/sql_server_2014_sp3_developer_edition_x64.7z") #SP3, 12.0.6024
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/ENU/x64/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2014-x86"; #SP3
    Core    ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPR_x86_ENU.exe" 
    Advanced="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/SQLEXPRADV_x86_ENU.exe"
    LocalDB ="https://download.microsoft.com/download/3/9/F/39F968FA-DEBB-4960-8F9E-0E7BB3035959/ENU/x86/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2012-x64"; #SP4
    Core ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPR_x64_ENU.exe" 
    Advanced="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPRADV_x64_ENU.exe" 
    Developer=@("https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2012_sp4_developer_edition_x64.7z/download", "https://archive.org/download/sql_server_2012_sp4_developer_x86_x64/sql_server_2012_sp4_developer_x64.7z") # 11.0.7001.0 SP4
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/ENU/x64/SqlLocalDB.msi"
    CU=@(
    )
  };
  @{ 
    Version="2012-x86"; #SP4
    Core ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPR_x86_ENU.exe" 
    Advanced="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/SQLEXPRADV_x86_ENU.exe"
    Developer=@("https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2012_sp4_developer_edition_x86.7z/download", "https://archive.org/download/sql_server_2012_sp4_developer_x86_x64/sql_server_2012_sp4_developer_x86.7z") # 11.0.7001.0 SP4
    DeveloperFormat="Archive"
    LocalDB ="https://download.microsoft.com/download/B/D/E/BDE8FAD6-33E5-44F6-B714-348F73E602B6/ENU/x86/SqlLocalDB.msi"
    CU=@(
    )
  };

  @{ 
    Version="2008R2-x64"; #SP2
    Core    ="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x64_ENU.exe" 
    Advanced="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRADV_x64_ENU.exe" 
    Developer=@("https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008r2_sp3_developer_edition_x64.7z/download", "https://archive.org/download/sql_server_2008r2_sp3_developer_edition_x86_x64_ia64/sql_server_2008r2_sp3_developer_edition_x64.7z")
    DeveloperFormat="Archive"
    CU=@(
      @{ Id="SP3"; Url="https://download.microsoft.com/download/D/7/A/D7A28B6C-FCFE-4F70-A902-B109388E01E9/ENU/SQLServer2008R2SP3-KB2979597-x64-ENU.exe" }
    )
  };
  @{ 
    Version="2008R2-x86"; #SP2
    Core    ="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPR_x86_ENU.exe" 
    Advanced="https://download.microsoft.com/download/0/4/B/04BE03CD-EAF3-4797-9D8D-2E08E316C998/SQLEXPRADV_x86_ENU.exe"
    Developer=@("https://sourceforge.net/projects/archived-sql-servers/files/sql_server_2008r2_sp3_developer_edition_x86.7z/download", "https://archive.org/download/sql_server_2008r2_sp3_developer_edition_x86_x64_ia64/sql_server_2008r2_sp3_developer_edition_x86.7z")
    DeveloperFormat="Archive"
    CU=@(
      @{ Id="SP3"; Url="https://download.microsoft.com/download/D/7/A/D7A28B6C-FCFE-4F70-A902-B109388E01E9/ENU/SQLServer2008R2SP3-KB2979597-x86-ENU.exe" }
    )
  };
  # https://archive.org/download/en_sql_server_2008_r2_developer_x86_x64_ia64_dvd_522665

  # 2008 SP2
  @{ 
    Version="2008-x64"; 
    Core    ="https://web.archive.org/web/20160617214727/https://download.microsoft.com/download/0/F/D/0FD88169-F86F-46E1-8B3B-56C44F6E9505/SQLEXPR_x64_ENU.exe"  #SP3
    Advanced="https://download.microsoft.com/download/e/9/b/e9bcf5d7-2421-464f-94dc-0c694ba1b5a4/SQLEXPRADV_x64_ENU.exe" #RTM
    CU=@(
      @{ Id="SP4"; Url="https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x64-ENU.exe" }
    )
    
  };
  @{ 
    Version ="2008-x86"; #SP2
    Core    ="https://web.archive.org/web/20160617214727/https://download.microsoft.com/download/0/F/D/0FD88169-F86F-46E1-8B3B-56C44F6E9505/SQLEXPR_x86_ENU.exe" #SP3
    Advanced="https://download.microsoft.com/download/e/9/b/e9bcf5d7-2421-464f-94dc-0c694ba1b5a4/SQLEXPRADV_x86_ENU.exe" #RTM
    CU=@(
      @{ Id="SP4"; Url="https://download.microsoft.com/download/5/E/7/5E7A89F7-C013-4090-901E-1A0F86B6A94C/ENU/SQLServer2008SP4-KB2979596-x86-ENU.exe" }
    )
  };
  @{ 
    Version="2005-x86"; 
    Core    ="https://sourceforge.net/projects/db-engine/files/database-engine-x86-9.0.5000.exe/download"  #SP4
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\$SqlServerAlreadyUpdatedList.ps1]
$SqlServerAlreadyUpdatedList = @(
  @{ Version = "2008R2-x64"; MediaType = "Developer"; },
  @{ Version = "2008R2-x86"; MediaType = "Developer"; },
  @{ Version = "2005-x86";   MediaType = "Core"; }
);

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\$SqlServerDownloadLinks.ps1]
$SqlServerDownloadLinks = @(
   @{
      Version="2022"
      Advanced="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLEXPRADV_x64_ENU.exe"
      Core="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLEXPR_x64_ENU.exe"
      LocalDB="https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SqlLocalDB.msi"
      Developer=@(
         "https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLServer2022-DEV-x64-ENU.box",
         "https://download.microsoft.com/download/3/8/d/38de7036-2433-4207-8eae-06e247e17b25/SQLServer2022-DEV-x64-ENU.exe")
      CU=@(
        @{ Id="CU14"; Url="https://download.microsoft.com/download/9/6/8/96819b0c-c8fb-4b44-91b5-c97015bbda9f/SQLServer2022-KB5038325-x64.exe"; }
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
        @{ Id="CU28"; Url="https://download.microsoft.com/download/6/e/7/6e72dddf-dfa4-4889-bc3d-e5d3a0fd11ce/SQLServer2019-KB5039747-x64.exe"; }
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
        @{ Id="CU31"; Url="https://download.microsoft.com/download/C/4/F/C4F908C9-98ED-4E5F-88D5-7D6A5004AEBD/SQLServer2017-KB5016884-x64.exe"; }
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
        @{ Id="1.KB5040946"; Url="https://download.microsoft.com/download/d/a/1/da18aac1-2cd0-4c52-b30d-39c3172cd156/SQLServer2016-KB5040946-x64.exe"; }
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Download-2010-SQLServer-and-Extract.ps1]
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
      $sevenZip = Get-Full7z-Exe-FullPath-for-Windows -Version "1900"
      $isoFolder = Combine-Path $mediaPath "iso"
      Write-Host "Extracting '$exeArchive' to '$isoFolder'"
      & "$sevenZip" @("x", "-y", "-o`"$isoFolder`"", "$exeArchive") | out-null
      $isoFile = Get-ChildItem -Path "$isoFolder" -Filter "*.iso" | Select -First 1
      Write-Host "ISO found: '$($isoFile.FullName)' ($($isoFile.Length.ToString("n0")) bytes). Extracting it to '$setupPath'";
      & "$sevenZip" @("x", "-y", "-o`"$setupPath`"", "$($isoFile.FullName)") | out-null
      $ret["Launcher"] = Combine-Path $setupPath "Setup.exe";
      $ret["Setup"] = $setupPath;
      $ret["Media"] = $mediaPath;
    } elseif ($urlFormat -eq "Archive") {
      $sevenZip = Get-Full7z-Exe-FullPath-for-Windows -Version "1900"
      Write-Host "Extracting '$exeArchive' to '$setupPath'"
      & "$sevenZip" @("x", "-y", "-o`"$setupPath`"", "$exeArchive") | out-null
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Download-Fresh-SQLServer-and-Extract.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Download-SQLServer-and-Extract.ps1]
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
    $ret["SetupSize"] = Get-DirectorySize $ret.Setup;
    if (Is-SqlServer-Setup-Cache-Enabled) { 
      $ret["SetupHash"] = Get-Smarty-FolderHash $ret.Setup "SHA512"
    }
  }
  if ($ret.Media) {
    $ret["MediaSize"] = Get-DirectorySize $ret.Media;
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Download-SqlServer-Update.ps1]
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
  Write-Host "Downloading SQL Server update '$($update.Id)' for version $version $mediaType. URL is '$($update.Url)'"
  $isDownloadOk = Download-File-FailFree-and-Cached $archiveFullName @("$($update.Url)")
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Enumerate-SQLServer-Downloads.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Execute-Process-Smarty.ps1]
function Execute-Process-Smarty {
  Param(
    [string] $title, 
    [string] $launcher,
    [string[]] $arguments,
    [string] $workingDirectory = $null,
    [int] $waitTimeout = 3600
  )
  $arguments = @($arguments | ? { "$_".Trim() -ne "" })
  Troubleshoot-Info "[$title] `"$launcher`" $arguments";
  $startAt = [System.Diagnostics.Stopwatch]::StartNew()

  $ret = @{};
  try { 
    if ($workingDirectory) { 
      $app = Start-Process "$launcher" -ArgumentList $arguments -WorkingDirectory $workingDirectory -PassThru;
    } else {
      $app = Start-Process "$launcher" -ArgumentList $arguments -PassThru;
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Find-SQLServer-Meta.ps1]
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

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Find-SqlServer-SetupLogs.ps1]
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


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Get-SqlServer-Downloads-Folder.ps1]
function Get-SqlServer-Setup-Folder() {
  return (GetPersistentTempFolder "SQLSERVERS_SETUP_FOLDER" "SQL-Setup");
}

function Get-SqlServer-Media-Folder() {
  return (GetPersistentTempFolder "SQLSERVERS_MEDIA_FOLDER" "SQL Media");
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Get-System-Drive.ps1]
function Get-System-Drive() { $ret = "$($Env:SystemDrive)"; $c = "$([System.IO.Path]::DirectorySeparatorChar)"; if (-not ($ret.EndsWith($c))) { $ret += $c; }; return $ret; }
  

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Install-SQLServer.ps1]
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
    [object] $update, # optional, 
    [string] $instanceName
  )

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

  $defaultOptions = @{
    InstallTo = Combine-Path "$(Get-System-Drive)" "SQL";
    Password = "``1qazxsw2";
    Tcp = 1;
    NamedPipe = 1;
    SysAdmins = "BUILTIN\ADMINISTRATORS";
    Features = "SQLENGINE,REPLICATION,FullText";
  }
  $options = $defaultOptions.Clone();

  $major = ($meta.Version.Substring(0,4)) -as [int];
  $is2020 = $major -ge 2016;
  $setupArg=@();
  $title = "SQL Server $($meta.Version) $($meta.MediaType) Setup"
  if ($major -eq 2005) {
    # SQL_Engine,SQL_Data_Files,SQL_Replication,SQL_FullText,SQL_SharedTools
    $argFeatures = IIf ($meta.MediaType -eq "Advanced") "SQL_Engine,SQL_FullText" "SQL_Engine";
    # /qb for unattended with basic UI
    
    $setupArg = "/qn", "ADDLOCAL=$argFeatures", "INSTANCENAME=`"$instanceName`"", 
         "DISABLENETWORKPROTOCOLS=0", # 0: All, 1: None, 2: TCP only
         "SECURITYMODE=SQL", "SAPWD=`"$($options.Password)`"", 
         "INSTALLSQLDIR=`"$($options.InstallTo)`"";

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
    $argQuiet = IIf ((Is-BuildServer) -or $meta.Version -like "2005*" -or $meta.Version -like "2008-*") "/Q" "/QUIETSIMPLE";
    $argProgress = "/INDICATEPROGRESS";
    $argProgress = "";
    $argADDCURRENTUSERASSQLADMIN = IIf ($meta.MediaType -eq "Developer") "" "/ADDCURRENTUSERASSQLADMIN";
    # 2008 and R2: The setting 'IACCEPTROPENLICENSETERMS' specified is not recognized.
    $argIACCEPTROPENLICENSETERMS = IIF ($major -le 2014) "" "/IACCEPTROPENLICENSETERMS";
    
    # 2008 R2 Dev 10.50.6000.34: /AGTSVCACCOUNT="NT AUTHORITY\SYSTEM" required on Windows 2016+
    $argAGTSVCACCOUNT = IIF ($meta.Version -like "2008R2*" -and $meta.MediaType -eq "Developer") "/AGTSVCACCOUNT=`"NT AUTHORITY\SYSTEM`"" "";
    
    # 2008-xXX features
    $argFeatures = "$($options.Features)"
    if ($meta.Version -match "2008-") { $argFeatures = IIf ($meta.MediaType -eq "Core") "SQLENGINE" "SQLENGINE,FULLTEXT"; }

    $argENU = IIf ($meta.Version -match "2008-") "" "/ENU"
    $argIACCEPTSQLSERVERLICENSETERMS = IIf ($meta.Version -match "2008-") "" "/IAcceptSQLServerLicenseTerms"

    $hasUpdateSourceArgument = ($major -ge 2012);
    $argUpdateEnabled = IIF ([bool]"$update" -and $hasUpdateSourceArgument) "/UpdateEnabled=True" ""
    $argUpdateSource = If ("$update" -and $hasUpdateSourceArgument) { "/UpdateSource=`"$($update.UpdateFolder)`"" } else { "" };


    # AddCurrentUserAsSQLAdmin can be used only by Express SKU or set using ROLE.
    $setupArg = "$argQuiet", "$argENU", "$argProgress", "/ACTION=Install",
    "$argIACCEPTSQLSERVERLICENSETERMS", "$argIACCEPTROPENLICENSETERMS", 
    "$argUpdateEnabled", "$argUpdateSource",
    "/FEATURES=`"$argFeatures`"", 
    "/INSTANCENAME=`"$instanceName`"", 
    "/INSTANCEDIR=`"$($options.InstallTo)`"", 
    "/SECURITYMODE=`"SQL`"", 
    "/SAPWD=`"$($options.Password)`"", 
    "/SQLSVCACCOUNT=`"NT AUTHORITY\SYSTEM`"", "$argAGTSVCACCOUNT",
    "/SQLSVCSTARTUPTYPE=AUTOMATIC", 
    "/BROWSERSVCSTARTUPTYPE=AUTOMATIC", 
    "$argADDCURRENTUSERASSQLADMIN", 
    "/SQLSYSADMINACCOUNTS=`"BUILTIN\ADMINISTRATORS`"", 
    "/TCPENABLED=$($options.Tcp)", "/NPENABLED=$($options.NamedPipe)";
    # Write-Host ">>> `"$($meta.Launcher)`" $setupArg"
    # & "$($meta.Launcher)" $setupArg
    # if (-not $?) {
    #   Write-Host "Warning! Setup '$($meta.Launcher)' failed" -ForeGroundColor DarkRed
    # }
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
  
  # Write-Host ">>> $($meta.Launcher) $setupArg"

}


# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Is-SqlServer-Setup-Cache-Enabled.ps1]
function Is-SqlServer-Setup-Cache-Enabled() { $false; }
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Parse-SqlServers-Input.ps1]
function Parse-SqlServers-Input { param( [string] $list)
    # Say "Installing SQL Server(s) by tags: $list"
    $rawServerList = "$list".Split(@([char]44, [char]59));
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

            if ($instanceName -eq $null) {
              $instanceName = $mediaType.Substring(0,3).ToUpper() + "_" + $version.Replace("-", "_");
            }
            $instanceName = "$($instanceName.ToUpper())"

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
# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Publish-SQLServer-SetupLogs.ps1]
function Publish-SQLServer-SetupLogs([string] $toFolder, $compression=9) {
  New-Item -ItemType Directory -Path "$toFolder" -EA SilentlyContinue | out-null
  $folders = Find-SqlServer-SetupLogs
  $sevenZip = Get-Full7z-Exe-FullPath-for-Windows -Version "1900"
  foreach($logsFolder in $folders) {
    $archiveName=$logsFolder.Substring([System.IO.Path]::GetPathRoot($logsFolder).Length).Replace("\", ([char]8594).ToString())
    Say "Pack '$logsFolder' as `"$toFolder\$archiveName.7z`""
    & "$sevenZip" @("a", "-y", "-mx=$compression", "-ms=on", "-mqs=on", "$toFolder\$archiveName.7z", "$logsFolder\*") | out-null
    if (-not $?) {
      Write-Host "Failed publishing '$archiveName' to folder '$toFolder'" -ForegroundColor DarkRed
      # return $false;
    }
    # return $true;
  }
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes.SqlServer\Setup-SqlServers.ps1]
function Setup-SqlServers() {
Param(
  [string] $sqlServers
)

<#
TODO: 
  DataDir,
  LogDir,
  BackupDir,
  TempDir,
  MaxRam,
#>

   $errors = @();
   $cpuName = "$((Get-WmiObject Win32_Processor).Name)".Trim()

   Say "Setting up SQL Server(s) `"$sqlServers`". Cpu is '$cpuName'"
   $servers = Parse-SqlServers-Input $sqlServers
   $servers | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
   $jsonReport = @();
   foreach($server in $servers) {
     $startAt = [System.Diagnostics.Stopwatch]::StartNew()
     Say "TRY DOWNLOAD SQL SERVER $($server.Version) $($server.MediaType)"
     $setupMeta = Download-SQLServer-and-Extract $server.Version $server.MediaType;
     $setupMeta | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
     $resultGetUpdate = $null;
     if ($server.UpdateId) {
       Say "TRY DOWNLOAD UPDATE $($server.UpdateId)"
       $resultGetUpdate = Download-SqlServer-Update $server.Version $server.MediaType $server.Update;
       $resultGetUpdate | Format-Table -AutoSize | Out-String -Width 256 | Out-Host
     }
     $secondsDownload = $startAt.ElapsedMilliseconds / 1000.0;
     $startAt = [System.Diagnostics.Stopwatch]::StartNew()
     $installStatus = Install-SQLServer $setupMeta $resultGetUpdate $server.InstanceName;
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


Write-Host "Try-BuildServerType: [$(Try-BuildServerType)], Is-BuildServer: $(Is-BuildServer)"

# Build Keyswords
$keywords = "";
$counter = 0;
$filter = {$_.UpdateId -eq $null}
$filter = {$true}
foreach($meta in Enumerate-Plain-SQLServer-Downloads | ? $filter) {
  $counter++;
  $keywords += "$("{0,3}" -f $counter)| $($meta.Keywords)$([Environment]::NewLine)"
}
$keywordsFile = Combine-Path (Get-SqlServer-Media-Folder) "Keywords.txt" 
Write-All-Text $keywordsFile $keywords;
Get-Content $keywordsFile | Out-Host

$filter = {$major = ($_.Version.Substring(0,4)) -as [int]; return $major -eq 2017 -and $_.UpdateId -eq $null -and $_.MediaType -eq "Developer";}
$filter = {$_.UpdateId -eq $null}
$counter = 0;
foreach($meta in Enumerate-Plain-SQLServer-Downloads | ? $filter) {
  $counter++;
  Say "TRY DOWNLOAD SQL #$($counter): [$($meta.Keywords)]"
  $downloadResult = Download-SQLServer-and-Extract $meta.Version $meta.MediaType
  $downloadResult | Format-Table -AutoSize | Out-String -Width 256
  if ((Is-BuildServer) -and ($downloadResult.Media)) {
    Write-Host "Clean up '$($downloadResult.Media)' ..."
    Remove-Item -Recurse -Force "$($downloadResult.Media)" -ErrorAction SilentlyContinue | out-null
  }
}
Say "DONE"


$counter = 0;
foreach($meta in Enumerate-Plain-SQLServer-Downloads) {
  if ($meta.Update) {
    $counter++;
    Say "TRY DOWNLOAD UPDATE #$($counter): Id='$($meta.UpdateId)' [$($meta.Keywords)]"
    $result = Download-SqlServer-Update $meta.Version $meta.MediaType $meta.Update;
    $result | Format-Table -AutoSize | Out-String -Width 256
  }
}

Show-Tree-Size (Get-SqlServer-Media-Folder) 0
Show-Tree-Size (Get-SqlServer-Setup-Folder) 0
