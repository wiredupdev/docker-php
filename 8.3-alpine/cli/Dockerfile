FROM php:8.3-cli-alpine as Base

RUN apk update && apk upgrade --no-cache \
    && apk add  icu   libzip libxml2  zip  bzip2  libgd  libpng libjpeg-turbo libwebp tiff freetype libpq libxslt \
    && apk add --no-cache --virtual build-deps $PHPIZE_DEPS   \
    g++ \
    autoconf \
    make \
    icu-dev \
    libzip-dev \
    libxml2-dev \
    zip \
    bzip2-dev \
    libgd \
    libpng-dev \
    libjpeg-turbo-dev \
    libwebp-dev \
    tiff-dev \
    freetype-dev \
    libpq-dev \
    libxslt-dev \
   && apk add --update --no-cache linux-headers \
   && pecl install ds redis \
   && docker-php-ext-enable xdebug ds redis \
   && docker-php-ext-configure intl \
   && docker-php-ext-configure zip \
   && docker-php-ext-configure pgsql --with-pgsql=/usr/local/pgsql \
   && docker-php-ext-configure bz2  \
   && docker-php-ext-configure gd  --with-freetype=/usr/include/ --with-jpeg=/usr/include/  --with-webp=/usr/include/  \
   && docker-php-ext-install -j$(nproc) gd \
   && docker-php-ext-install  intl bz2 exif zip bcmath mysqli pgsql pdo pdo_pgsql pdo_mysql soap sockets xsl \
   && apk del -f build-deps \

USER www-data

RUN chmod 0775 /var/www/html

WORKDIR /var/www/html

FROM Base as Dev

RUN pecl install xdebug

COPY etc/php-ext-xdebug.ini  /usr/local/etc/php/conf.d/php-ext-xdebug.ini

COPY composer-installater.sh /composer-installation.sh

RUN chmod +x tool/composer-installation.sh && /composer-installation.sh && rm /composer-installation.sh

CMD ["composer", "self-update", "clear-cache"]

FROM Base as  Prod

RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"