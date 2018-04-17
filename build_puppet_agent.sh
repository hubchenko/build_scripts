#!/bin/bash
set -e

# run script only as root
if [ $(id -u) != 0 ]; then
    echo "This script must be run as root"
    exit 1
fi

# set proxy, if needed
#export http_proxy="http://>>proxyserver<<:911"
#export https_proxy="https://>>proxyserver<<:911"

# install required packages
cd /tmp
wget https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
rm puppetlabs-release-pc1-xenial.deb


# install required packages
apt-get update
apt-get install -y puppet-agent
