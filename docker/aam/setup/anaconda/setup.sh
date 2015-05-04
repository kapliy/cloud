#!/bin/bash

CONDA_VERSION=2.2.0
PANDAS_VERSION=0.16

# install core conda
mkdir -p /opt/anaconda/
cd /setup/anaconda/${CONDA_VERSION}
FNAME=Anaconda-${CONDA_VERSION}-Linux-x86_64.sh
wget https://3230d63b5fc54e62148e-c95ac804525aac4b6dba79b00b39d1d3.ssl.cf1.rackcdn.com/Anaconda-${CONDA_VERSION}-Linux-x86_64.sh
chmod +x ${FNAME}
make

# install pandas
cd pandas${PANDAS_VERSION}
make conda pip clean
