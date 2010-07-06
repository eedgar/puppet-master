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
	cobbler::system { "node01": ip => "10.0.0.201", mac => "aa:aa:bb:bb:ff:01" }
	cobbler::system { "node02": ip => "10.0.0.202", mac => "aa:aa:bb:bb:ff:02" }
	cobbler::system { "node03": ip => "10.0.0.203", mac => "aa:aa:bb:bb:ff:03" }
}
