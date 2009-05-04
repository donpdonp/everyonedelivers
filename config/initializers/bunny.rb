BUNNY = Bunny.new(SETTINGS["bunny"]["start"])
status = BUNNY.start
if status == "CONNECTED"
  EMAIL_QUEUE = BUNNY.queue('outbound_email')
  puts "RabbitMQ #{status}"
else
  raise "RabbitMQ connection failed on #{BUNNY.host}:#{BUNNY.port}"
end
