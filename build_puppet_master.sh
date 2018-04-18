#!/bin/bash
set -e

public_fqdn='ec2-54-241-55-37.us-west-1.compute.amazonaws.com'
java_args='-Xms512m -Xmx512m'


# run script only as root
if [ $(id -u) != 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# set proxy, if needed
#export http_proxy="http://>>proxyserver<<:911"
#export https_proxy="https://>>proxyserver<<:911"

#setting hostname
sed -i "s/^127.0.0.1.*/127.0.0.1 $public_fqdn/" /etc/hosts
sed -i "1s/.*/$public_fqdn/" /etc/hostname
hostname $public_fqdn


# install required packages
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
rm puppetlabs-release-pc1-xenial.deb


# install required packages
apt-get update
apt-get install -y puppetserver
sed -i "s/^JAVA_ARGS=.*/JAVA_ARGS=\"$java_args\"/" /etc/default/puppetserver
apt-get install -y puppetdb
apt-get install -y puppet-agent

