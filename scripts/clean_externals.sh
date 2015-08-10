#!/bin/bash

# build and install sbpl by source
echo
echo ">>> Cleaning SPBL"
cd $THOR_ROOT/src/external/sbpl
rm -rf build
cd $THOR_ROOT

# build and install thor mang libs
echo
echo ">>> Cleaning THOR-MANG libs"
cd $THOR_ROOT/src/thor/thor_mang_libs
rm -rf build lib
cd $THOR_ROOT
