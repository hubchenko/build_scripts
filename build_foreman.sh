#!/bin/bash
set -e

public_fqdn='ec2-54-241-68-62.us-west-1.compute.amazonaws.com'


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
echo "deb http://deb.theforeman.org/ xenial 1.16" > /etc/apt/sources.list.d/foreman.list
echo "deb http://deb.theforeman.org/ plugins 1.16" >> /etc/apt/sources.list.d/foreman.list
apt-get -y install ca-certificates
wget -q https://deb.theforeman.org/pubkey.gpg -O- | apt-key add -


# install required packages
apt-get update
apt-get install -y foreman-installer
apt-get install -y puppet-agent

