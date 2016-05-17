#!/bin/bash

function merge {
    local=$1
    local_branch=$2
    remote=$3
    remote_branch=$4

    if [[ "$#" -ne 4 ]]; then
        echo "Illegal number of arguments given!"
        return 0
    fi

    echo ">>> Merging '$local' with remote from $remote ..."

    if [ ! -d $THOR_ROOT/src/thor/robotis/$local ] ; then
        echo "Error: '$THOR_ROOT/src/thor/robotis/$local' does not exist!"
    fi

    cd $THOR_ROOT/src/thor/robotis/$local

    # save current checked out branch
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="(unnamed branch)"     # detached HEAD
    branch_name=${branch_name##refs/heads/}

    # switch to master
    if [[ ! "$branch_name" = "$local_branch" ]]; then
        if ! git checkout --quiet $local_branch; then
            echo "<<< ... FAILED!"
            return 1
        fi
    fi
    git pull --quiet

    # check if Robotis remote was added
    if ! git remote | grep -q robotis; then
        git remote add robotis $remote        
    fi

    # fetch Robotis remote
    git fetch --quiet robotis
    
    # merge with Robotis remote
    git merge robotis/$remote_branch

    # push to mirror
    git push origin $local_branch

    # switch back branch
    git checkout --quiet $branch_name

    echo "<<< ... Done!"

    return 0
}

merge common master https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Common.git master
merge framework master https://github.com/ROBOTIS-GIT/ROBOTIS-Framework.git master
merge mpc master https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-MPC.git master
merge opc master https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-OPC.git master
merge ppc master https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-PPC.git master
merge tools master https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Tools.git master
