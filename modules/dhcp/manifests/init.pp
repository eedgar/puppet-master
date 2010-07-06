class dhcp::server::base {
	package { dhcp:
		name => $operatingsystem ? {
			default => "dhcp"
			},
		ensure => present,
	}
        service { dhcpd:
                name => $operatingsystem ? {
                        default => "dhcpd",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                require => Package[dhcp],
        }


}
