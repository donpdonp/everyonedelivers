BUNNY = Bunny.new(SETTINGS["bunny"]["start"])
status = BUNNY.start
if status == "CONNECTED"
  BUNNY_EXCHANGE = BUNNY.exchange('email')
  EMAIL_QUEUE = BUNNY.queue('outbound_email')
  #EMAIL_QUEUE.bind(BUNNY_EXCHANGE, :key => 'outbound_email')
  puts "RabbitMQ #{status}"
else
  raise "RabbitMQ connection failed on #{BUNNY.host}:#{BUNNY.port}"
end
