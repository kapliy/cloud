#!/bin/bash
job=$1
if [ -z "${job}" ]; then
    echo "Kill the process immediately"
    echo "USAGE: $0 process.json"
    exit 0
fi
job=`basename ${job}`
jobname="${job%.*}"
set -x
curl -L -X DELETE localhost:8080/v2/apps/${jobname}
