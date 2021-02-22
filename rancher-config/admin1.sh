#!/bin/bash
Cluster1IP=192.168.60.141
mkdir -p data/pki
tempcert=$(cat kube_config_cluster1.yml | grep "client-certificate-data")
tempkey=$(cat kube_config_cluster1.yml | grep "client-key-data")
tempca=$(cat kube_config_cluster1.yml | grep "certificate-authority-data")
cert=$(echo $tempcert | cut -d " " -f 2)
key=$(echo $tempkey | cut -d " " -f 2)
ca=$(echo $tempca | cut -d " " -f 2)

echo $ca > data/pki/ca-base64.pem
echo $cert > data/pki/admin-base64.pem
echo $key > data/pki/admin-key-base64.pem

base64 -d data/pki/ca-base64.pem > data/pki/ca1.pem
base64 -d data/pki/admin-base64.pem > data/pki/admin1.pem
base64 -d data/pki/admin-key-base64.pem > data/pki/admin-key1.pem

rm -f data/pki/ca-base64.pem
rm -f data/pki/admin-base64.pem
rm -f data/pki/admin-key-base64.pem
# Setting Config File
kubectl config  set-cluster mycluster1 --server=https://$Cluster1IP:6443 --certificate-authority=data/pki/ca1.pem
kubectl config  set-credentials kube-admin-mycluster1 --client-certificate=data/pki/admin1.pem --client-key=data/pki/admin-key1.pem
kubectl config  set-context mycluster1 --cluster=mycluster1 --namespace=frontend --user=kube-admin-mycluster1
kubectl config view
