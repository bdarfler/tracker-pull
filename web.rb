require 'sinatra'
require 'json'

post '/payload' do
  data = JSON.parse(request.body.read)
  TrackerPull::WebhookHandler.new(data).async.call
end
