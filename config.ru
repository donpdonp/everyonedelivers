# This file is used by Rack-based servers to start the application.
SETTINGS = YAML.load(File.open(File.join(File.dirname(__FILE__), "config/settings.yml")))

require './lib/shorten'
require ::File.expand_path('../config/environment',  __FILE__)

use Shorten

builder = Rack::Builder.new do
  map '/assets' do
    run Rack::File.new(File.join(File.dirname(__FILE__),"public/assets/"))
  end

  map '/' do
    run EveryoneDelivers::Application
  end
end
run builder
