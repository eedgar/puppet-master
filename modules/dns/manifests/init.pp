class dns::server::base {
	package { bind:
		name => $operatingsystem ? {
			default => "bind"
			},
		ensure => present,
	}
}
