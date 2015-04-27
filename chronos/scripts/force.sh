#!/bin/bash
job=$1
if [ -z "${job}" ]; then
    echo "Force the job to run immediately"
    echo "USAGE: $0 job.json"
    exit 0
fi
job=`basename ${job}`
jobname="${job%.*}"
set -x
curl -L -X PUT localhost:4400/scheduler/job/${jobname}
