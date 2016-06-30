#!/bin/bash

# This script is for removing packages that were part of a workspace,
# but are not needed anymore. Manual removal is very cumbersome.

# Example:
#. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor/thor_mang_footstep_planning/thor_mang_footstep_planning_msgs

. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor/biped_state_estimator

. $THOR_SCRIPTS/rm_from_workspace.sh $THOR_ROOT/src/thor/robot_transforms
