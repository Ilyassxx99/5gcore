# Free5GC Kubernetes

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
### Environment
free5gc should be tested against the following environment:

- Software

  - OS: Ubuntu 18.04
  - gcc 7.3.0
  - Go 1.14.4 linux/amd64
  - kernel version 5.0.0-23-generic
  - The listed kernel version is required for the UPF element.

- Minimum Hardware

  - CPU: Intel i5 processor
  - RAM: 4GB
  - Hard drive: 80GB
  - NIC: Any 1Gbps Ethernet card supported in the Linux kernel
  
- Recommended Hardware

  - CPU: Intel i7 processor
  - RAM: 8GB
  - Hard drive: 80GB
  - NIC: Any 10Gbps Ethernet card supported in the Linux kernel
  
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

To install docker on your favorite OS, you can follow instruction here:
```bash
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
 sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
 sudo apt-get install docker-ce docker-ce-cli containerd.io
 sudo usermod -aG docker <your-user>
```

### Kubernetes

You also need to Setup Kubernetes with Kubeadm as detailed here: 
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

### RKE

To Setup Kubernetes with RKE (This creates two clusters, mycluster1 and mycluster2): 
```bash
cd rancher-config
chmod +x rke.sh
./rke.sh
```
To control cluster 1 :
```bash
kubectl config use-context mycluster1
```
To control cluster 2 :
```bash
kubectl config use-context mycluster2
```
To deploy Rancher in one of the two clusters :
```bash
chmod +x ranch.sh
./ranch.sh
```

### Helm

You also need to install Helm as detailed here: 
```bash
wget -c https://get.helm.sh/helm-v3.5.2-linux-amd64.tar.gz
tar -xvzf helm-v3.5.2-linux-amd64.tar.gz
sudo mv linux-amd64/helm /usr/local/bin/helm
```
## Start Free5gc

```bash
git clone https://github.com/Ilyassxx99/5gcore.git
chmod +x 5gcore/pv.sh
./5gcore/pv.sh
kubectl taint nodes master-node node-role.kubernetes.io/master:NoSchedule-
kubectl config set-context kubernetes-admin@kubernetes --namespace 5gcore
kubectl apply -f 5gcore
kubectl get pods
```

