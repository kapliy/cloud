USER=$(logname)
docker run -it --rm -v /home/$USER/:/mnt/home:ro -v /bulkinsert:/bulkinsert:rw kapliy/aam
