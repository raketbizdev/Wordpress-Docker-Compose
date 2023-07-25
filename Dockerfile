FROM wordpress:latest

# Add user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -g 1000 wordpress && \
    useradd -u 1000 -g wordpress -s /bin/bash -m wordpress

# Change ownership of /var/www
RUN chown -R wordpress:wordpress /var/www

# Replace the default Apache configuration with the custom configuration
COPY custom-apache2.conf /etc/apache2/apache2.conf

USER wordpress
