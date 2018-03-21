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

    echo ">>> Merging '$local ($local_branch)' with remote from '$remote ($remote_branch)' ..."

    if [ ! -d $ROSWSS_ROOT/src/thor/robotis/$local ] ; then
        echo "Error: '$ROSWSS_ROOT/src/thor/robotis/$local' does not exist!"
    fi

    cd $ROSWSS_ROOT/src/thor/robotis/$local

    # save current checked out branch
    branch_name="$(git symbolic-ref HEAD 2>/dev/null)" ||
    branch_name="(unnamed branch)"     # detached HEAD
    branch_name=${branch_name##refs/heads/}

    # switch to local branch
    if [[ "$branch_name" != "$local_branch" ]]; then
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

    # push tags
    git push --tags

    echo "<<< ... Done!"

    return 0
}

echo "-------------------------------"
echo ">>> Syncing master branches <<<"
echo "-------------------------------"
echo

merge dynamixel_sdk           master  https://github.com/ROBOTIS-GIT/DynamixelSDK.git             master
merge common                  master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Common.git  master
merge math                    master  https://github.com/ROBOTIS-GIT/ROBOTIS-Math.git             master
merge thormang_msgs           master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-msgs.git    master
merge framework_msgs          master  https://github.com/ROBOTIS-GIT/ROBOTIS-Framework-msgs.git   master
merge framework               master  https://github.com/ROBOTIS-GIT/ROBOTIS-Framework.git        master
merge tools                   master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Tools.git   master
merge mpc                     master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-MPC.git     master
merge opc                     master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-OPC.git     master
merge ppc                     master  https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-PPC.git     master
merge rh_p12_rn_description   master  https://github.com/ROBOTIS-GIT/RH-P12-RN.git                master

echo
echo "--------------------------------"
echo ">>> Syncing robotis branches <<<"
echo "--------------------------------"
echo

merge dynamixel_sdk             robotis https://github.com/ROBOTIS-GIT/DynamixelSDK.git             kinetic-devel
merge common                    robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Common.git  kinetic-devel
merge math                      robotis https://github.com/ROBOTIS-GIT/ROBOTIS-Math.git             kinetic-devel
merge thormang_msgs             robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-msgs.git    kinetic-devel
merge framework_msgs            robotis https://github.com/ROBOTIS-GIT/ROBOTIS-Framework-msgs.git   kinetic-devel
merge framework                 robotis https://github.com/ROBOTIS-GIT/ROBOTIS-Framework.git        kinetic-devel
merge tools                     robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-Tools.git   master
merge mpc                       robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-MPC.git     kinetic-devel # master
merge opc                       robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-OPC.git     master
merge ppc                       robotis https://github.com/ROBOTIS-GIT/ROBOTIS-THORMANG-PPC.git     kinetic-devel
merge rh_p12_rn_description     robotis https://github.com/ROBOTIS-GIT/RH-P12-RN.git                kinetic-devel
