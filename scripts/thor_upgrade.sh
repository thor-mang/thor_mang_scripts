#!/bin/bash

set -e

rosclean purge
$THOR_SCRIPTS/revert.sh
$THOR_SCRIPTS/new-update.sh
$THOR_SCRIPTS/make.sh

