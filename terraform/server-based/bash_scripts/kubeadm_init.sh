#!/bin/bash

# Initialize your master node:
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU,Mem

# To start using your cluster, you need to run the following as a regular user:
sudo mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Then you need to deploy a pod network to the cluster. Flannel can be used for this:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# proceed to execute the join command noted in on your worker node server to add it to the Kubernetes cluster
# If you missed the kubeadm join command after initializing your Kubernetes master node, 
# you can retrieve it by running the following command on your master node:
# kubeadm token create --print-join-command