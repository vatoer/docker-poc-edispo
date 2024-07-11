# Use PHP 7.3 FPM image from the official Docker Hub
FROM php:7.3-fpm

# Install system dependencies for Composer, Git, and PHP extensions you need
RUN apt-get update && apt-get install -y \
        git \
        unzip \
        libzip-dev \
        && docker-php-ext-install pdo pdo_mysql zip mysqli

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set the working directory inside the container
WORKDIR /var/www/poc-mini-fileserver

# Copy the entrypoint script
COPY entrypoint/php-fpm.sh /usr/local/bin/entrypoint.sh

# Make the script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# By default, start PHP-FPM
CMD ["php-fpm"]

# Create a non-root user and switch to it
RUN groupadd -g 1000 www && \
    useradd -u 1000 -ms /bin/bash -g www www

USER www

# Expose port 9000 for FPM (adjust if different)
EXPOSE 9000
