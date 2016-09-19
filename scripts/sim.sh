#!/bin/bash

if [[ "$1" = "onboard" ]]; then
    shift
    roslaunch thor_mang_gazebo start_onboard_all.launch "$@"
else
    roslaunch thor_mang_gazebo start_all.launch "$@"
fi
