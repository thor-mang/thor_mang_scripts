#!/bin/bash

. $THOR_ROOT/setup.bash

package=$1

# update package only if given
if [[ ! -z "$package" ]]; then
    roscd $package
    git pull
# otherwise perform full update
else
    sudo echo

    echo ">>> Pulling install folder in $THOR_SCRIPTS"
    cd $THOR_SCRIPTS
    git pull

    # Remove obsolete stuff using wstool
    $THOR_SCRIPTS/rm_obsolete_packages.sh

    echo ">>> Pulling install folder in $THOR_ROOT"
    cd $THOR_ROOT
    git pull
    echo

    echo ">>> Checking package updates"
    ./rosinstall/install_scripts/install_package_dependencies.sh
    echo

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
        echo "Merging to workspace: $filename.rosinstall"
        wstool merge $file -y
    done
    echo

    echo ">>> Updating catkin workspace"
    cd $THOR_ROOT/src
    wstool update

    echo ">>> Installing package dependencies"
    $THOR_ROOT/rosinstall/install_scripts/install_package_dependencies.sh
fi
