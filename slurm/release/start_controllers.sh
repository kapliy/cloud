#!/bin/bash

# use this script to (re)start all workers

for i in {3..4}; do
    ssh -o PreferredAuthentications=publickey bos-rndjob$i /home/slurm/release/bootstrap_server.sh
    sleep 2
done
