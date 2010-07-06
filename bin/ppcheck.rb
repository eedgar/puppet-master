#!/usr/bin/ruby

require 'rubygems'
require 'ruby-growl'

# use a dyndns host if you are mobile (or nsupdate)
host = "192.168.0.111" 

result = %x{/usr/bin/puppet --color false --parseonly /etc/puppet/manifests/site.pp}.chomp

if result.any?
    g = Growl.new host, "ruby-growl", ["ruby-growl Notification"]
    g.notify "ruby-growl Notification", "Puppetmaster Config Problem", result
end

