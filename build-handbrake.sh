#!/bin/sh

set -e

git clone https://github.com/handbrake/handbrake.git
cd handbrake
./configure --cross=x86_64-w64-mingw32 --enable-qsv --enable-vce --enable-nvenc --enable-nvdec --enable-libdovi --enable-fdk-aac --launch-jobs=$(nproc) --launch
cp build/HandBrakeCLI.exe /out/