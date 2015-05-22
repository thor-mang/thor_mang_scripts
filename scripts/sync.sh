#!/bin/bash
/etc/init.d/chrony stop
ntpdate thor-motion
/etc/init.d/chrony start
