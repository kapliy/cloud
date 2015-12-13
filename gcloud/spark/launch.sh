gcloud beta dataproc clusters create spark-cluster-1 --zone us-central1-b --master-machine-type n1-standard-4 --master-boot-disk-size 250 --num-workers 2 --worker-machine-type n1-standard-4 --worker-boot-disk-size 500 --image-version 0.2 --project kapliy --initialization-actions gs://kapliy-bucket/init/zeppelin.sh --initialization-action-timeout 15m
