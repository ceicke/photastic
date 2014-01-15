#!/bin/bash

apt-get -y update
apt-get -y install build-essential
apt-get -y install bash curl git patch bzip2 build-essential openssl libreadline6 libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libgdbm-dev ncurses-dev automake libtool bison subversion pkg-config libffi-dev libcurl3-dev imagemagick libmagickwand-dev libpcre3-dev postgresql-9.1 htop ruby-dev postgresql-server-dev-9.1

cd /home/vagrant

# check for RVM
which rvm &> /dev/null
if [ $? -eq 1 ]; then
  \curl -L https://get.rvm.io | bash -s stable
fi

source /home/vagrant/.profile
source /home/vagrant/.rvm/scripts/rvm

# check for Ruby
ruby -v | grep 2.0 &> /dev/null
if [ $? -eq 1 ]; then
  rvm install 2.0.0
  rvm use 2.0.0 --default
fi

gem source -r http://rubygems.org/
gem install bundler

source /home/vagrant/.bashrc
source /home/vagrant/.profile

# install the Gems
cd /vagrant
bundle install

# configure PostgreSQL
sudo -u postgres psql postgres -c "CREATE ROLE photastic LOGIN PASSWORD 'photastic' CREATEDB"
rake db:create
rake db:migrate

# output IP address
echo "Here is your IP address:"
ip -4 -f inet addr

# start the rails server
rails s -d
