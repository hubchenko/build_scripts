#!/bin/bash

##Script to set the hostname to the public DNS name in a AWS instance##
set -e

public_fqdn=''  #Public FQDN


# run script only as root
if [ $(id -u) != 0 ]; then
    echo "This script must be run as root"
    exit 1
fi


#setting hostname
sed -i "s/^127.0.0.1.*/127.0.0.1 $public_fqdn/" /etc/hosts
sed -i "1s/.*/$public_fqdn/" /etc/hostname
hostname $public_fqdn