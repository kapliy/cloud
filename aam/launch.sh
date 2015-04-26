USER=$(logname)
docker run -it --rm -v /home/$USER/:/mnt/home:ro kapliy/aam
