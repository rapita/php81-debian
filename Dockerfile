# See: <https://roadrunner.dev/docs/intro-install>
FROM spiralscout/roadrunner:2.12.3 as roadrunner
# See: <https://github.com/mlocati/docker-php-extension-installer>
FROM mlocati/php-extension-installer:latest as php-extension-installer
FROM php:8.2.4-bullseye

COPY --from=php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/
COPY --from=roadrunner /usr/bin/rr /usr/local/bin/rr

# install php extensions and components
# todo: add grpc
RUN install-php-extensions \
        @fix_letsencrypt \
        amqp \
        bcmath \
        igbinary \
        imagick \
        mysqli \
        opcache \
        pcntl \
        pgsql \
        pdo_mysql \
        pdo_pgsql \
        rdkafka \
        redis \
        sockets \
        yaml \
        zip \
        xdebug-^3.1 \
        @composer-^2

# Install additional packages
RUN apt-get update \
    && apt-get install -y  \
      git; \
	rm -rf /var/lib/apt/lists/*

COPY php.ini /usr/local/etc/php/php.ini

# disable xdebug by default
RUN echo '' > /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
