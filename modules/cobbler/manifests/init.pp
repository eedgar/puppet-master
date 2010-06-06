class cobbler {
	package { cobbler:
		name => $operatingsystem ? {
			default => "cobbler",
			},
		ensure => present,
	}
	package { syslinux:
		name => $operatingsystem ? {
			default => "syslinux",
			},
		ensure => present,
	}
	
	service { cobblerd:
		name => $operatingsystem ? {
			default => "cobblerd",
			},
		ensure => running,	
		enable => true,	
		hasrestart => true,	
		require => Package[cobbler],
	}

	file { 
		"/etc/cron.daily/cobbler-reposync":
			mode => 755, owner => root, group => root,
			require => Package[cobbler],
			ensure => present,
			source => "puppet://$servername/modules/cobbler/cobbler-reposync",
	}

	file { 
		"/etc/cobbler/settings":
			mode => 755, owner => root, group => root,
			require => Package[cobbler],
			ensure => present,
			path => $operatingsystem ?{
				default => "/etc/cobbler/settings",
			},
	}

	file { 
		"/etc/cobbler/dhcp.template":
			mode => 755, owner => root, group => root,
			require => Package[cobbler],
			ensure => present,
			path => $operatingsystem ?{
				default => "/etc/cobbler/dhcp.template",
			},
			content => template("cobbler/dhcp.template"),
	}
	
	file { 
		"/etc/cobbler/named.template":
			mode => 755, owner => root, group => root,
			require => Package[cobbler],
			ensure => present,
			path => $operatingsystem ?{
				default => "/etc/cobbler/named.template",
			},
			content => template("cobbler/named.template"),
	}
	
	exec { subscribe-sync:
		command => "/usr/bin/cobbler sync",
		logoutput => true,
		onlyif => "/bin/false",
		subscribe => [ file["/etc/cobbler/settings"],
			       file["/etc/cobbler/dhcp.template"],
			       file["/etc/cobbler/named.template"],
		 ]	
	}
	exec { cobbler-bootloaders:
		command => "/usr/bin/cobbler get-loaders",
		logoutput => true,
		onlyif => "test ! -f /var/lib/cobbler/loaders/elilo-ia64.efi"
	}		
}

# Full cobbler server PXE - DHCP - DNS
# Add in dhcpd and tftp and dns modules

#Package[tftp-server],Package[bind]],
class cobbler::full inherits cobbler {
	require cman::base
	require debmirror::base
	require dns::server::base
	require dhcp::server::base
	require httpd::server::base
	require rsync::server::base
	require tftp::server::base
	require xinetd::server::base
	File["/etc/cobbler/settings"] {
		require => [ Package[cobbler] , Package[dhcp]],
		content => template("cobbler/settings-full"),
	}
}
