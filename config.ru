require 'rack-timeout'
use Rack::Timeout
Rack::Timeout.timeout = Integer(ENV['WEB_TIMEOUT'] || 30) - 1

$stdout.sync = true

require './web'
run Sinatra::Application
