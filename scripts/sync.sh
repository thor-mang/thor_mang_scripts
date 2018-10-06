#!/bin/bash

source $ROSWSS_BASE_SCRIPTS/helper/helper.sh

apt_install chrony ntpdate

sudo ntpdate de.pool.ntp.org
