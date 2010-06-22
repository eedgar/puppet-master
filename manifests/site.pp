# /etc/puppet/manifests/site.pp
import "defaults.pp"
import "modules.pp"

node default {
        include screen
}

node 'shoemaker.local' inherits default {
        include screen
        include cobbler::full
        include cobbler::centos
	sysctl::conf { "net.ipv4.ip_forward":  value => "1" }
}
