FROM ubuntu:14.04

# MAINTAINER Alex Willemsma "alex@undergroundwebdevelopment.com"
 
# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r postgres && useradd -r -g postgres postgres

RUN locale-gen en_US.UTF-8
RUN apt-get update && LC_ALL=en_US.UTF-8 apt-get install -y curl
 
RUN echo 'deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main' > /etc/apt/sources.list.d/pgdg.list
 
RUN curl -sSL https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update && LC_ALL=en_US.UTF-8 apt-get install -y postgresql-9.3

# /etc/ssl/private can't be accessed from within container for some reason
# (@andrewgodwin says it's something AUFS related)
RUN mkdir /etc/ssl/private-copy; mv /etc/ssl/private/* /etc/ssl/private-copy/; rm -r /etc/ssl/private; mv /etc/ssl/private-copy /etc/ssl/private; chmod -R 0700 /etc/ssl/private; chown -R postgres /etc/ssl/private

ADD postgresql.conf /etc/postgresql/9.3/main/postgresql.conf
ADD pg_hba.conf /etc/postgresql/9.3/main/pg_hba.conf
 
RUN curl -o /usr/local/bin/gosu -SL 'https://github.com/tianon/gosu/releases/download/1.0/gosu' \
  && chmod +x /usr/local/bin/gosu
 
ENV PATH /usr/lib/postgresql/9.3/bin:$PATH
VOLUME /var/lib/postgresql
 
ADD ./docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
CMD ["/docker-entrypoint.sh"]

EXPOSE 5432
