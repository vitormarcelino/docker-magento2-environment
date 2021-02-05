FROM php:7.4.15-fpm

# Configurations
ENV USER_NAME=app
ENV USER_ROOT=/home/app
ENV TZ=America/Recife

# Setup Environment
RUN apt update

RUN apt install -y git libcurl3-dev libxml2-dev libxslt-dev autoconf \
    zlib1g-dev libpng-dev libjpeg-dev libwebp-dev libjpeg62-turbo-dev libxpm-dev libfreetype6-dev \
    automake libtool m4 openssh-client libmcrypt-dev libpcre3-dev libzip-dev

# RUN docker-php-ext-configure gd \
#     --with-gd \
#     --with-webp \
#     --with-jpeg \
#     --with-png \
#     --with-zlib \
#     --with-xpm \
#     --with-freetype \
#     --enable-gd-native-ttf

RUN docker-php-ext-configure gd --with-webp --with-jpeg --with-xpm --with-freetype

# Setup PHP
RUN docker-php-ext-install bcmath iconv intl pdo_mysql simplexml soap xsl zip sockets gd
# RUN docker-php-ext-configure gd --with-freetype --with-jpeg
COPY www.conf /usr/local/etc/php-fpm.d/www.conf

# Install Composer
RUN curl https://getcomposer.org/download/1.10.17/composer.phar > composer && chmod +x composer && mv composer /usr/local/bin/composer

# Setup User
RUN mkdir -p $USER_ROOT
RUN useradd -u 1000 -d $USER_ROOT $USER_NAME
RUN chown -R $USER_NAME:$USER_NAME $USER_ROOT

# Setup Timezone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata