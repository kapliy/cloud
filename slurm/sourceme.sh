#!/bin/bash

# appends PATH and LD_LIBRARY_PATH to expose munge
export PATH=$PATH:/home/slurm/munge/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/slurm/munge/lib

# appends PATH to expose slurm
export PATH=$PATH:/home/slurm/release/bin

# appends PYTHONPATH to expose ClusterRunner
export PYTHONPATH=$PYTHONPATH:/home/slurm/ws/aam/branches/akapliy/

export RUNNER=/home/slurm/ws/aam/branches/akapliy/ClusterRunner/ClusterRunner.py
