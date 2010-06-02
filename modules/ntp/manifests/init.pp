class ntp {
	package{ ntp: ensure => present }
	service{ ntpd: ensure => running }
}
