# Define sysctl::conf
#
# General sysctl main configuration file's inline modification define
# Use with caution, it's still at experimental stage and may break in untested circumstances
#
# Usage:
# sysctl::conf    { "net.ip_forward":  value => "1" }

define sysctl::conf ($value) {
    require sysctl
    augeas { "sysctl_conf_${name}":
	context   => "/files/etc/sysctl.conf",
	changes	  => [
		"set ${name} ${value}"
	],
    }
}
