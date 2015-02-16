#!/bin/bash

# install sbpl by source
cd $THOR_ROOT/src/external/sbpl
if [ ! -d "build" ]; then
    mkdir build
fi
cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
sudo make install
cd $THOR_ROOT
