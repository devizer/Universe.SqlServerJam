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
  $utf8=new-object System.Text.UTF8Encoding($false); [System.IO.File]::AppendAllText($file, $text, $utf8);
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
  $_ = [System.IO.Directory]::CreateDirectory($dirName)
  $okAria=$false; try { & aria2c.exe -h *| out-null; $okAria=$? } catch {}
  if ($okAria) {
    & aria2c.exe @("--allow-overwrite=true", "--check-certificate=false", "-s", "12", "-x", "12", "-k", "2M", "-j", "12", "-d", "$($dirName)", "-o", "$([System.IO.Path]::GetFileName($outfile))", "$url");
    if ($?) { <# Write-Host "aria2 rocks ($([System.IO.Path]::GetFileName($outfile)))"; #> return $true; }
  }
  elseif (([System.Environment]::OSVersion.Version.Major) -eq 5) {
    Write-Host "Warning! Windows XP and Server 2003 requires aria2c.exe in the PATH for downloading." -ForegroundColor Red; 
  }
  [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12;
  if ($PSVersionTable.PSEdition -ne "Core") {
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback={$true};
  }
  for ($i=1; $i -le 3; $i++) {
    $d=new-object System.Net.WebClient;
    # $d.Headers.Add("User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36");
    try {
      $d.DownloadFile("$url","$outfile"); 
      return $true
    } 
    catch { 
      $fileExists = (Test-Path $outfile)
      if ($fileExists) { Remove-Item $outfile -force }
      # Write-Host $_.Exception -ForegroundColor DarkRed; 
      if ($i -lt 3) {
        Write-Host "The download of the '$url' url failed.$([System.Environment]::NewLine)Retrying, $($i+1) of 3. $($_.Exception.Message)" -ForegroundColor Red;
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
  return Combine-Path $ret "Temp" "PS1 Repo Downloads";
}

# File: [C:\Cloud\vg\PUTTY\Repo-PS1\Includes\Get-Smarty-FileHash.ps1]
# $algorithm: MD5|SHA1|SHA256|SHA384|SHA512
function Get-Smarty-FileHash([string] $fileName, [string] $algorithm = "MD5") {
  $fileExists = (Test-Path $fileName)
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
        $ret += New-Object PSObject -Property @{
            Name    = "$($key.GetValue('DisplayName'))"
            Vendor  = "$($key.GetValue('Publisher'))"
            Version = "$($key.GetValue('DisplayVersion'))"
            Origin  = $origin.Origin
        }
      }
    }
  }
  return $ret | where { "$($_.Name)" -ne "" -and "$($_.Vendor)" -ne "" } | Sort-Object Vendor, Name, Version, Origin -Unique
}

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
Bootstrap-Aria2-If-Required -Force $true
