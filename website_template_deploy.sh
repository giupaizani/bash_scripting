#!/bin/bash

# Print Message Function
function print_message {
    echo -e "########################################"
    echo -e "$1"
    echo -e "########################################"
    echo
}

# Installing Dependencies
print_message "Installing packages."
sudo yum install wget unzip httpd -y > /dev/null

# Start & Enable Service
print_message "Starting & Enabling HTTPD Service"
sudo systemctl start httpd
sudo systemctl enable httpd

# Creating Temp Directory
print_message "Starting Artifact Deployment"
mkdir -p /tmp/webfiles
cd /tmp/webfiles

# Download and Unzip Files
wget -q https://www.tooplate.com/zip-templates/2098_health.zip
unzip -q 2098_health.zip
sudo cp -r 2098_health/* /var/www/html/

# Restart Service
print_message "Restarting HTTPD service"
sudo systemctl restart httpd

# Clean Up
print_message "Removing Temporary Files"
rm -rf /tmp/webfiles

# Show Service Status
print_message "HTTPD Service Status"
sudo systemctl status httpd --no-pager
echo
ls /var/www/html/