require 'sucker_punch'

module TrackerPull
  class WebhookHandler
    include SuckerPunch::Job

    def perform(data)
      @pr = TrackerPull::PullRequest.new(data)

      return unless @pr.opened?

      puts "Webhook Received for PR #{@pr.number}"

      if @pr.qa_skip?
        puts 'Skipping due to [qa skip] directive'; return
      end

      if @pr.story_id.nil?
        $stderr.puts "Could not find story id in branch name: #{@pr.branch_name}"; return
      end

      story = tracker.find_story(@pr.story_id)

      if story.nil?
        $stderr.puts "Could not find story in tracker. story id: #{@pr.story_id}"; return
      end

      puts "Found pivotal tracker story: #{story['id']}"

      tracker.comment_on_story(story, "Pull Request: #{@pr.url}")

      puts "Added comment to pivotal tracker story: #{story['id']}"

      github.comment_on_pr(@pr.repo_name, @pr.number, "Tracker Story: #{story['url']}")

      puts "Added comment to pull request #{@pr.number}"

    end

    private

    def github
      @_github ||= TrackerPull::GitHub.new(ENV.fetch('GITHUB_TOKEN'))
    end

    def tracker
      @_tracker ||= TrackerPull::PivotalTracker.new(ENV.fetch('TRACKER_TOKEN'))
    end

  end
end
