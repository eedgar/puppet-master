# /etc/puppet/manifests/site.pp

import "classes/*"

node default {
	include sudo
}

node puppet {
	include ntp
	include cobbler
}
