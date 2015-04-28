#!/bin/bash
for ct in `docker ps -a | cut -d ' ' -f1 | grep -v CONTAINER`; do docker rm $ct; done
