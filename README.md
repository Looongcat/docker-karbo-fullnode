# docker-karbo-fullnode
Docker image for running Karbowanec full node

Usage:

1) Node fee goes to Karbowanec dev team: docker run -i --restart=always -v /home/.karbowanec:/home/karbo/.karbowanec --network=host --name=karbo-fullnode -td looongcat/karbo-fullnode
2) Node fee goes to your wallet: docker run -i --restart=always -v /home/.karbowanec:/home/karbo/.karbowanec --network=host --name=karbo-fullnode -td looongcat/karbo-fullnode --fee-address=<your_wallet_address>
