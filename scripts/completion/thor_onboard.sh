#!/bin/bash

function thor_onboard() {
    command=$1
    shift

    if [[ "$command" == "--help" || -z "$command" ]]; then
        _thor_onboard_help
        return 0
    fi

    # check if first a ssh connection to thor-onboard is required/requested
    if [ $command = 'ssh' ]; then
        if [ $(hostname) = $THOR_ONBOARD_HOSTNAME ]; then
            echo "You are already on $THOR_ONBOARD_HOSTNAME!"
        else
            thor ssh $THOR_ONBOARD_HOSTNAME
        fi
    elif [ ! $(hostname) = $THOR_ONBOARD_HOSTNAME ]; then
        thor ssh $THOR_ONBOARD_HOSTNAME "thor onboard $command $@"

    # we are on thor-onboard
    else
        if [ $command == "start" ]; then
            thor screen start "onboard" "roslaunch thor_mang_onboard_launch onboard_all.launch $@"
        elif [ $command == "stop" ]; then
            thor screen stop "onboard" "$@"
        elif [ $command == "show" ]; then
            thor screen show "onboard" "$@"
        elif [ -x "$THOR_SCRIPTS/${command}.sh" ]; then
            thor $command "$@"
        else
            $command "$@"
        fi
    fi

    return 0
}

function _thor_onboard_commands() {
    local THOR_COMMANDS=("start" "stop" "show")

    commands=$(_thor_commands)
    for i in ${commands[@]}; do
        if [ $i == "onboard" ]; then
            continue
        fi
        THOR_COMMANDS+=($i)
    done
    
    echo ${THOR_COMMANDS[@]}
}

function _thor_onboard_help() {
    echo "The following commands are available:"

    commands=$(_thor_onboard_commands)
    for i in ${commands[@]}; do       
        if [ $i == "start" ]; then
            echo "   $i"
        elif [ $i == "stop" ]; then
            echo "   $i"
        elif [ $i == "show" ]; then
            echo "   $i"
        elif [ -x "$THOR_SCRIPTS/$i.sh" ]; then
            echo "   $i"
        elif [ -r "$THOR_SCRIPTS/$i.sh" ]; then
            echo "  *$i"
        fi
    done

    echo
    echo "(*) Commands marked with * may change your environment."
}

function _thor_onboard_complete() {
    local cur
    local prev

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur prev

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W "--help" -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W "$(_thor_onboard_commands)" -- "$cur" ) )
    fi
} &&
complete -F _thor_onboard_complete thor_onboard
