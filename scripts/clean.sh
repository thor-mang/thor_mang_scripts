#!/bin/bash

cd $THOR_ROOT

# Confirmation prompt before deleting?

if [ "$#" -lt 1 ]; then
  echo -n "Do you want to clean devel and build? [y/n] "
  read -N 1 REPLY
  echo
  if test "$REPLY" = "y" -o "$REPLY" = "Y"; then
    . $THOR_SCRIPTS/clean_externals.sh
    catkin clean --all
    echo " >>> Cleaned devel and build directories."
  else
    echo " >>> Clean cancelled by user."
  fi
else 
  command=$1
  if [ $command == "externals" ]; then
    . $THOR_SCRIPTS/clean_externals.sh
  else
    catkin clean "$@"
  fi
fi


