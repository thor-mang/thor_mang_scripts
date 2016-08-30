#!/bin/bash
set -e

debug=false
if [ "$1" == "debug" ]; then
  shift
  debug=true
fi

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

if [ $change_dir == true ] ; then
  cd $THOR_ROOT
fi

args="$@"
if [ $debug == true ]; then
  echo
  echo "--------------------- Debug build ---------------------"
  args="-DCMAKE_BUILD_TYPE=Debug $args"
else
  echo "-------------------- Default build --------------------"
fi

echo ">>> Building with arguments '$args'"
echo "-------------------------------------------------------"
echo

catkin build "$args"

. $THOR_ROOT/setup.bash

