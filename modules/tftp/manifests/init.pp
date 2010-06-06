class tftp::server::base {
	package { tftp-server:
		name => $operatingsystem ? {
			default => "tftp-server"
			},
		ensure => present,
	}
        file {
                "/etc/xinetd.d/tftp":
                        mode => 644, owner => root, group => root,
                        require => Package[tftp-server],
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/xinetd.d/tftp",
                        },
                        content => template("tftp/xinetd.tftp"),
        }
}
