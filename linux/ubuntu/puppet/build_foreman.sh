#!/bin/bash
set -e

foreman_db_host='foreman.somedatabaseendpoint.amazonaws.com'
foreman_db_username='foreman'
foreman_db_password=''
foreman_db_name='postgresql'


# run script only as root
if [ $(id -u) != 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
rm puppetlabs-release-pc1-xenial.deb
echo "deb http://deb.theforeman.org/ xenial 1.16" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.16" >> /etc/apt/sources.list.d/foreman.list
apt-get -y install ca-certificates
wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -

# install required packages
apt-get update
apt-get update
apt-get install -y foreman-installer
apt-get install -y puppet-agent


foreman-installer \
  --foreman-db-type=postgresql \
  --foreman-db-manage=false \
  --foreman-db-host=$foreman_db_host \
  --foreman-db-database=$foreman_db_name  \
  --foreman-db-username=$foreman_db_username   \
  --foreman-db-password=$foreman_db_password  
  --puppet-server=false \
  --foreman-proxy-puppet=false \
  --foreman-proxy-puppetca=false