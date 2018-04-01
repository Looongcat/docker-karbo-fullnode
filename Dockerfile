# Usage: docker run -it --restart=always -v /home/.karbowanec:/home/karbo/.karbowanec -p 32347:32347 -p 32348:32348 --name=karbo-fullnode -d looongcat/karbo-fullnode

FROM debian:9
LABEL description="Karbowanec node image"
LABEL version="0.2.1"
LABEL repository="https://github.com/Looongcat/docker-karbo-fullnode"
LABEL helpdesk="https://t.me/karbo_dev_lounge"

# upgrade dist to latest and greatest
RUN apt-get update && apt-get -y upgrade

# install dependencies
RUN apt-get install -y wget unzip gcc g++ libboost-all-dev cmake git
RUN apt-get install -y make

# add restricted user for running node
RUN /bin/bash -c 'adduser --disabled-password --gecos "" karbo'

# build karbowanec cli
WORKDIR /home/karbo
RUN /bin/bash -c 'git clone https://github.com/seredat/karbowanec.git'
WORKDIR /home/karbo/karbowanec
RUN /bin/bash -c 'make'

# Deploy last version of Karbo CLI suite
WORKDIR /home/karbo/karbowanec/build/release/src
RUN /bin/bash -c 'cp -a ./. /usr/bin/'

# Create blockchain folder and assign owner to the files
RUN /bin/bash -c 'mkdir /home/karbo/.karbowanec'
RUN /bin/bash -c 'chown karbo:karbo /home/karbo/.karbowanec'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/karbowanecd'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/miner'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/simplewallet'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/walletd'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/connectivity_tool'

# Cleaning
WORKDIR /home/karbo
RUN /bin/bash -c 'rm -rf karbowanec'
RUN /bin/bash -c 'apt-get remove -y --purge g++ libboost-all-dev cmake git'
RUN /bin/bash -c 'apt-get autoremove -y'

# Open container's ports for P2P and Lightwallet connections
EXPOSE 32347/tcp 32348/tcp

# Mount blockchain?
VOLUME ["/home/karbo/.karbowanec"]

# OPTIONS for node!!!
CMD ["--fee-address=Kdev1L9V5ow3cdKNqDpLcFFxZCqu5W2GE9xMKewsB2pUXWxcXvJaUWHcSrHuZw91eYfQFzRtGfTemReSSMN4kE445i6Etb3"]

# Entry point
ENTRYPOINT ["karbowanecd", "--data-dir=/home/karbo/.karbowanec", "--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--rpc-bind-port=32348"]
