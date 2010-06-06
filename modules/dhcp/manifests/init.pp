class dhcp::server::base {
	package { dhcp:
		name => $operatingsystem ? {
			default => "dhcp"
			},
		ensure => present,
	}
}
