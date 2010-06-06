class cman::base {
	package { cman:
		name => $operatingsystem ? {
			default => "cman"
			},
		ensure => present,
	}
}
