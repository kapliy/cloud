#!/bin/bash

# cd to the directory owned by this file
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
   # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
done
export PROJDIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo "(Re)starting SLURMD (worker) daemon on $(hostname):"
echo $PROJDIR

# creates all required directories to bootstrap a worker node
mkdir -p /var/log/slurm/
cd $PROJDIR
sbin/slurmd
