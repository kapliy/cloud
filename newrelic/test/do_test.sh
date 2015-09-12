#!/bin/bash

# NEW_RELIC_STARTUP_DEBUG=true NEW_RELIC_CONFIG_FILE=/home/slurm/perf/newrelic.ini newrelic-admin run-python test.py

export NEW_RELIC_STARTUP_DEBUG=true
export NEW_RELIC_CONFIG_FILE=/home/slurm/perf/newrelic.ini
export NEW_RELIC_ENVIRONMENT=development
python test.py
