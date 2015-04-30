#!/bin/bash

# local run - for testing only. 
# for deployment, use marathon/singularity.json instead!
java -jar SingularityService/target/SingularityService-*-shaded.jar server singularity_config.yaml
