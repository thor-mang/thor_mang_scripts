#!/bin/bash

# clean thor mang libs
echo
echo ">>> Cleaning THOR-MANG libs"
cd $THOR_ROOT/src/thor/thor_mang_libs
rm -rf build lib
cd $THOR_ROOT
