# /etc/puppet/manifests/classes/sudo.pp

class sudo {
    file { "/etc/sudoers":
        owner => "root",
        group => "root",
        mode  => 440,
    }
}

