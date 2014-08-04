module TrackerPull
  class PullRequest

    STORY_ID_RE = /.*?(\d{6,10}).*?/

    def initialize(data)
      @data = data
    end

    def url
      pr['html_url']
    end

    def title
      pr['title']
    end

    def repo_name
      pr['repository']['full_name']
    end

    def branch_name
      pr['head']['ref']
    end

    def number
      @data['number']
    end

    def action
      @data['action']
    end

    def opened?
      action == 'opened'
    end

    def qa_skip?
      title.downcase.include?('[qa skip]')
    end

    def story_id
      @_match ||= branch_name.match(STORY_ID_RE)
      @_match ? @_match[1] : @_match
    end

    private

    def pr
      @data['pull_request']
    end

  end
end
