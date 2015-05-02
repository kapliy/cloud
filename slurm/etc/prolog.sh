#!/bin/sh
#
# Sample TaskProlog script that will print a batch job's
# job ID and node list to the job's stdout
#

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "print =========================================="
  echo "print SLURM_JOB_USER = $SLURM_JOB_USER"
  echo "print SLURM_JOB_ID = $SLURM_JOB_ID"
  echo "print SLURM_TASK_PID = $SLURM_TASK_PID"
  echo "print =========================================="
fi
