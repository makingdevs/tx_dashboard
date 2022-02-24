#!/usr/bin/env ruby
# encoding: utf-8

# require "rubygems"
require "bunny"

STDOUT.sync = true

conn = Bunny.new
conn.start

ch = conn.create_channel
q  = ch.queue("receive_tx", :auto_delete => false, :durable => true)
x  = ch.default_exchange

# q.subscribe do |delivery_info, metadata, payload|
#   puts "Received #{payload}"
# end

json = """
{
  \"account\": \"251678\",
	\"type\": {\"withdraw\": \"deposit\"},
  \"origin\": {\"counter\": \"transfer\"},
	\"concept\": \"Some snacks\",
	\"amount\": 3671.21,
	\"currency\": \"MXN\"
}
"""

[1,2,3,4,5].each do |i|
	x.publish(json, :routing_key => q.name)
end

sleep 1.0
conn.close
