# Free5GC Compose

This repository is a Kubernetes version of [free5GC](https://github.com/free5gc/free5gc) for stage 3. It's inspired by [free5gc-docker-compose](https://github.com/free5gc/free5gc-compose.git).


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
  - [GTP5G kernel module](#gtp5g-kernel-module)
  - [Docker engine](#docker-engine)
  - [Kubernetes](#docker-compose)
- [Start Free5gc](#start-free5gc)

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

### Kubernetes

You also need to Setup Kubernetes as detailed here: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/

## Start Free5gc


```bash
$ git clone https://github.com/Ilyassxx99/5gcore.git
$ kubectl apply -f 5gcore
$ kubectl get pods --namespace 5gcore
```
