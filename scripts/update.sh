#!/bin/bash

echo

# Takes us to scripts which is inside workspace, so that's good enough
# for wstool to work
cd $THOR_SCRIPTS

# Remove obsolete stuff using wstool
$THOR_SCRIPTS/rm_obsolete_packages.sh

cd $THOR_ROOT
echo ">>> Pulling install folder in $THOR_ROOT"
git pull
echo

#echo ">>> Checking package updates"
#./rosinstall/install_scripts/install_package_dependencies.sh
#echo

if [ -d $THOR_ROOT/rosinstall/optional/custom/.git ]; then
    echo ">>> Pulling custom rosinstalls"
    cd $THOR_ROOT/rosinstall/optional/custom
    git pull
    echo
fi

if [ -d $THOR_SCRIPTS/custom/.git ]; then
    echo ">>> Pulling custom scripts"
    cd $THOR_SCRIPTS/custom
    git pull
    echo
fi

cd $THOR_ROOT
echo ">>> Merging rosinstall files"
for file in $THOR_ROOT/rosinstall/*.rosinstall; do
    filename=$(basename ${file%.*})
    if [ -n "$THOR_MANG_NO_SIM" ] && [ $filename == "thor_mang_simulation" ]; then
        continue;
    else
        echo "Merging to workspace: '$filename'.rosinstall"
        wstool merge $file -y
    fi
done
echo

echo ">>> Updating catkin workspace"
cd $THOR_ROOT/src
wstool update
