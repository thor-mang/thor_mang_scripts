#!/bin/bash

function thor_install() {
    rosinstall=$1
    shift

    if [[ "$rosinstall" = "--help" || -z "$rosinstall" ]]; then
        _thor_install_help
        return 0
    fi

    error=0

    while [[ ! -z "$rosinstall" ]]; do
        if [ -r "$THOR_ROOT/rosinstall/optional/${rosinstall}.rosinstall" ]; then
            local LAST_PWD=$PWD
            cd $THOR_ROOT/src
            wstool merge ../rosinstall/optional/${rosinstall}.rosinstall
            cd $LAST_PWD
        else
            error=1
        fi

        rosinstall=$1
        shift
    done

    if [ $error -ne 0 ]; then
        echo "Unknown rosinstall file: $rosinstall"
        _thor_install_help
        return 1
    fi

    return 0
}

function _thor_install_files() {
    local THOR_ROSINSTALL_FILES=()
 
    for i in `find -L $THOR_ROOT/rosinstall/optional/ -type f -name "*.rosinstall"`; do
        file=${i#$THOR_ROOT/rosinstall/optional/}
        file=${file%.rosinstall}
        if [ -r $i ]; then
            THOR_ROSINSTALL_FILES+=($file)
        fi
    done
    
    echo ${THOR_ROSINSTALL_FILES[@]}
}

function _thor_install_help() {
    echo "The following rosinstall files are available:"
    files=$(_thor_install_files)
    for i in ${files[@]}; do
        echo "   $i"
    done
}

function _thor_install_complete() {
    local cur

    if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
        return 0
    fi

    COMPREPLY=()
    _get_comp_words_by_ref cur

    if [[ "$cur" == -* ]]; then
        COMPREPLY=( $( compgen -W "--help" -- "$cur" ) )
    else
        COMPREPLY=( $( compgen -W "$(_thor_install_files)" -- "$cur" ) )
    fi

    return 0
} &&
complete -F _thor_install_complete thor_install
