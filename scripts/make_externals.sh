#!/bin/bash

if [ -r "$ROS_WORKSPACE/external/sbpl" ]; then
  cd $ROS_WORKSPACE/external/sbpl
  mkdir -p build
  cd build
  cmake ..
  make
  sudo make install
fi
