#!/bin/bash

# Create the necessary directory and file
mkdir -p ./php
touch ./php/uploads.ini

# Optionally, add configurations to uploads.ini file
echo "file_uploads = On" >> ./php/uploads.ini
echo "upload_max_filesize = 64M" >> ./php/uploads.ini
echo "post_max_size = 64M" >> ./php/uploads.ini

# Check if Docker Compose is installed
if ! command -v docker-compose &> /dev/null
then
    echo "Docker Compose could not be found, installing..."
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
else
    echo "Docker Compose is already installed, skipping installation."
fi

# Verify Docker Compose installation
docker-compose --version

# Run Docker Compose
docker-compose up -d

# chmod +x run.sh
# ./run.sh
