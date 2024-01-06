FROM php:8.0-apache
MAINTAINER Alex Tselegidis (alextselegidis.com)

ENV VERSION="1.4.3"
ENV BASE_URL="http://localhost"
ENV LANGUAGE="english"
ENV DEBUG_MODE="FALSE"
ENV DB_HOST="db"
ENV DB_NAME="easyappointments"
ENV DB_USERNAME="root"
ENV DB_PASSWORD="secret"
ENV PATH="$PATH:/srv/node/bin:/srv/"

EXPOSE 80
WORKDIR /srv

COPY ./assets/99-overrides.ini /usr/local/etc/php/conf.d
COPY ./assets/docker-entrypoint.sh /usr/local/bin

# system requirements
RUN apt-get update \
    && apt-get install -y libfreetype-dev libjpeg62-turbo-dev libpng-dev wget git unzip \
	&& curl -sSL https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions -o - | sh -s \
      curl gd mbstring mysqli xdebug gettext \
    && docker-php-ext-enable xdebug \
    && echo "alias ll=\"ls -al\"" >> /root/.bashrc \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# get composer and node
RUN wget https://raw.githubusercontent.com/composer/getcomposer.org/76a7060ccb93902cd7576b67264ad91c8a2700e2/web/installer -O - -q | php -- --quiet \
    && mv composer.phar /usr/bin/composer
RUN wget https://nodejs.org/dist/v20.10.0/node-v20.10.0-linux-x64.tar.xz \
    && tar -xf node-v20.10.0-linux-x64.tar.xz \
    && mv node-v20.10.0-linux-x64 node \
    && rm node-v20.10.0-linux-x64.tar.xz

# run the build
COPY ./easyappointments .
RUN npm i \
    && composer install \
    && npm run build
RUN cp -r ./build/* /var/www/html

# copy built files and change ownership
WORKDIR /var/www/html
RUN cd /var/www/html \
    && chown -R www-data:www-data . \
    && rm -rf /srv/

ENTRYPOINT ["docker-entrypoint.sh"]
