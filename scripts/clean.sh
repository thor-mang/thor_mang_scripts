#!/bin/bash

. $THOR_SCRIPTS/clean_externals.sh

cd $THOR_ROOT
rm -rf $THOR_ROOT/build

#rm -rf $THOR_ROOT/devel
# Remove everything in devel but keep setup.bash and the corresonding things so that the source in .bashrc still works
rm -rf $THOR_ROOT/devel/bin
rm -rf $THOR_ROOT/devel/etc
rm -rf $THOR_ROOT/devel/include
rm -rf $THOR_ROOT/devel/lib
rm -rf $THOR_ROOT/devel/share
rm $THOR_ROOT/devel/.catkin
rm $THOR_ROOT/devel/.rosinstall


