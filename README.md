# Resume-Website

Welcome to the repository of DevOps engineer's resume project! This project not only showcases a website deployment but a complete CI/CD pipeline setup, embodying a myriad of modern-day technologies and services. The aim is to provide a streamlined, yet comprehensive demonstration of deploying and managing a web-based resume with a touch of DevOps elegance.

The website is deployed at:<br/>
https://angpenghian.com/pages/project1/resume-website.html<br/>
Currently, the website is deployed using the static website on S3 method.<br/>

## Tech Stack
The project leverages the following technologies:

- **[Amazon Web Services (AWS)](https://aws.amazon.com/)**: Our cloud service haven, hosting all the necessary infrastructure.
- **[Terraform](https://www.terraform.io/)**: The go-to IaC tool, provisioning and taming the AWS cloud resources.
- **[Kubernetes](https://kubernetes.io/)**: The maestro orchestrating our containerized applications.
- **[Docker](https://www.docker.com/)**: Packing the website and its environment into neat containers.
- **[Nginx Web Server](https://www.nginx.com/)**: The diligent server delivering our website content and managing the HTTP symphony.
- **Bash**: The scripting wizard automating various stages of our CI/CD journey.
- **HTML, CSS, JavaScript**: The front-end trifecta building the visual essence of the website.
- **[Jenkins](https://www.jenkins.io/)**: The automation guru setting up the CI/CD pipeline.
- **[SonarQube](https://www.sonarqube.org/)**: The continuous inspection sentinel ensuring our code quality is top-notch.

## Infrastructure Setups
The project is architectured with three distinct infrastructure setups to exhibit various deployment strategies, offering a lens into practical, real-world DevOps scenarios. Each setup is a narrative of deploying a full-fledged website intertwined with a CI/CD pipeline, showcasing the harmony between development and operations.

Feel free to explore, fork, and star this repository, and pull requests are always welcomed to make this project even better!


## Infrastructure Variations

1. **Static Website on S3**:
    - User PC > Git > GitHub > Jenkins > AWS S3 Bucket Static Website
2. **Server-Based Deployment with EC2**:
    - User PC > Git > GitHub > Kubernetes Jenkins > Kubernetes Sonareqube > Kubernetes Nginx
3. **Server-Based Deployment with EKS**:
    - User PC > Git > GitHub > Kubernetes Jenkins > Kubernetes Sonareqube > Kubernetes Nginx

## Directory Structure

```plaintext
Resume-website
├── secrets                     # Directory for storing sensitive data (e.g., AWS credentials)
|  └── aws_access_key.txt       # AWS access key
|  └── aws_secret_key.txt       # AWS secret key
|  └── resume-terraform.pem     # SSH private key for EC2 instances
├── terraform                   # Terraform configurations
│   ├── s3-static-website       # Terraform config for S3 static website setup
|   |  └── bash_scripts         # Bash scripts for setting up terraform user data
│   ├── server-based            # EC2 deployment config
|   |  └── bash_scripts         # Bash scripts for setting up terraform user data
|   |  └── kubernetes_scripts   # Yaml files for setting up kubernetes cluster
│   └── server-less             # EKS deployment config
|      └── kubernetes_scripts   # Yaml files for setting up kubernetes cluster
└── website                     # Website files (HTML, CSS, JS)
```

## Prerequisites

- AWS Account
- Terraform installed
- Git Installed
- Kubernetes and kubectl (for server-based deployments)

## Setup and Deployment

### AWS Credentials

Ensure that your AWS credentials are securely stored in the `secrets` directory.

### Terraform Initialization and Planning

Navigate to the desired infrastructure setup directory under `terraform` and edit the `terraform.tfvars` file to your liking. Then, run the following commands:

Initialize terraform:
```bash
terraform init
```
Start terraform planning:
```bash
terraform plan
```
Start terraform deployment:
```bash
terraform apply
```

## Website Deployment

### s3-static-website
For the static website on S3 setup edit the nesscary parts in the terraform files and run the following commands:
```bash
terraform init
terraform plan
terraform apply
```
Once the terraform deployment is completed, there would be configurations needed to be done on the Jekins server.
A more detailed guide on setting up the Jenkins server will be added soon.

### server-based
For the server-based deployment with EC2 same as above, edit the nesscary parts in the terraform files and run the following commands:
```bash
terraform init
terraform plan
terraform apply
```
Once the terraform deployment is completed, there would be configurations needed to be done on the Jekins server.
A detailed guide can be found in here: https://angpenghian.com/pages/project1/resume-website.html

### server-less
For the server-based deployment with EKS same as above, edit the nesscary parts in the terraform files and run the following commands:
```bash
terraform init
terraform plan
terraform apply
```
Once the terraform deployment is completed, you also need deploy the kubernetes cluster and the website.
run the following commands to configure the kubernetes config file:
```bash
aws eks --region $(terraform output -raw region) update-kubeconfig \
    --name $(terraform output -raw cluster_name)
```
Then navigate to the kubernetes_scripts directory and run the following commands:
```bash
kubectl apply -f jenkins-deployment.yaml
kubectl apply -f nginx-deployment.yaml
kubectl apply -f private-lb.yaml
```
A more detailed guide on setting up the Jenkins server will be added soon.

## Accessing the Website
can be found in here: https://angpenghian.com