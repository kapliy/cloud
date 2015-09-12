#!/bin/bash

# expose munge
export PATH=$PATH:/home/slurm/munge/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/slurm/munge/lib

# expose slurm
export PATH=$PATH:/home/slurm/release/bin
