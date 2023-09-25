#!/bin/bash

# inside the kubernetes machine in infra folder
sudo passwd ec2-user
# <your password>

# inside jenkins machine
sudo su -s /bin/bash - jenkins
ssh-keygen
#enter
#enter

ssh-copy-id ec2-user@kubernetes-machine-public-ip

scp -r /var/jenkins_home/workspace/resume-website/Resume/* ec2-user@3.1.28.163:/home/ec2-user/resume
scp -r /var/jenkins_home/workspace/resume-website/Resume/* ec2-user@18.143.8.165:/home/ec2-user/resume



######### Commands to execute by mannually ##########

# Initialize your master node:
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU,Mem
# Please ensure to jot down the join command that appears after the initialization; this will be used later to add a worker node to the Kubernetes cluster.

# On the worker node server, use the following format to execute the join command you copied in the previous step:
kubeadm join [your-ip]:6443 --token [your-token] --discovery-token-ca-cert-hash [your-hash]
# An example of how the join command should look is given below:
sudo kubeadm join 10.0.2.239:6443 --token 6a3r2s.q3b6oiah7qjq83h0 \
        --discovery-token-ca-cert-hash sha256:a312048b660eae4a1a2c703c99624ebf7c69b3ad4fc3c2457dc69390d7eb003c

# To start using your cluster, you need to run the following as a regular user:
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Then you need to deploy a pod network to the cluster. Flannel can be used for this:
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# proceed to execute the join command noted in on your worker node server to add it to the Kubernetes cluster