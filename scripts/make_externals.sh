#!/bin/bash

if [ -r "$ROS_WORKSPACE/external/sbpl" ]; then
  cd $ROS_WORKSPACE/external/sbpl
  mkdir -p build
  cd build
  cmake ..
  sudo make install
fi
