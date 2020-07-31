FROM php:7.2-cli-alpine3.12

RUN apk update --no-cache && \
    apk add composer zlib-dev postgresql-dev sqlite-dev && \
    docker-php-ext-install -j$(nproc) \
    mbstring \
    bcmath \
    zip \
    pdo \
    pdo_mysql \
    pdo_pgsql \
    pdo_sqlite

COPY . /usr/src/lumen
WORKDIR /usr/src/lumen

RUN composer install

COPY entrypoint.sh /provision/entrypoint.sh

ENTRYPOINT ["/provision/entrypoint.sh"]
CMD ["php", "artisan", "migrate", "--force"]
