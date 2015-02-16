#!/bin/bash

git_status () {
  echo "> in $PWD ..."
  git status | grep "On branch"
  git status | grep "modified"
  git status | grep "branch is ahead"
  git status | grep "Untracked files"
}

echo ">>> Looking for locally modified files in install ..."
echo
cd ${THOR_ROOT}
git_status
echo

if [ -d $THOR_ROOT/rosinstall/optional/custom/.git ]; then
    echo ">>> Looking for locally modified custom rosinstalls"
    echo
    cd $THOR_ROOT/rosinstall/optional/custom
    git_status
    echo
fi

echo ">>> Looking for locally modified files in ${ROS_WORKSPACE} ..."
echo
for d in `find ${ROS_WORKSPACE} -mindepth 1 -type d`;
do
  cd $d
  if [ -d "$d/.git" ]; then
    git_status
    echo
  fi
done

echo "Done!"
