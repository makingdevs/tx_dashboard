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


[1,2,3,4,5].each do |i|
  random_amount = rand(1000.00..3000.00)

  json = """
    {
      \"account\": \"12345678\",
      \"type\": \"deposit\",
      \"origin\": \"transfer\",
      \"concept\": \"Some snacks\",
      \"amount\": #{random_amount},
      \"currency\": \"MXN\"
    }
  """
	x.publish(json, :routing_key => q.name)
end

sleep 1.0
conn.close
