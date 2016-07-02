#!/bin/bash
set -e

if [ "$#" -lt 1 ]; then
  . $THOR_SCRIPTS/make_externals.sh
fi

change_dir=true
for var in "$@"
do
	if [ "$var" == "--this" ]; then
		change_dir=false
    break
  fi
done

if [ "$change_dir" = true ] ; then
  cd $THOR_ROOT
fi
echo "Building with arguments $@"
catkin build "$@"

. $THOR_ROOT/setup.bash

