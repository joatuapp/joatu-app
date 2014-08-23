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
COPY docker-bundle-config /var/www/.bundle/config
RUN rm -f /var/www/tmp/sockets/unicorn.sock
RUN chown -R web:web /var/www

ENV RAILS_ENV production

USER web

EXPOSE 8080

WORKDIR /var/www

RUN bundle exec rake assets:precompile

CMD ["foreman", "start", "web"]
