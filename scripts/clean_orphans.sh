#!/bin/bash

cd $THOR_ROOT
catkin clean --orphans
echo " >>> If orphans were found, run 'thor make --force-cmake' now."



