#!/bin/bash

if [ -r "$ROS_WORKSPACE/external/sbpl/build" ]; then
  cd $ROS_WORKSPACE/external/sbpl/build
  sudo xargs rm < install_manifest.txt
  cd ..
  rm -rf build
fi
