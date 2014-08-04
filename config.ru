require 'rack-timeout'
use Rack::Timeout
Rack::Timeout.timeout = Integer(ENV['WEB_TIMEOUT'] || 30) - 1

$stdout.sync = true

require './web'
require './webhook_handler'
require './github'
require './pivotal_tracker'
require './pull_request'
run Sinatra::Application
