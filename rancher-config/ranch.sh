#!/bin/bash
### Installing Rancher server
kubectl taint nodes master-node-1 node-role.kubernetes.io/controlplane=true:NoSchedule-
kubectl create namespace cattle-system
# Installing Cert-Manager
kubectl create namespace cert-manager
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v1.0.4/cert-manager.crds.yaml
helm repo add jetstack https://charts.jetstack.io
helm repo add rancher-latest https://releases.rancher.com/server-charts/latest
helm repo update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --version v1.0.4
certpodname=$(kubectl get pods -n cert-manager -o jsonpath='{.items[2].metadata.name}')
kubectl wait pod/$certpodname -n cert-manager --for=condition=Running
kubectl get pods -n cert-manager
helm upgrade --namespace cattle-system --install rancher --set hostname=rancher.my.org ../helm/rancher/ --set ingress.tls.source=letsEncrypt --set letsEncrypt.email=ifezouanii@gmail.com
# helm install rancher rancher-latest/rancher \
#   --namespace cattle-system \
#   --set hostname=rancher.my.org
kubectl get pods -n cert-manager
kubectl get pods -n cattle-system
kubectl get svc -n cattle-system
