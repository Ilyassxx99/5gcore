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
sudo mv rke_linux-amd64 /usr/local/bin/rke
### Rancher CLI download
wget -c https://github.com/rancher/cli/releases/download/v2.4.11-rc2/rancher-linux-amd64-v2.4.11-rc2.tar.gz
tar -xvzf rancher-linux-amd64-v2.4.11-rc2.tar.gz
rm -f rancher-linux-amd64-v2.4.11-rc2.tar.gz
sudo mv ./rancher-v2.4.11-rc2/rancher /usr/local/bin/rancher
### Select Cluster to configure
kubectl config use-context mycluster1
kubectl config use-context mycluster2
