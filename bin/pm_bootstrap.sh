rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-3.noarch.rpm

yum -y install git-svn
yum -y install puppet-server

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
