class dhcp::server {
	package { "dhcp":
		ensure => installed,
	}
}
