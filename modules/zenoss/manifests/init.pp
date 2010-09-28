class zenoss {
        package{ mysql-server: ensure => present }
        package{ net-snmp: ensure => present }
        package{ net-snmp-utils: ensure => present }
        package{ gmp: ensure => present }
        package{ libgomp: ensure => present }
        package{ libgcj: ensure => present }
        package{ liberation-fonts: ensure => present }

        service{ mysqld: ensure => running }
}

class zenoss::core301 inherits zenoss {


	#type=> "core or enterprise"
        #"src/stack/rpm"
	download_file { [zenoss-3.0.1.el5.i386.rpm]:
		site => "http://downloads.sourceforge.net/zenoss"
		cwd => "/tmp"
		creates => "/tmp/$name"
		}
	#exec { "download-zenoss-core301":
	#	cwd => "/root",
	#	command => "/usr/bin/wget http://downloads.sourceforge.net/zenoss/zenoss-3.0.1.el5.i386.rpm",
	#	creates => "/root/zenoss-3.0.1.el5.i386.rpm",
	#}

	exec { "install-zenoss-core301":
		cwd => "/root",
		command => "rpm -ihv /root/zenoss-3.0.1.el5.i386.rpm",
		creates => "/opt/zenoss",
		require => Exec["download-zenoss-core301"],
	}
}
