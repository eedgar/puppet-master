class debmirror::base {
	package { debmirror:
		name => $operatingsystem ? {
			default => "debmirror"
			},
		ensure => present,
	}
        file { 
                "/etc/debmirror.conf":
                        mode => 644, owner => root, group => root,
                        require => Package[debmirror],
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/debmirror.conf",
                        },
                        content => template("debmirror/debmirror.conf"),
        }
}
