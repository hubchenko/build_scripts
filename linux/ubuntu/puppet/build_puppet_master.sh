#!/bin/bash

#Bash Script that sets up a stand alone foreman instance
set -e

java_args='-Xms512m -Xmx512m'
foreman_host='foremanhost.compute.amazonaws.com'
foreman_auth_key=''
foreman_auth_secret=''


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
apt-get install -y foreman-installer
apt-get install -y puppet-agent
apt-get install -y puppetserver

sed -i "s/^JAVA_ARGS=.*/JAVA_ARGS=\"$java_args\"/" /etc/default/puppetserver

#puppet labs developed modules
/opt/puppetlabs/bin/puppet module install puppetlabs-windows --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-stdlib --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-ntp --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-apache --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-puppetdb --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-mysql --modulepath /etc/puppetlabs/code/modules
/opt/puppetlabs/bin/puppet module install puppetlabs-vcsrepo --modulepath /etc/puppetlabs/code/modules



#puppet forge approved modules
/opt/puppetlabs/bin/puppet module install stankevich-python --modulepath /opt/puppetlabs/puppet/modules
/opt/puppetlabs/bin/puppet module install maestrodev-wget --modulepath /opt/puppetlabs/puppet/modules

foreman-installer \
  --no-enable-foreman \
  --no-enable-foreman-cli \
  --no-enable-foreman-plugin-bootdisk \
  --no-enable-foreman-plugin-setup \
  --enable-puppet \
  --puppet-server-ca=true \
  --puppet-server-foreman-url=https://$foreman_host \
  --enable-foreman-proxy \
  --foreman-proxy-puppetca=true \
  --foreman-proxy-tftp=false \
  --foreman-proxy-foreman-base-url=https://$foreman_host \
  --foreman-proxy-trusted-hosts=$foreman_host \
  --foreman-proxy-oauth-consumer-key=$foreman_auth_key \
  --foreman-proxy-oauth-consumer-secret=$foreman_auth_secret
  # --puppet-server-puppetdb-host=puppetdb.example.com \
  # --puppet-server-reports=foreman,puppetdb \
  # --puppet-server-storeconfigs-backend=puppetdb
