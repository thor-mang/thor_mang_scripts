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

# SETUP YOUR ENVIRONMENT HERE
export ONBOARD_LAUNCH_PKG="thor_mang_onboard_launch"
export UI_LAUNCH_PKG="thor_mang_ui_launch"
export GAZEBO_LAUNCH_PKG="thor_mang_gazebo"
export GAZEBO_DEFAULT_LAUNCH_FILE="start_all.launch"
export GAZEBO_WORLDS_PKG="thor_mang_gazebo"
export AUTOSTART_LAUNCH_PKG="thor_mang_robot_bringup"
export ROBOT_MASTER_HOSTNANE="motion"
export ROBOT_HOSTNAMES="motion perception onboard"
export ROBOT_USER="thor"

# THOR SPECIFIC EXPORTS
export GAZEBO_MODEL_PATH=$WS_ROOT/src/thor/thor_mang_simulation/thor_mang_gazebo/models
export THOR_MOTION_HOSTNAME="motion"
export THOR_PERCEPTION_HOSTNAME="perception"
export THOR_ONBOARD_HOSTNAME="perception"

# THOR PCs/LAUNCHES
add_remote_pc "motion" "motion" "motion" "roslaunch thor_mang_onboard_launch motion.launch"
add_remote_pc "perception" "perception" "perception" "export ROS_MASTER_URI=http://thor-motion:11311; export ROS_IP=192.168.1.11; roslaunch thor_mang_onboard_launch perception.launch"
add_remote_pc "onboard" "motion" "onboard" "export ROS_MASTER_URI=http://thor-motion:11311; export ROS_IP=192.168.1.11; roslaunch thor_mang_onboard_launch onboard.launch"
