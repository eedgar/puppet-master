class httpd::server::base {
	package { httpd:
		name => $operatingsystem ? {
			default => "httpd"
			},
		ensure => present,
	}
        service { httpd:
                name => $operatingsystem ? {
                        default => "httpd",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                require => Package[httpd],
        }
}
