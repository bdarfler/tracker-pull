require 'sinatra'
require 'json'

post '/payload' do
  pr = JSON.parse(request.body.read)
  TrackerPull::PullRequest.new.async.perform(pr)
end
