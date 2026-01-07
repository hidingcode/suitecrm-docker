FROM php:8.1-fpm-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libzip-dev \
    libcurl4-openssl-dev \
    libxml2-dev \
    libonig-dev \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libicu-dev \
    libc-client-dev \
    libkrb5-dev \
    libssl-dev \
    libldap2-dev \
    zip \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Configure extensions
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
    docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
    docker-php-ext-configure gd --with-freetype --with-jpeg

# Install extensions
RUN docker-php-ext-install -j$(nproc) \
    mysqli \
    pdo_mysql \
    mbstring \
    xml \
    curl \
    zip \
    gd \
    intl \
    soap \
    imap \
    ldap

