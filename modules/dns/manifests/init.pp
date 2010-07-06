class dns::server::base {
	package { bind:
		name => $operatingsystem ? {
			default => "bind"
			},
		ensure => present,
	}
        service { named:
                name => $operatingsystem ? {
                        default => "named",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                require => Package[bind],
        }


}
