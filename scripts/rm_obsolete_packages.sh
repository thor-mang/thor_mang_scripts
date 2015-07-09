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
