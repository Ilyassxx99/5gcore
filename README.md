# Free5GC Compose

This repository is a docker compose version of [free5GC](https://github.com/free5gc/free5gc) for stage 3. It's inspire by [free5gc-docker-compose](https://github.com/calee0219/free5gc-docker-compose) and also reference to [docker-free5GC](https://github.com/abousselmi/docker-free5gc).

You can setup your own config in [config](./config) folder and [docker-compose.yaml](docker-compose.yaml)

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
  - [GTP5G kernel module](#gtp5g-kernel-module)
  - [Docker engine](#docker-engine)
  - [Docker compose](#docker-compose)
- [Start Free5gc](#start-free5gc)
- [Troubleshooting](#troubleshooting)
- [Vagrant Box Option](#vagrant-box-option)
- [NF dependencies and ports](#nf-dependencies-and-ports)
- [Reference](#reference)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Prerequisites

### GTP5G kernel module

Due to the UPF issue, the host must using kernel `5.0.0-23-generic`. And it should contain `gtp5g` kernel module.

On you host OS:
```
git clone https://github.com/PrinzOwO/gtp5g.git
cd gtp5g
make
sudo make install
```

### Docker engine

To install docker on your favorite OS, you can follow instruction here: https://docs.docker.com/engine/install/

### Docker compose

You also need to install docker compose as detailed here: https://docs.docker.com/compose/install/

## Start Free5gc

Because we need to create tunnel interface, we need to use privileged container with root permission.

```bash
$ git clone https://github.com/free5gc/free5gc-compose.git
$ cd free5gc-compose
$ make base
$ docker-compose build
$ sudo docker-compose up # Recommend use with tmux to run in frontground
$ sudo docker-compose up -d # Run in backbround if needed
```
