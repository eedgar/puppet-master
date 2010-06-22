class cobbler::centos {
        exec { centos55-i386 :
                command => "/usr/bin/cobbler import --path=rsync://ftp.linux.ncsu.edu/CentOS/5.5/os/i386/ --name=centos5 --arch=x86",
                logoutput => true,
                unless => "/usr/bin/cobbler distro list|grep centos5-i386; test $? -eq 0",
        }
        exec { centos55-updates-i386 :
                command => "/usr/bin/cobbler repo add --name=centos5.5-i386-updates --priority=70 --mirror=http://mirror.cs.vt.edu/pub/CentOS/5.5/updates/i386/ --mirror-locally=1",
                logoutput => true,
                unless => "/usr/bin/cobbler repo list|grep centos5.5-i386-updates; test $? -eq 0",
        }
        exec { EPEL-i386 :
                command => "/usr/bin/cobbler repo add --name=EPEL-i386 --priority=40 --mirror=http://ftp.osuosl.org/pub/fedora-epel/5/i386/ --mirror-locally=1",
                logoutput => true,
                unless => "/usr/bin/cobbler repo list|grep EPEL-i386; test $? -eq 0",
        }
	exec { centos-5-i386-EPEL:
		command => "/usr/bin/cobbler profile edit --name=centos5-i386 --repos='EPEL-i386 centos5.5-i386-updates'",
		logoutput => true,
		unless => "/usr/bin/cobbler profile find --repos=EPEL-i386|grep centos5-i386; test $? -eq 0",
	}
}
#cobbler repo add --name=EPEL-i386 --priority=40 --mirror=http://download.fedora.redhat.com/pub/epel/5/i386 --mirror-locally=0
#cobbler repo add --name=centos5.5-i386-updates --priority=70 --mirror=http://mirror.cs.vt.edu/pub/CentOS/5.5/updates/i386/ --mirror-locally=0
#cobbler profile edit --name=centos5-i386 --repos='EPEL-i386 centos5.5-i386-updates'
