Exec { path => "/bin:/sbin:/usr/bin:/usr/sbin" }

# Filebuckets
filebucket { main: server => 'shoemaker.local' }
filebucket { local: path => "/var/lib/puppet/clientbucket" }
