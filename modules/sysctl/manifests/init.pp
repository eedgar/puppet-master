import "defines/*.pp"

class sysctl {
    file { "sysctl.conf":
            mode   => 644, owner => root, group => root,
            ensure => present,
            path   => "/etc/sysctl.conf",
    }

    exec { "sysctl -p":
            subscribe   => File["sysctl.conf"],
            refreshonly => true,
    }
}

