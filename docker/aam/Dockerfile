FROM kapliy/aam-lite:latest
MAINTAINER Anton Kapliy "kapliy@gmail.com"

# these are needed to compile all of anaconda packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq wget make bzip2
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base libmpich2-dev libx11-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y emacs vim mlocate

# ANACONDA (numpy, pandas, sqlalchemy, etc)
ADD setup /setup
RUN chmod +x /setup/anaconda/setup.sh
RUN /setup/anaconda/setup.sh

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /setup/*
RUN updatedb
