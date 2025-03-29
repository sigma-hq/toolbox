#!/bin/bash

# This script installs the latest version of Docker from the official Docker repository,  
# ensuring you get the most up-to-date and stable release.  

# Usage:  
# 1. Ensure you are running Ubuntu (20.04, 22.04, or later).  
# 2. Give the script execution permissions: chmod +x install_docker.sh  
# 3. Run the script with: ./install_docker.sh  

# Note: After installation, log out and log back in for the group changes to take effect.

# Exit immediately if a command exits with a non-zero status
set -e

# Update package list
echo "Updating package list..."
sudo apt update

# Install prerequisite packages
echo "Installing prerequisite packages..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the Docker repository to APT sources
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
echo "Updating package list after adding Docker repository..."
sudo apt update

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker-ce

# Enable and start Docker
echo "Enabling and starting Docker..."
sudo systemctl enable --now docker

# Verify Docker installation
echo "Verifying Docker installation..."
sudo systemctl status docker --no-pager

# Add current user to the docker group
echo "Adding user to Docker group..."
sudo usermod -aG docker $USER

echo "Docker installation completed. Please log out and log back in for changes to take effect."