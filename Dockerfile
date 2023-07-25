FROM wordpress:latest

# Add user and group first to make sure their IDs get assigned consistently
RUN groupadd -g 1000 wordpress && \
    useradd -u 1000 -g wordpress -s /bin/bash -m wordpress

# Change ownership of /var/www
RUN chown -R wordpress:wordpress /var/www

# Modify the apache2.conf file
RUN sed -i 's|<Directory />\n\tOptions FollowSymLinks\n\tAllowOverride None\n\tRequire all denied\n</Directory>|<Directory />\n\tOptions Indexes FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>|g' /etc/apache2/apache2.conf

USER wordpress
