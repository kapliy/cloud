gcloud compute ssh  --zone=us-central1-b \
  --ssh-flag="-D 1080" --ssh-flag="-N" --ssh-flag="-n" spark-cluster-1-m
