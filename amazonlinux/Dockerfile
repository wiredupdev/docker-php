ARG PHP_VERSION="8.3"
ARG SAPI="cli"

FROM amazonlinux:2023 AS base_cli

RUN dnf update -y \
    && dnf install -y  php-devel php-pear gcc make php${PHP_VERSION} php${PHP_VERSION}-cli php${PHP_VERSION}-mbstring php${PHP_VERSION}-intl php${PHP_VERSION}-pdo php${PHP_VERSION}-zip php${PHP_VERSION}-sodium php${PHP_VERSION}-opcache php${PHP_VERSION}-mysqlnd  php${PHP_VERSION}-soap \
    && pecl install redis \
    && dnf remove -y  php-devel php-pear gcc make  \
    && dnf clean all

RUN adduser -u 1090 www-data \
    && mkdir  -p /var/www/html  \
    && chown www-data:www-data /var/www/html \
    && chmod 1777 /var/www/html

WORKDIR /var/www/html

FROM base AS dev_cli

RUN dnf update -y \
    && dnf install -y php-devel php-pear autoconf automake libtool make \
    && pecl install xdebug \
    && dnf remove -y php-devel php-pear autoconf automake libtool make \
    && dnf clean all

COPY etc/php-ext-xdebug.ini /etc/php.d/xdebug.ini

COPY composer-installater.sh /composer-installation.sh

RUN chmod +x /composer-installation.sh && /composer-installation.sh && rm /composer-installation.sh

CMD ["php", "-a"]

FROM base_cli AS prod_cli

USER www-data

FROM base_cli AS base_fpm

RUN dnf update -y \
     && dnf install -y php${PHP_VERSION}-fpm \
    && dnf remove -y  php-devel php-pear gcc make  \
    && dnf clean all

RUN mkdir -p /run/php-fpm/

COPY etc/zz-php-fpm-docker.conf /etc/php-fpm.d/zz-php-fpm-docker.conf

RUN   echo '[global]' >> /etc/php-fpm.conf \
     && echo 'include=/etc/php-fpm.d/*.conf'  >> /etc/php-fpm.conf

STOPSIGNAL SIGQUIT

EXPOSE 9000

CMD ["php-fpm", "-F"]

FROM base_fpm AS dev_fpm

RUN dnf update -y \
    && dnf install -y php-devel php-pear autoconf automake libtool make \
    && pecl install xdebug \
    && dnf remove -y php-devel php-pear autoconf automake libtool make \
    && dnf clean all

COPY etc/php-ext-xdebug.ini /etc/php.d/xdebug.ini

COPY composer-installater.sh /composer-installation.sh

FROM base_fpm AS prod_fpm

USER www-data
