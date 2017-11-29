FROM alpine:3.6

ENV TERM="xterm-color" \
    COMPOSER_PROCESS_TIMEOUT=40000 \
    COMPOSER_HOME="/usr/local/share/composer"

RUN apk update \
    && apk add bash curl gettext php7 php7-fpm \
      && sed -i 's/^listen\s*=.*$/listen = 0.0.0.0:9000/' /etc/php7/php-fpm.conf \
      && sed -i 's/^\;error_log\s*=.*$/error_log = \/dev\/stderr/' /etc/php7/php-fpm.conf \
      && sed -i 's/^\;error_log\s*=\s*syslog\s*$/error_log = \/dev\/stderr/' /etc/php7/php.ini \
      && ln -sf /usr/sbin/php-fpm7 /usr/sbin/php-fpm \
      && ln -sf /usr/bin/php7 /usr/bin/php \
    && apk add  php7-session php7-intl php7-gd php7-mcrypt php7-pdo php7-pdo_mysql php7-pdo_sqlite php7-curl \
      php7-json php7-phar php7-openssl php7-bcmath php7-dom php7-ctype php7-iconv php7-zip php7-xml php7-zlib php7-mbstring \
      php7-ldap php7-gettext php7-posix php7-pcntl php7-simplexml php7-tokenizer php7-xmlwriter php7-fileinfo \
    && mkdir -p /usr/local/bin && (curl -sL https://getcomposer.org/installer | php) \
      && mv composer.phar /usr/local/bin/composer \
    && mkdir /www \
    && rm -rf /var/cache/apk/*

EXPOSE 9000

ENV PATH="/usr/local/share/composer/vendor/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
ADD start /start
WORKDIR /www
CMD ["/start"]
