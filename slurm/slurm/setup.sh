#!/bin/bash

# sudo apt-get install mysql-server libmysqlclient-dev libcurl-dev man2html libmunge2 munge libmunge-dev

./configure --with-hdf5=no --prefix=/home/slurm/release --sysconfdir=/home/slurm/release/etc && make clean && make && make install