# Usage: docker run --restart=always -v /home/.karbowanec:/home/karbo/.karbowanec --network=host --name=karbo-fullnode -td looongcat/karbo-fullnode

FROM debian:8
LABEL version="0.0.1"
LABEL description="Karbowanec node image"

# upgrade dist to latest and greatest
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y wget

# add restricted user for running node (maybe overkill? Check that later)
RUN /bin/bash -c 'adduser --disabled-password --gecos "" karbo'

# Deploy last version of Karbo CLI suite
WORKDIR /home/karbo
RUN wget https://karbowanec.com/download/Karbowanec_cli_64-bit_1.4.4.tar.gz &&\
    tar -zxvf Karbowanec_cli_64-bit_1.4.4.tar.gz &&\
    rm Karbowanec_cli_64-bit_1.4.4.tar.gz &&\
    cp -a ./karbo/. /usr/bin/ &&\
    rm -rf ./karbo

# Create blockchain folder and assign owner to the files
RUN /bin/bash -c 'mkdir /home/karbo/.karbowanec'
RUN /bin/bash -c 'chown karbo:karbo /home/karbo/.karbowanec'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/karbowanecd'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/miner'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/simplewallet'
RUN /bin/bash -c 'chown karbo:karbo /usr/bin/walletd'

# Open container's ports for P2P and Lightwallet connections
EXPOSE 32347/tcp 32348/tcp

# Mount blockchain?
VOLUME ["/home/karbo/.karbowanec"]

# OPTIONS for node!!!
CMD ["--data-dir=/home/karbo/.karbowanec", "--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--rpc-bind-port=32348", "--fee-address=Kdev1L9V5ow3cdKNqDpLcFFxZCqu5W2GE9xMKewsB2pUXWxcXvJaUWHcSrHuZw91eYfQFzRtGfTemReSSMN4kE445i6Etb3"]

# Entry point
ENTRYPOINT ["karbowanecd"]
