#!/bin/bash
set -e

$THOR_SCRIPTS/update.sh
$THOR_SCRIPTS/make.sh "$@"
