#!/bin/bash

# run this after terraform apply is finish to enable kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)

# copy this into end of jenkins build as execute shell
cp -r /var/jenkins_home/workspace/resume-website/website/* /usr/share/nginx/html/