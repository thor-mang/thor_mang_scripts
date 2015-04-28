#!/bin/bash

# build and install sbpl by source
echo
echo ">>> Building SPBL"
cd $THOR_ROOT/src/external/sbpl
mkdir -p build
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
cd $THOR_ROOT

# build and install thor mang libs
echo
echo ">>> Building THOR-MANG libs"
cd $THOR_ROOT/src/thor_mang/thor_mang_libs
make
cd $THOR_ROOT

