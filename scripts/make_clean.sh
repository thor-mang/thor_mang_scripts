#!/bin/bash
set -e

$THOR_SCRIPTS/clean.sh
$THOR_SCRIPTS/make.sh "$@"
