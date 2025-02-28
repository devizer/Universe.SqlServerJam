set -eu; set -o pipefail
script=https://raw.githubusercontent.com/devizer/test-and-build/master/install-build-tools-bundle.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash > /dev/null

if [[ -n "${SYSTEM_ARTIFACTSDIRECTORY:-}" ]]; then # Azure Dev-Ops
  export GITHUB_ENV=/dev/null
  THEARTIFACTS="${SYSTEM_ARTIFACTSDIRECTORY:-}"
  # THEARTIFACTS="/d/a/1/a"
  ReportName="$THEARTIFACTS/Azure ${AGENT_JOBNAME:-}.txt"
  echo "ReportName          = [$ReportName]"
  echo "THEARTIFACTS        = [$THEARTIFACTS]"
else # GitHub Actions
  if [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
    echo "Windows 'SystemDrive' var = [${SYSSTEMDRIVE:-}]"
    sysDrive="${SYSSTEMDRIVE:-}"
    sysDrive="${sysDrive:0:1}"
    sysDrive="${sysDrive:-c}"
    THEARTIFACTS="/$sysDrive/Artifacts"
    THEARTIFACTS_NATIVE="$sysDrive:\\Artifacts"
  else
    THEARTIFACTS="$HOME/Artifacts"
    THEARTIFACTS_NATIVE="$THEARTIFACTS"
  fi
  ReportName="$THEARTIFACTS/$ReportFileName"
  echo "ReportName          = [$ReportName]"
  echo "THEARTIFACTS        = [$THEARTIFACTS]"
  echo "THEARTIFACTS_NATIVE = [$THEARTIFACTS_NATIVE]"
  echo "THEARTIFACTS=$THEARTIFACTS" >> "$GITHUB_ENV"
  echo "THEARTIFACTS_NATIVE=$THEARTIFACTS_NATIVE" >> "$GITHUB_ENV"
fi
mkdir -p "$THEARTIFACTS"

echo '
ls -la /D || true
ls -la /d || true
ls -la /mnt || true
ls -la /mnt/D/ || true
ls -la /cygdrive || true
ls -la /cygdrive/d || true
' > /dev/null

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
bash -c "7z b -mmt=1 -md=22" | tee -a "$ReportName"

# Install missing fio and nproc
if [[ "$(uname -s)" == Linux ]]; then
   Say "Linux Volumes"
   sudo df -h -T | tee ~/volumes-info.txt
elif [[ "$(uname -s)" == Darwin ]]; then
   Say "MacOS Volumes"
   sudo df -h | tee ~/volumes-info.txt
   brew install fio
   # install nproc
   echo '#!/usr/bin/env bash
         sysctl -n machdep.cpu.thread_count' | sudo tee /usr/local/bin/nproc > /dev/null
   sudo chmod +x /usr/local/bin/nproc
elif [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
   Say "Windows Volumes"
   powershell -c "gdr -PSProvider 'FileSystem'" | tee ~/volumes-info.txt
   choco install --force --allow-downgrade -y --no-progress fio
   echo '#!/bin/bash
         set -e; if [[ "${1:-}" == "-E" ]]; then shift; fi; eval "$@"' > /usr/bin/sudo
   chmod +x /usr/bin/sudo
else
  echo "Warning! Unknown OS"
fi

(echo ""; echo "VOLUMES"; cat ~/volumes-info.txt) >> "$ReportName"

export DISABLE_UNICODE=true
Say "Disk Benchmark for [$HOME]"
File-IO-Benchmark 'HOME' "$HOME" 2G $(nproc)T 22 1 | tee fio-benchmark-1.log
(echo ""; (cat fio-benchmark-1.log | tail -5)) >> "$ReportName"

secondDrive=""
[[ -d /D ]] && secondDrive="/D"
[[ -d /mnt ]] && secondDrive="/mnt"
if [[ -n "$secondDrive" ]]; then
  Say "Disk Benchmark for SECOND Drive [$secondDrive]"
  sudo -E File-IO-Benchmark 'SECOND-Drive' "$secondDrive" 2G $(nproc)T 22 1 | tee fio-benchmark-2.log
  (echo ""; (cat fio-benchmark-2.log | tail -5)) >> "$ReportName"

  echo "";echo "";
  cat fio-benchmark-1.log | tail -5
fi

