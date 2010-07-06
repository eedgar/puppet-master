# Define cobbler::system
#
# General cobbler system add 
#
# Usage:
# cobbler::system    

define cobbler::system ( $ip = false, $mac = false)
	{
	exec { "cobbler_host_${name}":
                command => "/usr/bin/cobbler system add --name=${name} --profile=puppet --dns-name='${name}.pixie'",
                logoutput => true,
                unless => "/usr/bin/cobbler system list|awk '{print \$1}'|grep ${name}; test $? -eq 0",
                notify => Exec["cobbler-sync"],
	}

	if $ip {
	exec { "cobbler_host_${name}_${ip}":
                command => "/usr/bin/cobbler system edit --name=${name} --ip='${ip}'",
                unless => "/usr/bin/cobbler system dumpvars --name=${name}|grep ip_address_eth0|awk -F: '{print \$2}'|grep ${ip}; test $? -eq 0",
                logoutput => true,
                notify => Exec["cobbler-sync"],
	     }
	}
	
	if $mac {
	exec { "cobbler_host_${name}_${mac}":
                command => "/usr/bin/cobbler system edit --name=${name} --mac-address='${mac}'",
                unless => "/usr/bin/cobbler system dumpvars --name=${name}|grep mac_address_eth0|awk -F': ' '{print \$2}'|grep ${mac}; test $? -eq 0",
                logoutput => true,
                notify => Exec["cobbler-sync"],
	     }
	}
	
}
