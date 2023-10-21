#!/bin/bash

# Set 'errexit' and 'pipefail' options to exit script on error
set -e
set -o pipefail

# Function to print a message to stdout
function print_message() {
    echo -e "\n===== $1 ====="
}

# Function to check if a package is installed, and install it if not
function check_install() {
    if ! dpkg -l | grep -q "$1"; then
        print_message "Installing $1..."
        sudo apt-get install -y "$1"
    else
        print_message "$1 is already installed"
    fi
}

# Function to update APT and install necessary packages
function update_and_install() {
    print_message "Updating package list"
    sudo apt-get update

    # Check if Java is installed, if not, install it
    check_install "openjdk-11-jre"
}

# Function to set up Jenkins repository
function setup_jenkins_repo() {
    print_message "Setting up Jenkins repository"

    # Download and install the Jenkins repository signing key
    print_message "Downloading Jenkins repository signing key"
    curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

    # Add the Jenkins repository to the system's sources list
    print_message "Adding Jenkins repository to system's sources list"
    echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

    print_message "Updating package list again"
    sudo apt-get update
}

# Function to install Jenkins
function install_jenkins() {
    # Check if Jenkins is installed, if not, install it
    check_install "jenkins"
}

# Main script logic
function main() {
    # Set the host name to jenkins
    print_message "Setting hostname to Jenkins"
    sudo hostnamectl set-hostname jenkins

    # Update and install required packages
    update_and_install

    # Setup Jenkins repository
    setup_jenkins_repo

    # Install Jenkins
    install_jenkins

    print_message "Jenkins installation complete!"
    print_message "Access server at http://[Your instance public IP]:8080"
    print_message "To get the login password, run 'sudo cat /var/lib/jenkins/secrets/initialAdminPassword' on your Jenkins server command line"
    print_message "After logging in, click 'Install suggested plugins', set up your user account and follow through 'Save and Continue' to finish setting up"
}

# Run the main function
main