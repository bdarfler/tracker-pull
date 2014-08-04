require 'sinatra'
require 'json'

post '/payload' do
  data = JSON.parse(request.body.read)
  TrackerPull::WebhookHandler.new.async.perform(data)
end
