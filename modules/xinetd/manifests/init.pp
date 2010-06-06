class xinetd::server::base {
	package { xinetd:
		name => $operatingsystem ? {
			default => "xinetd"
			},
		ensure => present,
	}
        service { xinetd:
                name => $operatingsystem ? {
                        default => "xinetd",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                require => Package[xinetd],
        }
}
