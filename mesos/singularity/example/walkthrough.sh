#!/bin/bash

../client.py -a rm -n mesos-dropwizard-service &> /dev/null
sleep 0.3
../client.py -a add --json request.json
sleep 0.3
../client.py -a deploy -j deploy4.json
