require "bunny"

# Start a communication session with RabbitMQ
conn = Bunny.new
conn.start

# open a channel
ch = conn.create_channel
# ch.confirm_select

q = ch.queue("test_tx", :auto_delete => true, :durable => true)
x = ch.default_exchange

json = """
{
  'account': '123456',
  'type': {'withdraw': 'deposit'},
  'origin': {'counter': 'transfer'},
  'concept': 'Some item',
  'amount': 33333,
  'currency': 'MXN'
}
"""

[1,2,3].each do |i|
  x.publish(json, :routing_key => q.name)
end


# ch.close
conn.close
