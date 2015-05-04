#!/bin/bash

# read-only mount of the user's home directory
ROHOME=/mnt/home
# read-only mount of anaconda installation
CONDAHOME=/opt/anaconda/2.2.0
# anaconda virtualenv (driven by the choice of pandas)
CONDAENV=pandas0.16

if [ ! -d "${ROHOME}" ]; then
    echo "ERROR: user home directory not mounted"
    exit 1
fi

if [ ! -d "${CONDAHOME}" ]; then
    # attempt to fall-back to an earlier version of anaconda
    CONDAHOME=/opt/anaconda/2.1.0
    if [ ! -d "${CONDAHOME}" ]; then
	echo "ERROR: anaconda installation not mounted"
	exit 1
    fi
fi


# location
DBRCLOC=${ROHOME}/.dbrc
cp ${DBRCLOC} ~/

# drop into the conda virtualenv
export USER=root
export PATH=${CONDAHOME}/bin:$PATH
source activate ${CONDAENV}

# set up common paths
export WORKSPACE=${ROHOME}/ws
export PYTHONPATH=${WORKSPACE}/aam/latest/python-util/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/db/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/coreengine/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/factors/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/datalib/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/runner/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/neo/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/ui/webdata
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/ui/webdata_client
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/aam/latest/monitor/src
export PYTHONPATH=${PYTHONPATH}:${WORKSPACE}/PortfolioAnalytics/Python/src
