# Docker Compose WordPress Setup Guide

This guide will help you set up a WordPress environment using Docker Compose with WordPress, MariaDB, and phpMyAdmin containers. We will also create a script to automate the setup.

## Prerequisites

Make sure you have Docker and Docker Compose installed on your machine.

## Step 1: Create the Docker Compose File

First, create a directory where you want to store your project files:

```sh
mkdir my_wordpress_project
cd my_wordpress_project
```

Now, create a `docker-compose.yml` file in your project directory. This file will contain the configuration for WordPress, MariaDB, and phpMyAdmin containers.

Paste the following content into the `docker-compose.yml` file:

```yaml
version: '3.1'

services:

  wordpress:
    image: wordpress:latest
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_PASSWORD: ChangeMyPass
      WORDPRESS_DB_NAME: wpdb
      WORDPRESS_TABLE_PREFIX: wp_
      WORDPRESS_DB_HOST: wordpress_db
    volumes:
      - ./wordpress-data:/var/www/html
      - ./php/uploads.ini:/usr/local/etc/php/conf.d/uploads.ini

  wordpress_db:
    image: mariadb:latest
    environment:
      MYSQL_ROOT_PASSWORD: ChangeMyPass
    volumes:
      - ./wordpress-db-data:/var/lib/mysql

  phpmyadmin:
    image: phpmyadmin/phpmyadmin:latest
    ports:
      - 8282:80
    environment:
      PMA_USER: root
      MYSQL_ROOT_PASSWORD: ChangeMyPass
      PMA_HOST: wordpress_db
```

## Step 2: Create the run.sh Script

Create a new file named `run.sh` in the same directory as your `docker-compose.yml` file:

```sh
touch run.sh
```

Copy and paste the following script into the `run.sh` file:

```sh
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
```

## Step 3: Make the Script Executable

You need to give execute permissions to the script. Run the following command:

```sh
chmod +x run.sh
```

## Step 4: Execute the Script

Now, run the script:

```sh
./run.sh
```

This will create the necessary directories and files, and start the containers.

## Step 5: Access WordPress and phpMyAdmin

After running the script, you can access:

- WordPress at [http://localhost:8080](http://localhost:8080)
- phpMyAdmin at [http://localhost:8282](http://localhost:8282)

## Step 6: Shutting Down

To stop and remove the containers, you can run:

```sh
docker-compose down
```

## Conclusion

You have now set up a local WordPress environment with Docker Compose. The script helps automate the setup process.
