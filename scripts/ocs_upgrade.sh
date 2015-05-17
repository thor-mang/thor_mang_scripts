#!/bin/bash

$THOR_SCRIPTS/revert.sh
$THOR_SCRIPTS/update.sh --no-merge
$THOR_SCRIPTS/make.sh
