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
apt-get update
apt-get install -y gcc python-dev
apt-get install -y python-virtualenv

# create and activate virtual environment
mkdir -p /home/ubuntu/python_virtual_env
cd /home/ubuntu/python_virtual_env

virtualenv venv
. venv/bin/activate

# install latest version of pip
wget -Oget-pip.py https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm -r get-pip.py

# install a a set of python pip packages
pip install paramiko
pip install pyVmomi==6.5


# install proper version of setuptools
# pip install "setuptools==34.4.1"
# pip install pybuilder
# chmod +x venv/bin/pyb
git clone https://github.com/pybuilder/pybuilder.git pyb
cd pyb/
python setup.py install
cd ..
rm -rf pyb/


