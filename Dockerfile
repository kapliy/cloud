FROM ubuntu:latest
MAINTAINER Anton Kapliy <kapliy@gmail.com>

RUN apt-get update && apt-get -y install ipython ipython-notebook python-pandas python-scipy
RUN useradd -m -s /bin/bash -p node node
RUN chown -R node:node /home/node

#USER node
#ENV HOME /home/node
#WORKDIR /home/node

EXPOSE 8888
CMD ["ipython", "notebook", "--ip=*", "--no-browser"]

