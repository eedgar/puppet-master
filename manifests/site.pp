file { "/etc/passwd":
   owner => "root",
   group => "bin",
   mode => 644,
}
package { "screen" :
ensure => installed
}
