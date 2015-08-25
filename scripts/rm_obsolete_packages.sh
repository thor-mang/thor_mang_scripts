#!/bin/bash

# This script is for removing packages that were part of a workspace,
# but are not needed anymore. Manual removal is very cumbersome.

. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/dynamixel_pro_driver
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_simple_joint_pan
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_manipulation_planning
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_planning_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_perception_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_lidar_proc
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_perception
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_ocs_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_templates
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/flor_rviz
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_footstep_planning
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_footstep_planner
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang_vigir_integration
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_driving
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_perception
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/flor_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_manipulation_planning
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_geometric_shapes
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/robot_self_filter
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_tud_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_ui
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_vigir_integration
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_simulation
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang_launch
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_footstep_planning/thor_mang_footstep_planner
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_footstep_planning/thor_mang_footstep_planning_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_ros_control
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_vt_hand_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_footstep_planning/vigir_footstep_planning_core
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_perception_github
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_footstep_planning/vigir_footstep_planning_basics
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_footstep_planning/vigir_footstep_planning_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_footstep_planning/vigir_terrain_classifier
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_force_torque_tools
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_grasp_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_humanoid_control_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_lidar_proc
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_object_template_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_sandbox
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_perception_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_planning_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_simple_joint_pan
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_teleop_planning_msgs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/external/vigir_utilities
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_libs
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_behaviors
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_smach_engine
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/executive_smach
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_interactive_marker_pose_server
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_compliant_control_launch
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/humanoid_joystick
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang/thor_mang_demo
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_comms
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_ocs_common
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/flor_rviz
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_templates
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_ocs_eui
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/vigir_grasp_control
. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor_mang_scripts
>>>>>>> package_moving
