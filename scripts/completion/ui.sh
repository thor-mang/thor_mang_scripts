#!/bin/bash

function _ui_complete() {
    COMP_WORDS=( roslaunch thor_mang_ui_launch $cur )
    COMP_CWORD=2
    _roscomplete_launch
}
