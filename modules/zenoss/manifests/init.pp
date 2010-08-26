class zenoss::core::301 {
  exec { "download-zenoss-core301":
    cwd => "/root",
    command => "/usr/bin/wget http://downloads.sourceforge.net/zenoss/zenoss-3.0.1.el5.i386.rpm",
    creates => "/root/zenoss-3.0.1.el5.i386.rpm",
  }
  
  exec { "install-zenoss-core301":
    cwd => "/root",
    command => "rpm -ihv /root/zenoss-3.0.1.el5.i386.rpm",
    creates => "/opt/zenoss",
    require => Exec["download-zenoss-core301"],
  }
  
}

