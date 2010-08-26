#!/bin/bash
HOSTNAME=shoemaker.local
PING_HOST=192.9.9.3
USERNAME="Eric Edgar"
EMAIL="eedgar@zenoss.com"

cat > /etc/sysconfig/network << EOF
NETWORKING=yes
NETWORKING_IPV6=yes
HOSTNAME=$HOSTNAME
EOF
hostname $HOSTNAME

#/etc/init.d/network restart

ping -c1 $PING_HOST >/dev/null 2>&1
ret=$?
if [ $ret -ne 0 ]
then
   echo "Unable to ping $PING_HOST;  Assuming network configuration issue!"
   echo "Exiting...."
   exit 1
fi

rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3noarch.rpm

yum -y install ruby-rdoc
yum -y install git-svn
yum -y install augeas augeas-libs ruby-augeas 
yum -y install puppet-server --enablerepo=epel
yum -y install puppet --enablerepo=epel

chkconfig puppetmaster on

# this is a puppet master server ..
# -- Notes for setting up git on remote server --
# ssh 172.16.50.1 -l eedgar
# mkdir -p git_repos/puppet_master.git
#cd git_repos/puppet_master.git
#git --bare init
#git remote add origin ssh://eedgar@172.16.50.2/Users/eedgar/git_repos/puppet_master.git
#git push origin master
# Auto push puppet to remote
#echo 'git push' > .git/hooks/post-commit
#chmod 755 .git/hooks/post-commit

git config --global user.name $USERNAME
git config --global user.email $EMAIL
git config --global color.branch "auto"
git config --global color.status "auto"
git config --global color.diff "auto"
git config --global pack.threads "0"
git config --global diff.renamelimit "0"

# As root
rm -r /etc/puppet

#ro access to github
#git clone https://eedgar@github.com/eedgar/puppet-master.git
#rw access to github
git clone git@github.com:eedgar/puppet-master.git /etc/puppet

# testing 
#puppetmasterd --verbose --no-daemonize
#puppetd --server localhost.localdomain --verbose --waitforcert 60 --no-daemonize
#puppetca --list
