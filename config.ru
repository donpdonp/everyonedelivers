# This file is used by Rack-based servers to start the application.
SETTINGS = YAML.load(File.open(File.join(File.dirname(__FILE__), "config/settings.yml")))

require './lib/shorten'
require ::File.expand_path('../config/environment',  __FILE__)

use Shorten
run EveryoneDelivers::Application
