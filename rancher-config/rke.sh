#!/bin/bash
### Deploying Kubernetes cluster
rke up --config cluster1.yml
rke up --config cluster2.yml

### Configuring Access to Kubernetes Cluster
cp config.yml ~/.kube/config
# Cluster1 Configuration
chmod +x admin1.sh
./admin1.sh
# Cluster2 Configuration
chmod +x admin2.sh
./admin2.sh
