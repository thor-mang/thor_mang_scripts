#!/bin/bash
set -e

$THOR_SCRIPTS/revert.sh
$THOR_SCRIPTS/new-update.sh --no-merge
$THOR_SCRIPTS/make.sh
