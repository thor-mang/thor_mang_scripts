#!/bin/bash
sudo echo
versions="2, 4, 5, 6, 7"
valid_version=false
while [ "$valid_version" = false ]; do
  read -p "Which version of gazebo do you want to install? (2, 4, 5, 6, 7) " version
  if [[ $versions =~ $version ]]; then
    valid_version=true
  else
    echo "Invalid gazebo version number. Enter 2, 4, 5, 6 or 7."
  fi
done

read -p "Are you sure that you want to remove your current gazebo version and install gazebo$version instead? [y/n] " answer

if test "$answer" != "y"; then
  exit
fi

echo "Installing gazebo$version.."

sudo sh -c 'echo "deb http://packages.osrfoundation.org/gazebo/ubuntu trusty main" > /etc/apt/sources.list.d/gazebo-latest.list'
wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -

sudo apt-get update

sudo apt-get remove -y gazebo*

sudo apt-get install -y gazebo$version
if test "$version" == "2"; then
  sudo apt-get install -y libsdformat1
  sudo apt-get install -y ros-indigo-gazebo-ros \
  ros-indigo-gazebo-ros-control \
  ros-indigo-gazebo-plugins
else
  sudo apt-get install -y ros-indigo-gazebo$version-ros \
  ros-indigo-gazebo$version-ros-control \
  ros-indigo-gazebo$version-plugins
fi

sudo apt-get autoremove -y
