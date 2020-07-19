FROM php:zts-alpine as silverstripe
LABEL maintainer="SilverStripe Cloud <dev@silverstripecloud.com>"
RUN apk add --no-cache \
        autoconf \
        imagemagick-dev \
        libpng-dev \
        libxslt-dev \
        make \
        php7-pecl-imagick \
        icu-dev \
        libgdata-dev \
        tidyhtml-dev \
        zlib-dev \
        icu-libs \
        libjpeg \
        tidyhtml-libs \
    && docker-php-ext-configure gd --with-libdir=/usr/include/ \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure mysqli --with-mysqli=mysqlnd \
    && docker-php-ext-configure tidy \
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
    && apk del \
        autoconf \
        imagemagick-dev \
        libpng-dev \
        libxslt-dev \
        make \
        php7-pecl-imagick \
        icu-dev \
        libgdata-dev \
        tidyhtml-dev \
        zlib-dev
