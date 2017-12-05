#!/bin/bash

function ui() {
    command="$1"
    shift

    if [[ "$command" == "help" || "$command" = "--help" || -z "$command" ]]; then
        _ui_help
        return 0
    fi

    path="$(rospack find thor_mang_ui_launch)"

    if [[ "$command" == "rqt" ]]; then
        if [[ -n "$1" ]]; then
            config="$1"
            shift
            roslaunch thor_mang_ui_launch rqt.launch rqt_perspective_path:=${path}/config/rqt/${config}.perspective "$@"
        else
            roslaunch thor_mang_ui_launch rqt.launch "$@"
        fi
        return 0
    elif [[ "$command" == "rviz" ]]; then
        if [[ -n "$1" ]]; then
            config="$1"
            shift
            roslaunch thor_mang_ui_launch rviz.launch rviz_profile_path:=${path}/config/rviz/${config}.rviz "$@"
        else
            roslaunch thor_mang_ui_launch rviz.launch "$@"
        fi
        return 0
    else
      roslaunch thor_mang_ui_launch ${command}.launch
      return 0
    fi

    echo "Unknown command: $command"
    _ui_help 
}

function _ui_rqt_config_files() {
    local ROSWSS_ROSINSTALL_FILES=()

    path="$(rospack find thor_mang_ui_launch)/config/rqt/"
 
    # find all rosinstall files
    for i in `find -L $path -type f -name "*.perspective"`; do
        file=${i#$path}
        file=${file%.perspective}
        if [ -r $i ]; then
            ROSWSS_ROSINSTALL_FILES+=($file)
        fi
    done
    
    echo ${ROSWSS_ROSINSTALL_FILES[@]}
}

function _ui_rviz_config_files() {
    local ROSWSS_ROSINSTALL_FILES=()

    path="$(rospack find thor_mang_ui_launch)/config/rviz/"

    # find all bash scripts
    for i in `find -L $path -type f -name "*.rviz"`; do
        file=${i#$path}
        file=${file%.rviz}
        if [ -r $i ]; then
            ROSWSS_ROSINSTALL_FILES+=($file)
        fi
    done
    
    echo ${ROSWSS_ROSINSTALL_FILES[@]}
}

function _ui_launch_files() {
    local ROSWSS_ROSINSTALL_FILES=()

    path="$(rospack find thor_mang_ui_launch)/launch/"
 
    # find all rosinstall files
    for i in `find -L $path -type f -name "*.launch"`; do
        file=${i#$path}
        file=${file%.launch}
        if [ -r $i ]; then
            ROSWSS_ROSINSTALL_FILES+=($file)
        fi
    done
    
    echo ${ROSWSS_ROSINSTALL_FILES[@]}
}

function _ui_commands() {
    local ROSWSS_COMMANDS=('help' 'rqt' 'rviz')
    
    echo ${ROSWSS_COMMANDS[@]}
}

function _ui_help() {
    echo "The following commands are available:"
    commands=$(_ui_commands)
    for i in ${commands[@]}; do
        echo "   $i"
    done
    echo

    echo "The following rqt perspectives are available:"
    commands=$(_ui_rqt_config_files)
    for i in ${commands[@]}; do
        echo "   $i"
    done
    echo

    echo "The following rviz defaults are available:"
    commands=$(_ui_rviz_config_files)
    for i in ${commands[@]}; do
        echo "   $i"
    done
    echo

    echo "The following launchfiles are available:"
    commands=$(_ui_launch_files)
    for i in ${commands[@]}; do
        echo "   $i"
    done
}

function _ui_complete() {
    local cur

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur

    # roswss <command>
    if [ $COMP_CWORD -eq 2 ]; then
        if [[ "$cur" == -* ]]; then
            COMPREPLY=( $( compgen -W "--help" -- "$cur" ) )
        else
            COMPREPLY=( $( compgen -W "$(_ui_commands) $(_ui_launch_files)" -- "$cur" ) )
        fi
    fi

    # usb_stick command <subcommand..>
    if [ $COMP_CWORD -eq 3 ]; then
        prev=${COMP_WORDS[2]}

        # default completion
        case $prev in
            rqt)
                COMPREPLY=( $( compgen -W "$(_ui_rqt_config_files)" -- "$cur" ) )
                ;;

            rviz)
                COMPREPLY=( $( compgen -W "$(_ui_rviz_config_files)" -- "$cur" ) )
                ;;

            *)
                COMPREPLY=()             
                ;;
        esac
    fi

    return 0
}
complete -F _ui_complete ui
