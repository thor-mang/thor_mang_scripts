#!/bin/bash

source $ROSWSS_BASE_SCRIPTS/helper/helper.sh

if [ ! -z "$1" ]; then
    hand="$1"
    shift
else
    hand=""
fi

if [ ! -z "$1" ]; then
    hand_type="$1"
    shift
else
    hand_type=""
fi

# get which hand(s) to be swapped
while [ ! "$hand" == "l" ] && [ ! "$hand" == "r" ] && [ ! "$hand" == "b" ]; do
    echo -ne "Do you want to change (l)eft, (r)ight or (b)oth hands? "
    read -N 1 hand
done
echo

# get hand type to set
while [ ! "$hand_type" == "v" ] && [ ! "$hand_type" == "r" ] && [ ! "$hand_type" == "n" ]; do
    echo -ne "Select type: (v)t_hand, (r)h_p12_rn or (n)one "
    read -N 1 hand_type
done
echo

case $hand_type in
    n)
        hand_type="none"
        ;;
    v)
        hand_type="vt_hand"
        ;;
    r)
        hand_type="rh_p12_rn"
        ;;
esac

# set hand type
if [ "$hand" == "b" ] || [ "$hand" == "l" ]; then
  export L_HAND_TYPE="$hand_type"
fi
if [ "$hand" == "b" ] || [ "$hand" == "r" ]; then
  export R_HAND_TYPE="$hand_type"
fi

echo "New robot hand setup:"
echo "  Left hand type  = $L_HAND_TYPE"
echo "  Right hand type = $R_HAND_TYPE"
echo

# regenerate URDF model
echo_info "Regenerating URDF model..."
last_pwd=$PWD
roscd thormang3_description/urdf
rosrun xacro xacro --inorder -o johnny5.urdf thormang3.xacro robot_name:="johnny5" l_hand_type:=$L_HAND_TYPE r_hand_type:=$R_HAND_TYPE
echo_info "Done!"
echo
cd $last_pwd

# setup robot config
echo_info "Generation of custom robot config..."
roscd thormang3_manager/config
cat hand_configs/THORMANG3_no_hands.robot > THORMANG3_gen.robot
cat hand_configs/l_${L_HAND_TYPE}.robot >> THORMANG3_gen.robot
cat hand_configs/r_${R_HAND_TYPE}.robot >> THORMANG3_gen.robot
export ROBOT_SETUP="THORMANG3_gen"
echo_info "Done!"
