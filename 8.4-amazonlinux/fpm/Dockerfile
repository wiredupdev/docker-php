FROM amazonlinux:2023 AS base

RUN dnf update -y \
    && dnf install -y  php-devel php-pear gcc make php8.4 php8.4-fpm php8.4-mbstring php8.4-intl php8.4-pdo php8.4-zip php8.4-sodium php8.4-opcache php8.4-mysqlnd  php8.4-soap \
    && pecl install redis \
    && dnf remove -y  php-devel php-pear gcc make  \
    && dnf clean all

RUN adduser -u 1090 www-data \
    && mkdir  -p /var/www/html  \
    && chown www-data:www-data /var/www/html \
    && chmod 1777 /var/www/html \
    && mkdir -p /run/php-fpm/

COPY etc/zz-php-fpm-docker.conf /etc/php-fpm.d/zz-php-fpm-docker.conf

RUN   echo '[global]' >> /etc/php-fpm.conf \
     && echo 'include=/etc/php-fpm.d/*.conf'  >> /etc/php-fpm.conf

STOPSIGNAL SIGQUIT

EXPOSE 9000

WORKDIR /var/www/html

CMD ["php-fpm", "-F"]

FROM base AS dev

RUN dnf update -y \
    && dnf install -y php-devel php-pear autoconf automake libtool make \
    && pecl install xdebug \
    && dnf remove -y php-devel php-pear autoconf automake libtool make \
    && dnf clean all

COPY etc/php-ext-xdebug.ini /etc/php.d/xdebug.ini

FROM base AS prod
USER www-data
