script=https://raw.githubusercontent.com/devizer/test-and-build/master/install-build-tools-bundle.sh; (wget -q -nv --no-check-certificate -O - $script 2>/dev/null || curl -ksSL $script) | bash > /dev/null
Say "Hello"
echo "CPU: $(Get-CpuName)"

Say "CPU Benchmark"
7z b -mmt=1 -md=22

Say "Disk Benchmark for $HOME"
File-IO-Benchmark 'HOME' "$HOME" 1G 20 1
