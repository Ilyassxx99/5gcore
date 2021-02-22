#!/bin/bash
# Docker Installation and configuration

### SSH Configuration
NodeIp=192.168.60.143
sudo apt install openssh-client
sudo apt install openssh-server
sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
# On master to copy your SSH public key to the other nodes
ssh-copy-id -i .ssh/id_rsa.pub ilyass@$NodeIp
### RKE Configuration
wget -c https://github.com/rancher/rke/releases/download/v1.2.6-rc5/rke_linux-amd64
mv rke_linux-amd64 /usr/local/bin/rke

### Select Cluster to configure
kubectl config use-context mycluster1
kubectl config use-context mycluster2
