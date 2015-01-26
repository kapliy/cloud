#!/bin/bash
gcloud compute instances create core1 core2 core3 --image https://www.googleapis.com/compute/v1/projects/coreos-cloud/global/images/coreos-beta-557-0-0-v20150114 --zone us-central1-a --machine-type n1-standard-1 --metadata-from-file user-data=cloud-config.yaml
