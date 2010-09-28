class puppet::server {
	file {"/srv/www/html/rrd":
		ensure  => directory,
	}

	package { ruby-RRDtool:
		name => $operatingsystem ? {
			default => "ruby-RRDtool"
			},
		ensure => present,
	}
}
class puppet::client {
	package { ruby-rdoc:
		name => $operatingsystem ? {
			default => "ruby-rdoc"
			},
		ensure => present,
	}
	package { augeas:
		name => $operatingsystem ? {
			default => "augeas"
			},
		ensure => present,
	}
	package { augeas-libs:
		name => $operatingsystem ? {
			default => "augeas-libs"
			},
		ensure => present,
	}
	package { ruby-augeas:
		name => $operatingsystem ? {
			default => "ruby-augeas"
			},
		ensure => present,
	}
	package { puppet:
		name => $operatingsystem ? {
			default => "puppet"
			},
		ensure => present,
	}
        service { puppet:
                name => $operatingsystem ? {
                        default => "puppet",
                        },
                ensure => running,
                enable => true,
                hasrestart => true,
                require => Package[puppet],
        }
}
