FROM php:8.1.0beta1-apache as silverstripe
LABEL maintainer="SilverStripe Cloud <dev@silverstripecloud.com>"
RUN echo "ServerName localhost" > /etc/apache2/conf-available/fqdn.conf \
    && echo "date.timezone = Europe/Berlin" > /usr/local/etc/php/conf.d/timezone.ini \
    && a2enmod \
        rewrite \
        expires \
        remoteip \
        cgid \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        autoconf \
        libpng-dev \
        libxslt-dev \
        make \
        imagemagick-common \
        libgd-dev \
        libicu-dev \
        libmagickwand-dev \
        libtidy-dev \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure gd --with-libdir=/usr/include/ --enable-gd --with-jpeg --with-freetype \
    && pecl channel-update pecl.php.net \
    && pecl install imagick \
    && docker-php-ext-install \
        intl \
        gd \
        mysqli \
        pdo \
        pdo_mysql \
        soap \
        tidy \
        xsl \
    && docker-php-ext-enable imagick \
    && apt-get purge -y \
        autoconf \
        libpng-dev \
        libxslt-dev \
        make \
        imagemagick-common \
        libgd-dev \
        libicu-dev \
        libmagickwand-dev \
        libtidy-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
