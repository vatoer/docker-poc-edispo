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

# Create a non-root user and switch to it
RUN groupadd -g 1000 www && \
    useradd -u 1000 -ms /bin/bash -g www www
USER www

WORKDIR /var/www/poc-mini-fileserver

RUN composer install --no-interaction --no-dev --prefer-dist

# Copy your PHP project into the working directory
# COPY --chown=www:www ./poc-mini-fileserver /var/www/html

# Copy your PHP project into the working directory
# COPY ./poc-mini-fileserver /var/www/html

# Run Composer install to install the dependencies
# RUN composer update

# RUN composer install --no-interaction --no-dev --prefer-dist

# Expose port 9000 for FPM (adjust if different)
EXPOSE 9000