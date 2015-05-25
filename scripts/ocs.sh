#!/bin/bash
command=$1
shift
if [ $command == "primary" ]; then
  echo "Starting primary ocs"
  roslaunch thor_mang_ocs primary_ocs.launch "$@"
elif [ $command == "perception" ]; then
  echo "Starting perception ocs"
  roslaunch thor_mang_ocs perception_ocs.launch  
  thor master ocs-primary
elif [ $command == "behavior" ]; then
  echo "Starting behavior ocs"
  roslaunch thor_mang_ocs behavior_ocs.launch
  thor master ocs-primary
elif [ $command == "driving" ]; then
  echo "Starting driving widget"
  roslaunch thor_mang_driving_widget driving_widget.launch
else
  roslaunch thor_mang_ocs thor_mang_ocs.launch
fi
