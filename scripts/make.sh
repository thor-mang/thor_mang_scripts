#!/bin/bash
set -e

if [ "$#" -lt 1 ]; then
  . $THOR_SCRIPTS/make_externals.sh
fi

cd $THOR_ROOT
catkin build "$@"
