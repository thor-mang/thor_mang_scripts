#!/bin/bash
set -e

. $THOR_SCRIPTS/make_externals.sh "$@"

cd $THOR_ROOT
catkin_make "$@"
