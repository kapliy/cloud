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

echo "(Re)starting SLURMDBD and SLURMCTLD (database/controller) daemon on $(hostname):"
echo $PROJDIR

# creates all required directories to bootstrap server daemons
mkdir -p /var/log/slurm/ /var/log/slurm/archive
cd $PROJDIR
sbin/slurmdbd
sbin/slurmctld
