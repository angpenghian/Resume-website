#!/bin/bash

# Set 'errexit' option to exit script on error
set -e

# Function to print a message to stdout
print_message() {
    echo -e "\n===== $1 ====="
}

# Function to check if a package is installed, and install it if not
check_install() {
    if ! dpkg -l | grep -q "$1"; then
        print_message "Installing $1..."
        sudo apt-get install -y "$1"
    else
        print_message "$1 is already installed"
    fi
}

# Check if the script is run as root
if [[ "$EUID" -ne 0 ]]; then 
    echo "Please run as root"
    exit 1
fi

# Change host name
print_message "Setting hostname to sonarqube"
sudo hostnamectl set-hostname sonarqube

# Update the list of available packages and their versions
print_message "Updating package list"
sudo apt-get update

# Check if Java is installed, if not, install it
check_install "openjdk-17-jre"

# Change directory to /home/ubuntu/
print_message "Changing directory to /home/ubuntu"
cd /home/ubuntu

# Download SonarQube
SONARQUBE_ZIP="sonarqube-10.0.0.68432.zip"
print_message "Downloading SonarQube"
wget "https://binaries.sonarsource.com/Distribution/sonarqube/$SONARQUBE_ZIP"

# Check if unzip is installed, if not, install it
check_install "unzip"

# Unzip the SonarQube package
SONARQUBE_DIR="${SONARQUBE_ZIP%.*}"
print_message "Unzipping SonarQube"
sudo unzip -q $SONARQUBE_ZIP

# Change ownership of all SonarQube files
print_message "Changing ownership of SonarQube files"
sudo chown -R ubuntu:ubuntu $SONARQUBE_DIR

# Change directory into the SonarQube folder
print_message "Changing directory to SonarQube folder"
cd $SONARQUBE_DIR/bin/linux-x86-64

# Start SonarQube
print_message "Starting SonarQube"
sudo -u ubuntu nohup ./sonar.sh start > /dev/null 2>&1 &

# Wait for a few seconds to allow SonarQube to start
sleep 5

# Check if SonarQube is running
if pgrep -x "sonar.sh" > /dev/null; then
    print_message "SonarQube is running"
else
    print_message "SonarQube failed to start"
    exit 1
fi

# Remove the zip file to save disk space
print_message "Cleaning up"
rm /home/ubuntu/$SONARQUBE_ZIP

print_message "Installation complete"