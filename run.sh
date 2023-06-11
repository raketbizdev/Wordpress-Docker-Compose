#!/bin/bash

# Create the necessary directory and file
mkdir -p ./php
touch ./php/uploads.ini

# Optionally, add configurations to uploads.ini file
echo "file_uploads = On" >> ./php/uploads.ini
echo "upload_max_filesize = 64M" >> ./php/uploads.ini
echo "post_max_size = 64M" >> ./php/uploads.ini

# Run docker-compose
docker-compose up -d

# chmod +x run.sh
# ./run.sh
