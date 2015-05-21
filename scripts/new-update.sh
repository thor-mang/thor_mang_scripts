#!/bin/bash

set -e -u

option=${1:-none}

# ---------------------------------------------------------------------------

# Pull custom repos
repos=" \
$THOR_ROOT \
$THOR_ROOT/rosinstall/optional/custom \
$THOR_SCRIPTS \
$THOR_SCRIPTS/custom \
"

for repo in $repos
do
	if [ -d $repo ] && [ -d $repo/.git ]
	then
		echo "Updating Repository in $repo"
		cd $repo
		git pull
		echo
	fi
done

# ---------------------------------------------------------------------------

echo "Remove obsolete packages..."
$THOR_SCRIPTS/rm_obsolete_packages.sh
echo

#echo ">>> Checking package updates"
#./rosinstall/install_scripts/install_package_dependencies.sh
#echo

# ---------------------------------------------------------------------------

# Merge updates
cd $THOR_ROOT
echo ">>> Merging rosinstall files"
for file in $THOR_ROOT/rosinstall/*.rosinstall
do
	filename=$(basename ${file%.*})
	if [ -n "${THOR_MANG_NO_SIM:-}" ] && [ $filename == "thor_mang_simulation" ]
	then
		continue;
	else
		if [ ! "$option" = "--no-merge" ]
		then
			echo "Merging to workspace: '$filename'.rosinstall"
			wstool merge $file -y
		fi
	fi
done
echo


# ---------------------------------------------------------------------------

# Include user data
if [ -f ~/.torcuser ]
then
	# Include user data
	. ~/.torcuser

	# Create build folder if neccessary
	if [ ! -d "$THOR_ROOT/build" ]; then mkdir -v -p $THOR_ROOT/build; fi

	# Create expect file and run wstool stuff
	cat > $THOR_ROOT/build/thor-update_expect <<EOF
	spawn wstool update
	expect "Username for 'https://external.torcrobotics.com'"
	send "$TORC_USER\r\n"
	expect "Password for 'https://$TORC_USER@external.torcrobotics.com'"
	send "$TORC_PASS\r\n"
	interact
EOF

	# Run expect file
	cd $THOR_ROOT/src
	expect $THOR_ROOT/build/thor-update_expect

else
	wstool update

fi

