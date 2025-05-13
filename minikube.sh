#!/bin/bash

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
minikube version



# imp commands 
# minikube status should ruuning everything
# minikube ip  -- this will print ip
# minikube start --driver=docker --force
# kubectl get pods -A --> this will show all pods inc
#