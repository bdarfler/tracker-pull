require 'octokit'

module TrackerPull
  class GitHub

    def initialize(token)
      @client = Octokit::Client.new(access_token: token)
    end

    def comment_on_pr(project, pr_number, comment)
      @client.add_comment(project, pr_number, comment)
    end

  end
end
