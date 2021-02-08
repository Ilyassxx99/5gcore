# Free5GC Compose

This repository is a Kubernetes version of [free5GC](https://github.com/free5gc/free5gc) for stage 3. It's inspired by [free5gc-docker-compose](https://github.com/free5gc/free5gc-compose.git).


<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prerequisites](#prerequisites)
  - [GTP5G kernel module](#gtp5g-kernel-module)
  - [Docker engine](#docker-engine)
  - [Kubernetes](#Kubernetes)
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

You also need to Setup Kubernetes as detailed here: 
```bash
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo swapoff -a
sudo hostnamectl set-hostname master-node && \
             sudo service docker start && \
             sudo sysctl net.bridge.bridge-nf-call-iptables=1 && \
             sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --service-cidr=10.244.100.0/24 && \
             mkdir -p ~/.kube && \
             sudo cp -i /etc/kubernetes/admin.conf ~/.kube/config && \
             sudo chown $(id -u):$(id -g) ~/.kube/config && \
             sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

## Start Free5gc

```bash
git clone https://github.com/Ilyassxx99/5gcore.git
kubectl taint nodes master-node node-role.kubernetes.io/master:NoSchedule-
kubectl config set-context kubernetes-admin@kubernetes --namespace 5gcore
kubectl apply -f 5gcore
kubectl get pods
```

