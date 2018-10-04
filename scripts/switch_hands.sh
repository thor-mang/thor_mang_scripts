#!/bin/bash

source $ROSWSS_BASE_SCRIPTS/helper/helper.sh

# check for reset command
if [ "$1" == "reset" ]; then
    if [ -f $ROSWSS_ROOT/.hands ]; then
        rm $ROSWSS_ROOT/.hands
    fi
    return
fi

# check for status command
if [ "$1" == "status" ]; then
    echo_info "Current robot hand setup:"
    echo "  Left hand type  = $L_HAND_TYPE"
    echo "  Right hand type = $R_HAND_TYPE"
    echo
    return
fi


# read arguments if given
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
    echo
done

# get hand type to set
while [ ! "$hand_type" == "v" ] && [ ! "$hand_type" == "r" ] && [ ! "$hand_type" == "n" ]; do
    echo -ne "Select type: (v)t_hand, (r)h_p12_rn or (n)one "
    read -N 1 hand_type
    echo
done

# dispatch hand type
case $hand_type in
    n)
        hand_type="none"
        l_hand_joints="none"
        r_hand_joints="none"
        ;;
    v)
        hand_type="vt_hand"
        l_hand_joints="l_f0_j0, l_f1_j0"
        r_hand_joints="r_f0_j0, r_f1_j0"
        ;;
    r)
        hand_type="rh_p12_rn"
        l_hand_joints="l_rh_p12_rn"
        r_hand_joints="r_rh_p12_rn"
        ;;
esac

# set hand type
if [ "$hand" == "b" ] || [ "$hand" == "l" ]; then
  export L_HAND_TYPE="$hand_type"
  export L_HAND_JOINTS="$l_hand_joints"
fi
if [ "$hand" == "b" ] || [ "$hand" == "r" ]; then
  export R_HAND_TYPE="$hand_type"
  export R_HAND_JOINTS="$r_hand_joints"
fi

echo_info "New robot hand setup:"
echo "  Left hand type  = $L_HAND_TYPE"
echo "  Right hand type = $R_HAND_TYPE"
echo

last_pwd=$PWD

# setup robot config
echo_info "Generation of custom robot config..."
roscd thormang3_manager/config
echo "### AUTOGENERATED FILE! DO NOT MODIFY! ###" > THORMANG3_generated.robot
cat hand_configs/THORMANG3_no_hands.robot >> THORMANG3_generated.robot
cat hand_configs/l_${L_HAND_TYPE}.robot >> THORMANG3_generated.robot
cat hand_configs/r_${R_HAND_TYPE}.robot >> THORMANG3_generated.robot
export ROBOT_SETUP="THORMANG3_generated"
echo_info "Done!"
echo

# create export file (for auto sourcing non-default config)
echo_info "Generation of export file..."
cat >$ROSWSS_ROOT/.hands <<EOF
#!/bin/bash
# automated generated file
export L_HAND_TYPE="$L_HAND_TYPE"
export L_HAND_JOINTS="$L_HAND_JOINTS"
export R_HAND_TYPE="$R_HAND_TYPE"
export R_HAND_JOINTS="$R_HAND_JOINTS"
export ROBOT_SETUP="$ROBOT_SETUP" 
EOF
echo_info "Done!"

cd $last_pwd