FROM amazonlinux:2023 AS base

RUN dnf update -y \
    && dnf install -y  php-devel php-pear gcc make php8.4 php8.4-cli php8.4-mbstring php8.4-intl php8.4-pdo php8.4-zip php8.4-sodium php8.4-opcache php8.4-mysqlnd  php8.4-soap \
    && pecl install redis \
    && dnf remove -y  php-devel php-pear gcc make  \
    && dnf clean all

RUN adduser -u 1090 www-data \
    && mkdir  -p /var/www/html  \
    && chown www-data:www-data /var/www/html \
    && chmod 1777 /var/www/html

WORKDIR /var/www/html

CMD ["php", "-a"]

FROM base AS dev

RUN dnf update -y \
    && dnf install -y php-devel php-pear autoconf automake libtool make \
    && pecl install xdebug \
    && dnf remove -y php-devel php-pear autoconf automake libtool make \
    && dnf clean all

COPY etc/php-ext-xdebug.ini /etc/php.d/xdebug.ini

COPY composer-installater.sh /composer-installation.sh

RUN chmod +x /composer-installation.sh && /composer-installation.sh && rm /composer-installation.sh

FROM base AS prod

USER www-data
