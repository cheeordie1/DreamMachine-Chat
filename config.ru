require 'bunlder/setup'
require 'yaml'
require 'faye'
bayeux = Faye::RackAdapter.new(:mount => '/faye', :timeout => 25)
run bayeux
