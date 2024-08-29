script=https://raw.githubusercontent.com/devizer/test-and-build/master/install-build-tools-bundle.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash > /dev/null
Say "Benchmark for [$(Get-CpuName)]"
7z b -mmt=1 -md=22

  if [[ "$(uname -s)" == Linux ]]; then
     echo >/dev/null
  elif [[ "$(uname -s)" == Darwin ]]; then
     brew install fio
     # install nproc
     echo '#!/usr/bin/env bash
           sysctl -n machdep.cpu.thread_count' | sudo tee /usr/local/bin/nproc > /dev/null
     sudo chmod +x /usr/local/bin/nproc
  elif [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
     choco install -y --no-progress fio
  else
    echo "Warning! Unknown OS"
  fi

Say "Disk Benchmark for [$HOME]"
export DISABLE_UNICODE=true
File-IO-Benchmark 'HOME' "$HOME" 1G $(nproc)T 20 1
