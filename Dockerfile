FROM composer:1.5.2
RUN rm /etc/apk/repositories \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" >> /etc/apk/repositories \
    && echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/community/" >> /etc/apk/repositories
RUN apk add --update-cache --allow-untrusted \
        --virtual .build-deps \
        autoconf g++ make \
        && pecl install xdebug-2.5.5 \
        && docker-php-ext-enable xdebug \
        && apk del .build-deps \
        && rm -rf /tmp/* /tmp/.htaccess /var/cache/apk/*
WORKDIR /app
CMD ["composer"]
