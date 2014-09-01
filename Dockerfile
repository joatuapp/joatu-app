FROM ubuntu:14.04
MAINTAINER Alex Willemsma <alex@undergroundwebdevelopment.com>

ENV DEBIAN_FRONTEND noninteractive

# REPOS
RUN apt-get -y update
RUN apt-get install -y -q python-software-properties software-properties-common
RUN add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get -y update

# INSTALL
RUN apt-get install -y -q build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev ncurses-dev automake libtool bison subversion pkg-config libmysqlclient-dev libpq-dev make wget unzip git vim nano nodejs mysql-client mysql-server gawk libgdbm-dev libffi-dev

RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build

# Install ruby
RUN curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | ruby-build -v 2.1.1 --disable-install-rdoc --patch /usr/local

# Create a "web" user who will run the app, so we don't
# have to run everything as root.
RUN adduser web --home /home/web --shell /bin/bash --disabled-password --gecos ""
 
# Install base gems
RUN gem install bundler rubygems-bundler foreman --no-rdoc --no-ri
 
# Regenerate binstubs
RUN gem regenerate_binstubs

RUN apt-get install -y -q postgresql-client

# Preinstall majority of gems
ADD ./Gemfile /var/www/
ADD ./Gemfile.lock /var/www/
RUN chown -R web:web /var/www && \
  mkdir -p /var/bundle &&\
  chown -R web:web /var/bundle
RUN su -c "cd /var/www && bundle install --deployment --path /var/bundle" -s /bin/bash -l web

ADD . /var/www
RUN rm -f /var/www/.env
COPY docker-bundle-config /var/www/.bundle/config
RUN rm -f /var/www/tmp/sockets/unicorn.sock
RUN chown -R web:web /var/www

ENV RAILS_ENV production
ENV CORS_ORIGINS 'alpha.joatu.org'
ENV APP_HOST "alpha.joatu.org"
ENV API_ENDPOINT "http://api.alpha.joatu.org"
ENV API_SUBDOMAIN 'api.alpha'
ENV SECRET_KEY_BASE "485f9620d248bb568241616673ae66cb3862c8c2778ade2339e7b7f3e39bc5995dfeaa3f14423d0ca4ddbc04a97f826f82ae7f5641e2217d677c1ca9d7fd22f7"
ENV DEVISE_SECRET "9481003cb278553c94bea24994c288169cef26cdddbef73e86d59d53979e74b2b429e2c659f24398302bd81aa911cfb04a3095df9d88cf2077b5a2bbbbc022d4"
ENV DEVISE_MAILER_SENDER "noreply@joatu.com"
ENV DEVISE_PEPPER "e15e6e55eda06a9c1246466eeec407682a46709c6a6aa3fe735f1a41a35f2b61be3f1ca411f9e4892dbf2ec7a085c00bcb4d53ec77b2b7100b01c606338479b9"

USER web

EXPOSE 8080

WORKDIR /var/www

RUN bundle exec rake assets:precompile

CMD ["bin/docker_run"]
