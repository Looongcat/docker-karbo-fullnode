# docker-karbo-fullnode
Docker image for running Karbowanec full node

Usage:

1) Node fee goes to Karbowanec dev team: docker run -it --restart=always -p 32347:32347 -p 32348:32348 -v <host folder for blockchain storage>:/home/karbo/.karbowanec --name=karbo-fullnode -d looongcat/karbo-fullnode
2) Node fee goes to your wallet: docker run -it --restart=always -p 32347:32347 -p 32348:32348 -v <host folder for blockchain storage>:/home/karbo/.karbowanec --name=karbo-fullnode -d looongcat/karbo-fullnode --fee-address=<your_wallet_address>

If for some reason you want to get into container:
  docker exec -it karbo-fullnode /bin/bash