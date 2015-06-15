#!/bin/sh
#
# Sample TaskProlog script that will print a batch job's
# job ID and node list to the job's stdout
#

if [ X"$SLURM_STEP_ID" = "X" -a X"$SLURM_PROCID" = "X"0 ]
then
  echo "print =========================================="
  echo "print JOB_NAME = $SLURM_JOB_NAME"
  echo "print JOB_USER = $SLURM_JOB_USER"
  echo "print JOB_ID = $SLURM_JOB_ID (current SLURM JobID)"
  echo "print ARRAY_JOB_ID = $SLURM_ARRAY_JOB_ID  (base JobID for an array of jobs)"
  echo "print ARRAY_TASK_ID = $SLURM_ARRAY_TASK_ID  (offset in an array of jobs)"
  echo "print TASK_PID = $SLURM_TASK_PID"
  echo "print =========================================="
fi
