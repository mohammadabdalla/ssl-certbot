#!/bin/bash

# Function to install Certbot if not already installed
install_certbot() {
    if ! command -v certbot &> /dev/null; then 
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y certbot
        elif command -v yum &> /dev/null; then
            sudo yum install -y certbot
        else
            echo "Unsupported package manager. Please install Certbot manually."
            exit 1
        fi
    fi
}

# Check and install Certbot
install_certbot

# Stop web server if it's running (adjust the command based on your web server)
sudo systemctl stop apache2

# Run Certbot to obtain the certificate
sudo certbot certonly --standalone -d yourdomain.com

# Start the web server again (adjust the command based on your web server)
sudo systemctl start apache2

# Optionally, you can automatically renew the certificate by adding a cron job
# To edit crontab, run: crontab -e
# Add the following line to check for renewals twice a day
# 0 */12 * * * certbot renew

echo "SSL certificate has been generated and configured successfully."

# Note: Replace 'yourdomain.com' with your actual domain or subdomain.
