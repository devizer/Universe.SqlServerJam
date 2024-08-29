script=https://raw.githubusercontent.com/devizer/test-and-build/master/install-build-tools-bundle.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash > /dev/null
Say "Benchmark for [$(Get-CpuName)]"
7z b -mmt=1 -md=22

  if [[ "$(uname -s)" == Linux ]]; then
     echo >/dev/null
  elif [[ "$(uname -s)" == Darwin ]]; then
     brew install fio
  elif [[ "$(uname -s)" == *"MINGW"* ]] || [[ "$(uname -s)" == *"MSYS"* ]]; then
     choco --version
     choco install -y --no-progress fio
  else
    echo "Unknown OS"
  fi


Say "Disk Benchmark for [$HOME]"
export DISABLE_UNICODE=true
File-IO-Benchmark 'HOME' "$HOME" 1G 20 1
