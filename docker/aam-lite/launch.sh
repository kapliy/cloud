USER=$(logname)
docker run -it --rm -v /home/$USER/:/mnt/home:ro -v /bulkinsert:/bulkinsert:rw -v /opt/anaconda:/opt/anaconda:ro kapliy/aam-lite
