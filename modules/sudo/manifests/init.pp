class sudo {
	package { sudo:
		name => $operatingsystem ? {
			default => "sudo"
			},
		ensure => present,
	}
}
