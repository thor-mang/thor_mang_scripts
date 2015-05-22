#!/bin/bash
sudo /etc/init.d/chrony stop
sudo ntpdate thor-motion
sudo /etc/init.d/chrony start
