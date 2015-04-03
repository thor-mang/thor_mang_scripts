#!/bin/bash

if [ -z "$1" ]; then
    export THOR_ROBOT_TYPE="thor_mang_hands"
    export THOR_LEFT_HAND_TYPE="l_vt_hand"
    export THOR_RIGHT_HAND_TYPE="r_vt_hand"
else
    if [ -z "$2" ]; then
        echo "Need to give two hands, left and right (e.g. thor hands l_stump r_stump)"
        return
    else
        export THOR_ROBOT_TYPE="thor_mang_hands"
        export THOR_LEFT_HAND_TYPE=$1
        export THOR_RIGHT_HAND_TYPE=$2
    fi

fi

echo "  Robot type      = "$THOR_ROBOT_TYPE
echo "  Left hand type  = "$THOR_LEFT_HAND_TYPE
echo "  Right hand type = "$THOR_RIGHT_HAND_TYPE
