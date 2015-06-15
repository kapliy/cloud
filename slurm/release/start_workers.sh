#!/bin/bash

# use this script to (re)start all workers

for i in {1..6}; do
    ssh -o PreferredAuthentications=publickey bos-rndjob$i /home/slurm/release/bootstrap_worker.sh
done
