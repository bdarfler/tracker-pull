require 'sucker_punch'

module TrackerPull
  class PullRequest
    include SuckerPunch::Job

    def perform pr
      if pr['action'] == 'opened' && !qa_skip?(pr)
        # Do Stuff
      end
    end

    private

    def qa_skip? pr
      pr['pull_request']['title'].downcase.include?('[qa skip]')
    end

  end
end
