#!/bin/bash

apt-get -y update
apt-get -y install build-essential
apt-get -y install bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev postgresql-9.1 htop ruby-dev postgresql-server-dev-9.1

# configure PostgreSQL
sudo -u postgres psql postgres -c "CREATE ROLE photastic LOGIN PASSWORD 'photastic' CREATEDB"
