require 'net/http'
require 'json'

module TrackerPull
  class PivotalTracker

    TRACKER_URI_BASE = 'https://www.pivotaltracker.com/services/v5/projects'

    def initialize(token)
      @token = token
      uri = URI(TRACKER_URI_BASE)
      @conn = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https')
    end

    def find_story(sid)
      get_project_ids.map { |pid| get_story(pid, sid) }.compact.first
    end

    def comment_on_story(story, comment)
      uri = story['url']
      data = JSON.dump({comment: {text: comment}})
      @conn.send_request('PUT', uri, data, request_headers)
    end

    private

    def get_story(pid, sid)
      uri =  URI("#{TRACKER_URI_BASE}/#{pid}/stories/#{sid}")
      response = @conn.send_request('GET', uri, '', request_headers)
      response.code == '200' ? JSON.parse(response.body) : nil
    end

    def get_project_ids
      uri = URI(TRACKER_URI_BASE)
      response = @conn.send_request('GET', uri, '', request_headers)
      response.code == '200' ? JSON.parse(response.body).map { |p| p['id'] } : []
    end

    def request_headers
      {'X-TrackerToken' => @token, 'Content-Type' => 'application/json'}
    end

  end
end
