class screen {

	package { screen:
		name => $operatingsystem ? {
			default => "screen",
			},
		ensure => present,
	}

}
