#!/bin/bash
job=$1
if [ -z "${job}" ]; then
    echo "Kill the job immediately"
    echo "USAGE: $0 job.json"
    exit 0
fi
job=`basename ${job}`
jobname="${job%.*}"
set -x
curl -L -X DELETE localhost:4400/scheduler/job/${jobname}
