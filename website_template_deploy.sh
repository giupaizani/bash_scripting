#!/bin/bash

# Declaring Variables
SERVICE="httpd"
TEMPLATE_URL="https://www.tooplate.com/zip-templates/2098_health.zip"
FILE_NAME=$(basename "$TEMPLATE_URL" .zip)
TEMP_FOLDER="/tmp/webfiles"
HTML_FOLDER="/var/www/html"

# Print Message Function
function print_message {
    echo -e "########################################"
    echo -e "$1"
    echo -e "########################################"
    echo
}

# Installing Dependencies
print_message "Installing packages."
sudo yum install wget unzip $SERVICE -y > /dev/null

# Start & Enable Service
print_message "Starting & Enabling HTTPD Service"
sudo systemctl start $SERVICE
sudo systemctl enable $SERVICE

# Creating Temp Directory
print_message "Starting Artifact Deployment"
mkdir -p $TEMP_FOLDER
cd $TEMP_FOLDER

# Download and Unzip Files
wget -q $TEMPLATE_URL
unzip -q $FILE_NAME.zip
sudo cp -r $FILE_NAME/* $HTML_FOLDER

# Restart Service
print_message "Restarting HTTPD service"
sudo systemctl restart $SERVICE

# Clean Up
print_message "Removing Temporary Files"
rm -rf $TEMP_FOLDER

# Show Service Status
print_message "HTTPD Service Status"
sudo systemctl status $SERVICE --no-pager
echo
ls $HTML_FOLDER
