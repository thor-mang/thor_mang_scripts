#!/bin/bash

function thor_sim() {
    world=$1

    onboard=false

    # no arguments given
    if [ -z "$world" ]; then
        world="empty"
    # help requested
    elif [[ "$world" = "--help" ]]; then
        _thor_sim_help
        return 0
    # check arguments
    else
        shift
        # onboard start request was given
        if [[ "$world" = "onboard" ]]; then
            onboard=true
            world="empty"
        # otherwise world name was given; check for onboard parameter
        elif [[ "$1" = "onboard" ]]; then
            onboard=true
            shift
        fi
    fi

    error=0

    roscd thor_mang_gazebo
    if [ -z "world/${world}.world" ]; then
        echo "Unknown world file: $world"
        _thor_sim_help
        return 1
    elif [ "$onboard" = true ]; then
      roslaunch thor_mang_gazebo start_onboard_all.launch world_name:=$world "$@"
    else
      roslaunch thor_mang_gazebo start_all.launch world_name:=$world "$@"
    fi

    return 0
}

function _thor_sim_files() {
    local THOR_WORLD_FILES=()
 
    roscd thor_mang_gazebo

    for i in `find -L worlds/ -type f -name "*.world"`; do
        file=${i#worlds/}
        file=${file%.world}
        if [ -r $i ]; then
            THOR_WORLD_FILES+=($file)
        fi
    done
    
    echo ${THOR_WORLD_FILES[@]}
}

function _thor_sim_help() {
    echo "The following world files are available:"
    files=$(_thor_sim_files)
    for i in ${files[@]}; do
        echo "   $i"
    done

    echo "Append 'onboard' to start onboard software as well. ROS parameters has to go at the end."
}

function _thor_sim_complete() {
    local cur

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W "--help" -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W "$(_thor_sim_files)" -- "$cur" ) )
    fi

    return 0
} &&
complete -F _thor_sim_complete thor_sim
