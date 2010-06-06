class rsync::server::base {
	package { rsync:
		name => $operatingsystem ? {
			default => "rsync"
			},
		ensure => present,
	}
        file {
                "/etc/xinetd.d/rsync":
                        mode => 644, owner => root, group => root,
                        require => Package[rsync],
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/xinetd.d/rsync",
                        },
                        content => template("rsync/xinetd.rsync"),
        }
}
