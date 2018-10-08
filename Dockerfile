# Usage: docker run -it --restart=always -v /home/.karbowanec:/home/karbo/.karbowanec -p 32347:32347 -p 32348:32348 --name=karbo-fullnode -d looongcat/karbo-fullnode

FROM debian:9
LABEL description="Karbowanec node image"
LABEL version="0.2.8"
LABEL repository="https://github.com/Looongcat/docker-karbo-fullnode"
LABEL helpdesk="https://t.me/karbo_dev_lounge"

# upgrade dist to latest and greatest
RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y wget unzip

# add restricted user for running node
RUN /bin/bash -c 'adduser --disabled-password --gecos "" karbo'

# Deploy last version of Karbo CLI suite
WORKDIR /home/karbo
RUN wget https://github.com/seredat/karbowanec/releases/download/v.1.5.9/karbowanec-xenial-1.5.9_linux_x86_64.zip &&\
	unzip karbowanec-xenial-1.5.9_linux_x86_64.zip &&\
	rm karbowanec-xenial-1.5.9_linux_x86_64.zip &&\
	mv ./karbowanec-xenial-1.5.9_linux_x86_64/karbowanecd /usr/bin/karbowanecd &&\
	mv ./karbowanec-xenial-1.5.9_linux_x86_64/walletd /usr/bin/walletd &&\
	mv ./karbowanec-xenial-1.5.9_linux_x86_64/simplewallet /usr/bin/simplewallet &&\	
	chmod +x /usr/bin/karbowanecd /usr/bin/walletd /usr/bin/simplewallet &&\
	rm -rf ./karbowanec-xenial-1.5.9_linux_x86_64
		
# Create blockchain folder and assign owner to the files
RUN /bin/bash -c 'mkdir /home/karbo/.karbowanec'
RUN /bin/bash -c 'chown karbo:karbo /home/karbo/.karbowanec /usr/bin/karbowanecd /usr/bin/simplewallet /usr/bin/walletd'

# Open container's ports for P2P and Lightwallet connections
EXPOSE 32347/tcp 32348/tcp

# Mount blockchain?
VOLUME ["/home/karbo/.karbowanec"]

# OPTIONS for node!!!
CMD ["--fee-address=Kdev1L9V5ow3cdKNqDpLcFFxZCqu5W2GE9xMKewsB2pUXWxcXvJaUWHcSrHuZw91eYfQFzRtGfTemReSSMN4kE445i6Etb3"]

# Entry point
ENTRYPOINT ["karbowanecd", "--data-dir=/home/karbo/.karbowanec", "--restricted-rpc", "--rpc-bind-ip=0.0.0.0", "--rpc-bind-port=32348"]
