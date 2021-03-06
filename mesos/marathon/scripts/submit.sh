#!/bin/bash
job=$1
if [ -z "${job}" ]; then
    echo "Submit a process to Marathon/Mesos"
    echo "USAGE: $0 process.json"
    exit 0
fi
if [ ! -f "${job}" ]; then
    echo "ERROR: job file ${job} does not exist"
    exit 1
fi
set -x
curl -L -H "Content-Type: application/json" -X POST -d@${job} localhost:8080/v2/apps
