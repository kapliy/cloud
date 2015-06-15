#!/bin/bash

# spawns a user-owned munged daemon

# create necessary directories for the daemon
mkdir -p /tmp/lib/munge
mkdir -p /tmp/run/munge
mkdir -p /tmp/log/munge

# kill any existing daemon
pkill munged

# start a new daemon
/home/slurm/munge/sbin/munged -f --num-threads=10 --key-file=/home/slurm/munge/etc/munge/munge.key
