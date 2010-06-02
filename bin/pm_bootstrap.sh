# VMWARE tip - (custom vnet without dhcp)
http://communities.vmware.com/thread/108167?start=150&amp;tstart=0



#rpm -Uvh http://download.fedora.redhat.com/pub/epel/5Server/x86_64/epel-release-5-3.noarch.rpm
rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm

yum -y install ruby-rdoc
yum -y install git-svn
yum -y install puppet-server --enablerepo=epel
yum -y install puppet --enablerepo=epel


# this is a puppet master server ..
# -- Notes for setting up git on remote server --
# ssh 172.16.50.1 -l eedgar
# mkdir -p git_repos/puppet_master.git
#cd git_repos/puppet_master.git
#git --bare init
git config --global user.name "Eric Edgar"
git config --global user.email "eedgar@zenoss.com"
git config --global color.branch "auto"
git config --global color.status "auto"
git config --global color.diff "auto"
# 
git config --global pack.threads "0"
git config --global diff.renamelimit "0"

#git remote add origin ssh://eedgar@172.16.50.2/Users/eedgar/git_repos/puppet_master.git
#git push origin master

#.bash_profile
#GIT=/usr/local/git/bin
#export PATH=$GIT:/usr/local/bin:/usr/local/sbin:$PATH
ln -s .bash_profile .bashrc

# http://www.webtatic.com/blog/2009/09/git-on-centos-5/
# pull git repo now 

# As root
#rm -r /etc/puppet
#git clone ssh://eedgar@172.16.50.1/Users/eedgar/git_repos/puppet_master.git /etc/puppet


# testing 
#puppetmasterd --verbose --no-daemonize
#puppetd --server localhost.localdomain --verbose --waitforcert 60 --no-daemonize
#puppetca --list

# Auto push puppet to remote
echo 'git push' > .git/hooks/post-commit
chmod 755 .git/hooks/post-commit

# Set hostname <-- puppet.edgar.loc
#     update /etc/sysconfig/network 
# --> rm -rf /var/lib/puppet/ssl/ <-- reset ssl for new hostname
# update /etc/hosts
# 172.16.50.11    puppet.edgar.loc puppet pm puppet-master
# Install screen
# update sudoers
# update /etc/group for eedgar user
# update /etc/sysconfig/network 


# dhcp
# dns
# router
# bootstrap system ( cobbler? )
#yum -y install cobbler
#yum -y install koan
#yum -y install cobbler-web
#yum -y install debmirror
#yum -y install cman
#yum -y install dnsmasq
#   cobbler import --mirror=/media/cdrom --name=Centos5 --arch=x86
#cobbler import --path=rsync://ftp.linux.ncsu.edu/CentOS/5/os/x86_64/ --name=centos5 --arch=x86_64
setsebool -P httpd_can_network_connect=1
/etc/init.d/cobblerd start
#http://consultancy.edvoncken.net/index.php/HOWTO_Configure_Cobbler_on_Fedora_or_Red_Hat
cobbler import --path=rsync://ftp.linux.ncsu.edu/CentOS/5.5/os/i386/ --name=centos5 --arch=x86
 cobbler get-loaders
chkconfig tftp on
chkconfig rsync on 
/usr/sbin/semanage fcontext -a -t public_content_t "/tftpboot/.*" && \
    /usr/sbin/semanage fcontext -a -t public_content_t "/var/www/cobbler/images/.*"

vi /etc/cobbler
vi /etc/xinetd.d/tftp disable=no
vi /etc/xinetd.d/rsync disable=no
4 : comment 'dists' on /etc/debmirror.conf for proper debian support
5 : comment 'arches' on /etc/debmirror.conf for proper debian support

# configure dnsmasq
# start dnsmasq

#chkconfig httpd on
# disable selinux and firewall
#cobbler system add --name=pclient --mac=00:0c:29:f9:25:13 --profile=centos5-i386
#cobbler sync
### EDIT ###
#cobbler system edit --name pclient --dns-name=pclient.edgar.loc --netboot-enabled=1
#cobbler sync

# packet forwarding
# /etc/sysctl.conf
#net.ipv4.ip_forward=1
#sysctl -p
#/sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# add epel to cobbler (no local copy to save time and disk space for now)
#cobbler repo add --name=EPEL-i386 --priority=40 --mirror=http://download.fedora.redhat.com/pub/epel/5/i386 --mirror-locally=0
#cobbler repo add --name=centos5.5-i386-updates --priority=70 --mirror=http://mirror.cs.vt.edu/pub/CentOS/5.5/updates/i386/ --mirror-locally=0
#cobbler reposync

# add the new repos to the profile
#cobbler profile edit --name=centos5-i386 --repos="EPEL-i386 centos5.5-i386-updates"
#cobbler sync

# update puppet.ks profile
cd /var/lib/cobbler/kickstarts

