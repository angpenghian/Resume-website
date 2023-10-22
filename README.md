# Resume-Website

This repository houses a DevOps tech stack for deploying a resume website with three different infrastructure setups. The project is structured using Terraform for infrastructure as code (IAC) to provision and manage the required resources on AWS.

## Infrastructure Variations

1. **Static Website on S3**:
    - User PC > Git > GitHub > Jenkins > AWS S3 Bucket Static Website
2. **Server-Based Deployment with EC2**:
    - User PC > Git > GitHub > Kubernetes Jenkins > Kubernetes Deployment (nginx) on EC2
3. **Server-Based Deployment with EKS**:
    - User PC > Git > GitHub > EKS > Kubernetes Jenkins > Kubernetes Deployment (nginx) on EKS

## Directory Structure

```plaintext
Resume-website
├── secrets                     # Directory for storing sensitive data (e.g., AWS credentials)
├── terraform                   # Terraform configurations
│   ├── s3-static-website       # Terraform config for S3 static website setup
│   ├── server-based            # EC2 deployment config
│   └── server-less             # EKS deployment config
└── website                     # Actual website files (HTML, CSS, JS)
```

## Prerequisites

- AWS Account
- Terraform installed
- Kubernetes and kubectl (for server-based deployments)
- Jenkins

## Setup and Deployment

### AWS Credentials

Ensure that your AWS credentials are securely stored in the `secrets` directory.

// Describe the format of the credentials file and how to obtain AWS credentials.

### Terraform Initialization and Planning

Navigate to the desired infrastructure setup directory under `terraform` and run the following commands:

```bash
terraform init
terraform plan
```

### Deployment

```bash
terraform apply
```


### Accessing the Website
// Describe how to access the website once it's deployed.

### Updating the Website
// Describe the process of making changes to the website and redeploying.

### Troubleshooting
// Common troubleshooting steps or FAQ.

### Contributing
// Guidelines for contributing to this project.

### License
// License information.