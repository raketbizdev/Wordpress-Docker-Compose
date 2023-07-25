#!/bin/bash

# Create the necessary directory and file
mkdir -p ./php
touch ./php/uploads.ini
docker build -t custom-wordpress:latest .

# Optionally, add configurations to the uploads.ini file
cat << EOF > ./php/uploads.ini
file_uploads = On
upload_max_filesize = 200M
post_max_size = 200M
EOF

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

# Fix ownership of directories
sudo chown -R 1000:1000 ./wordpress-data
# sudo chown -R $USER:$USER wordpress-data wordpress-db-data
# sudo chown -R $USER:$USER wordpress-data/wp-config.php
# Restart Docker Compose
docker-compose down
docker-compose up -d
# chmod +x run.sh
# ./run.sh
