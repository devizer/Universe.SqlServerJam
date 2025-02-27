script=https://raw.githubusercontent.com/devizer/test-and-build/master/install-build-tools-bundle.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash > /dev/null

echo "tee: [$(command -v tee)]"

if [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
  echo "Windows 'SystemDrive' var = [${SystemDrive:-}]"
  sysDrive="${SystemDrive:0:1}"
  sysDrive="${sysDrive:-c}"
  THEARTIFACTS="/$sysDrive/Artifacts"
  THEARTIFACTS_NATIVE="$sysDrive:\\Artifacts"
else
  THEARTIFACTS="$HOME/Artifacts"
  THEARTIFACTS_NATIVE="$THEARTIFACTS"
fi
echo "THEARTIFACTS = [$THEARTIFACTS] | THEARTIFACTS_NATIVE = [$THEARTIFACTS_NATIVE]"
echo "THEARTIFACTS=$THEARTIFACTS" >> "$GITHUB_ENV"
echo "THEARTIFACTS_NATIVE=$THEARTIFACTS_NATIVE" >> "$GITHUB_ENV"
mkdir -p "$THEARTIFACTS"

ls -la /D || true
ls -la /d || true
ls -la /mnt || true
ls -la /mnt/D/ || true
ls -la /cygdrive || true
ls -la /cygdrive/d || true

for suffix in p v m r s; do
  echo "uname -$suffix: $(uname -$suffix)"
done

Say "Benchmark for [$(Get-CpuName)]"
if [[ "$(uname -s)" == Darwin ]] || [[ "$(uname -s)" == Linux ]]; then
  export INSTALL_DIR=/usr/local/bin LINK_AS_7Z=/usr/local/bin/7z; script="https://master.dl.sourceforge.net/project/p7zz-repack/install-7zz.sh?viasf=1"; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash
elif [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
  Say "Installing 7-Zip"
  choco install 7zip --version 21.7.0 --force --allow-downgrade --no-progress
fi
if [[ -d /usr/local/bin ]]; then export PATH="/usr/local/bin:$PATH"; fi
bash -c "7z b -mmt=1 -md=22" | tee -a "$THEARTIFACTS"/SysInfo.txt

# Fix missing fio and nproc
if [[ "$(uname -s)" == Linux ]]; then
   Say "Linux Volumes"
   sudo df -h -T
elif [[ "$(uname -s)" == Darwin ]]; then
   Say "MacOS Volumes"
   sudo df -h
   brew install fio
   # install nproc
   echo '#!/usr/bin/env bash
         sysctl -n machdep.cpu.thread_count' | sudo tee /usr/local/bin/nproc > /dev/null
   sudo chmod +x /usr/local/bin/nproc
elif [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
   Say "Windows Volumes"
   powershell -c "gdr -PSProvider 'FileSystem'"
   choco install -y --no-progress fio
   echo '#!/bin/bash
         set -e; if [[ "${1:-}" == "-E" ]]; then shift; fi; eval "$@"' > /usr/bin/sudo
   chmod +x /usr/bin/sudo
else
  echo "Warning! Unknown OS"
fi

export DISABLE_UNICODE=true
Say "Disk Benchmark for [$HOME]"
File-IO-Benchmark 'HOME' "$HOME" 2G $(nproc)T 30 1 | tee fio-benchmark-1.log

secondDrive=""
[[ -d /D ]] && secondDrive="/D"
[[ -d /mnt ]] && secondDrive="/mnt"
if [[ -n "$secondDrive" ]]; then
  Say "Disk Benchmark for SECOND Drive [$secondDrive]"
  sudo -E File-IO-Benchmark 'SECOND-Drive' "$secondDrive" 2G $(nproc)T 30 1 | tee fio-benchmark-2.log | tee -a "$THEARTIFACTS"/SysInfo.txt

  echo "";echo "";
  cat fio-benchmark-1.log | tail -5 | tee -a "$THEARTIFACTS"/SysInfo.txt
fi

