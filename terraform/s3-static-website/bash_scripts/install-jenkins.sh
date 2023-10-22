#!/bin/bash
# This script is intended to install and configure Jenkins on Amazon Linux 2

# Set the hostname of the machine to 'jenkins'
sudo hostnamectl set-hostname jenkins

# Update the system to ensure we have the latest packages and security updates
sudo yum update -y

# Download the Jenkins repository file to the /etc/yum.repos.d directory
sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo

# Import the GPG key for Jenkins to ensure the authenticity of the packages
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Upgrade the system packages to their latest versions
sudo yum upgrade -y

# Install Java 17 Amazon Corretto as it's a prerequisite for Jenkins
sudo yum install java-17-amazon-corretto -y

# Install git as it's a prerequisite for Jenkins
sudo yum install git -y

# Install Jenkins using the yum package manager
sudo yum install jenkins -y

# Enable the Jenkins service to start on boot
sudo systemctl enable jenkins

# Start the Jenkins service
sudo systemctl start jenkins

# Check the status of the Jenkins service to ensure it's running properly
sudo systemctl status jenkins