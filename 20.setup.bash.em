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

# SETUP YOUR ENVIRONMENT HERE
export ONBOARD_LAUNCH_PKG="thor_mang_onboard_launch"
export GAZEBO_LAUNCH_PKG="thor_mang_gazebo"
export GAZEBO_LAUNCH_FILE="start_all.launch"
export GAZEBO_LAUNCH_W_ONBOARD_FILE="start_onboard_all.launch"
export GAZEBO_WORLDS_PKG="thor_mang_gazebo"
export AUTOSTART_LAUNCH_PKG="thor_mang_robot_bringup"
export ROBOT_MASTER_HOSTNANE="thor-motion"
export ROBOT_HOSTNAMES="thor-motion thor-perception thor-onboard"
export ROBOT_USER="thor"

# THOR SPECIFIC EXPORTS
export GAZEBO_MODEL_PATH=$WS_ROOT/src/thor/thor_mang_simulation/thor_mang_gazebo/models
export THOR_MOTION_HOSTNAME="thor-motion"
export THOR_PERCEPTION_HOSTNAME="thor-perception"
export THOR_ONBOARD_HOSTNAME="thor-perception"

# THOR PCs/LAUNCHES
add_remote_pc "motion" "thor-motion" "motion" "roslaunch thor_mang_onboard_launch motion.launch"
add_remote_pc "perception" "thor-perception" "perception" "export ROS_MASTER_URI=http://thor-motion:11311; export ROS_IP=192.168.1.11; roslaunch thor_mang_onboard_launch perception.launch"
add_remote_pc "onboard" "thor-motion" "onboard" "export ROS_MASTER_URI=http://thor-motion:11311; export ROS_IP=192.168.1.11; roslaunch thor_mang_onboard_launch onboard.launch"

# Custom completion scripts
add_completion "ui" "_ui_complete"
