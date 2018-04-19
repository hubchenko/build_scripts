#!/bin/bash

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