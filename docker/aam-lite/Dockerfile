FROM ubuntu:latest
MAINTAINER Anton Kapliy "kapliy@gmail.com"

RUN apt-get -yq update

# DB bindings
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq freetds-bin freetds-common \
    libdbd-freetds tdsodbc odbcinst odbcinst1debian2 \
    unixodbc unixodbc-dev 

# DB settings
COPY setup/etc/odbc.ini /etc/
COPY setup/etc/odbcinst.ini /etc/
COPY setup/etc/freetds.conf /etc/freetds/

# environment bootstrap
COPY setup/env/aam_env.sh /etc/

# cleanup
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "source /etc/aam_env.sh" >> /etc/bash.bashrc
