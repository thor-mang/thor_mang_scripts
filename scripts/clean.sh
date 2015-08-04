#!/bin/bash

cd $THOR_ROOT

# Confirmation prompt before deleting?

if [ "$#" -lt 1 ]; then
  . $THOR_SCRIPTS/clean_externals.sh
  catkin clean --all
else 
  command=$1
  if [ $command == "externals" ]; then
    . $THOR_SCRIPTS/clean_externals.sh
  else
    catkin clean "$@"
  fi
fi


