#!/bin/bash

# DO NOT REMOVE THIS BLOCK UNLESS YOU DON'T WANT TO USE CUSTOM SCRIPTS
@[if DEVELSPACE]@
export ROSWSS_SCRIPTS="@(PROJECT_SOURCE_DIR)/scripts:$ROSWSS_SCRIPTS"
@[else]@
export ROSWSS_SCRIPTS="@(CMAKE_INSTALL_PREFIX)/@(CATKIN_PACKAGE_SHARE_DESTINATION)/scripts:$ROSWSS_SCRIPTS"
@[end if]@

# SET HERE YOUR WORKSPACE PREFIX
export ROSWSS_PREFIX="thor"
export ROSWSS_ROOT_RELATIVE_PATH="../.."
export ROSWSS_INSTALL_DIR="rosinstall"

# SETUP YOUR ENVIRONMENT HERE (all fields are optional)
export ONBOARD_LAUNCH_PKG="thor_mang_onboard_launch"
export UI_LAUNCH_PKG="thor_mang_ui_launch"
export GAZEBO_LAUNCH_PKG="thor_mang_gazebo"
export GAZEBO_DEFAULT_LAUNCH_FILE="johnny5.launch"
export AUTOSTART_LAUNCH_PKG="thor_mang_robot_bringup"
export ROBOT_MASTER_HOSTNAME="motion"
export ROBOT_HOSTNAMES="motion perception"
export ROBOT_USER="thor"

# THOR PCs/LAUNCHES
# Syntax:
#   add_remote_pc "<script_name>" "<host_name>" "<screen_name>" "<command>"
add_remote_pc "motion" "motion" "motion_start" "~/thor/src/thor/thor_mang_robot_bringup/scripts/motion.sh"
add_remote_pc "perception" "perception" "perception_start" "~/thor/src/thor/thor_mang_robot_bringup/scripts/perception.sh"
add_remote_pc "onboard" "motion" "onboard_start" "~/thor/src/thor/thor_mang_robot_bringup/scripts/onboard.sh"
add_remote_pc "robot_basics" "motion" "robot_basics_start" "~/thor/src/thor/thor_mang_robot_bringup/scripts/robot_basics.sh"
