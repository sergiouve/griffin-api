FROM ubuntu:20.04

WORKDIR /griffin

ENV TZ UTC
ENV RUBY_VERSION 3.0.0
ENV RAILS_VERSION 6.1.0

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Basic server configuration
RUN set -x \
    && apt-get update \
    && apt-get install -y gnupg \
    && echo "deb http://ppa.launchpad.net/nginx/development/ubuntu bionic main" > /etc/apt/sources.list.d/ppa_nginx_mainline.list \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E5267A6C \
    && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys C300EE8C \
    && apt-get update \
    && apt-get install -y build-essential wget curl git supervisor sqlite3 libsqlite3-dev openssh-server mysql-server mysql-client libmysqlclient-dev libgmp-dev nginx \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

# Install Ruby
RUN apt-get update \
    && apt-get install -y ruby-full \
    && ruby -v

# Install Rails
RUN gem install bundler \
    && gem install rails -v $RAILS_VERSION \
    && rails -v

# Install Dockerize
ENV DOCKERIZE_VERSION v0.6.1
RUN wget -q https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY vhost.conf /etc/nginx/sites-available/default

COPY Gemfile /griffin/Gemfile
COPY Gemfile.lock /griffin/Gemfile.lock

EXPOSE 3000

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
