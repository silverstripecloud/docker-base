FROM php:7-apache-buster as silverstripe

RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf \
    && echo "date.timezone = Europe/Berlin" > /usr/local/etc/php/conf.d/timezone.ini \
    && a2enmod \
        rewrite \
        expires \
        remoteip \
        cgid

RUN apt-get update -y \
    && apt-get install -y --no-install-recommends \
        libgd-dev \
        libicu-dev \
        libtidy-dev \
        libxslt-dev \
        zlib1g-dev

# Install PHP Extensions
RUN docker-php-ext-configure intl \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure gd --with-libdir=/usr/include/ --enable-gd --with-jpeg --with-freetype

RUN docker-php-ext-install -j$(nproc) \
        intl \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        soap \
        tidy \
        xsl
