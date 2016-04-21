#!/bin/bash

function thor() {
    command=$1
    shift

    if [[ "$command" = "--help" || -z "$command" ]]; then
        _thor_help
        return 0
    fi

    if [ -x "$THOR_SCRIPTS/${command}.sh" ]; then
        $THOR_SCRIPTS/${command}.sh "$@"
        return
    elif [ -r "$THOR_SCRIPTS/${command}.sh" ]; then
        source $THOR_SCRIPTS/${command}.sh "$@"
        return
    else
        echo "Unknown thor command: $command"
        _thor_help 
    fi

    return 1
}

function _thor_commands() {
    local THOR_COMMANDS=()

    for i in `find $THOR_SCRIPTS/ -type f -name "*.sh"`; do
        command=${i#$THOR_SCRIPTS/}
        command=${command%.sh}
        if [[ "$command" == "completion/"* ]]; then
            continue
        elif [ -r $i ]; then
            THOR_COMMANDS+=($command)
        fi
    done
    
    echo ${THOR_COMMANDS[@]}
}

function _thor_help() {
    echo "The following commands are available:"

    commands=$(_thor_commands)
    for i in ${commands[@]}; do
        if [ -x "$THOR_SCRIPTS/$i.sh" ]; then
            echo "   $i"
        elif [ -r "$THOR_SCRIPTS/$i.sh" ]; then
            echo "  *$i"
        fi
    done

    echo
    echo "(*) Commands marked with * may change your environment."
}

function _thor_complete() {
    local cur
    local prev

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur prev

    # thor <command>
    if [ $COMP_CWORD -eq 1 ]; then
        if [[ "$cur" == -* ]]; then
            COMPREPLY=( $( compgen -W '--help' -- "$cur" ) )
        else
            COMPREPLY=( $( compgen -W "$(_thor_commands)" -- "$cur" ) )
        fi
    fi

    # thor command <subcommand..>
    if [ $COMP_CWORD -ge 2 ]; then
        case ${COMP_WORDS[1]} in
            install)
                _thor_install_complete
                ;;

            uninstall)
                _thor_uninstall_complete
                ;;

            launch)
                if [[ "$cur" == -* ]]; then
                    COMPREPLY=( $( compgen -W "--screen" -- "$cur" ) )
                fi

                COMP_WORDS=( roslaunch thor_mang_onboard_launch $cur )
                COMP_CWORD=2
                _roscomplete_launch
                ;;

            make|update)
                _roscomplete
                ;;

            master)
                COMPREPLY=( $( compgen -W "localhost $ROBOT_HOSTNAMES" -- "$cur" ) )
                ;;

            motion)
                _thor_motion_complete
                ;;

            perception)
                _thor_perception_complete
                ;;
                
            onboard)
                _thor_onboard_complete
                ;;
                
            field)
                _thor_field_complete
                ;;

            screen)
                COMPREPLY=( $( compgen -W "start stop show" -- "$cur" ) )
                ;;
                
            test)
                _thor_test_complete
                ;;

            *)
                COMPREPLY=()             
                ;;
        esac
    fi
} &&
complete -F _thor_complete thor
