FROM drupal:fpm-alpine
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk add \
    git \
    openssh-server \
    openssh-client \
	  nodejs \
    npm

# clone 私有库
RUN mkdir /root/.ssh/
ADD files/id_rsa /root/.ssh/id_rsa
ADD	files/id_rsa.pub /root/.ssh/id_rsa.pub
RUN		chmod 600 /root/.ssh/id_rsa && \
		chmod 600 /root/.ssh/id_rsa.pub
# Create known_hosts
RUN touch /root/.ssh/known_hosts
# Add bitbuckets key
RUN ssh-keyscan gitee.com >> /root/.ssh/known_hosts && \
			chmod 600 ~/.ssh/known_hosts && \
			chmod 755 ~/.ssh			

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer
RUN php -r "unlink('composer-setup.php');"
RUN composer self-update --1
ENV COMPOSER_PROCESS_TIMEOUT 1200
ENV COMPOSER_MEMORY_LIMIT -1

RUN mv /var/www/html /var/opt/drupal

# composer mirror
#RUN composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
RUN git clone -b ende git@gitee.com:dskj_1/drupal.git /var/www/html

WORKDIR /var/www/html
RUN composer install

RUN git clone git@gitee.com:dskj_1/dsi.git /var/www/html/modules/dsi
RUN composer update

RUN cd /var/www/html/modules/dsi/themes/materialize && \
    npm i && \
	npm i gulp-install -g

# Add composer module for auto testing
RUN composer require phpspec/prophecy-phpunit:^2
