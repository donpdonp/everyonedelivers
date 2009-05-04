BUNNY = Bunny.new
status = BUNNY.start
if status == "CONNECTED"
  puts "RabbitMQ #{status}"
else
  raise "RabbitMQ connection failed"
end
