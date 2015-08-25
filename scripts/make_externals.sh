#!/bin/bash

# build and install thor mang libs
echo
echo ">>> Building THOR-MANG libs"
cd $THOR_ROOT/src/thor/thor_mang_libs
make "$@"
cd $THOR_ROOT

