require 'httparty'
require 'pry'

class GitHubUser
  SCORES = {
    issues_event: 7,
    issue_comment_event: 6,
    push_event: 5,
    pull_request_review_comment_event: 4,
    watch_event: 3,
    create_event: 2,
    other: 1
  }.freeze

  def initialize(username)
    @username = username
  end

  private

  def api_endpoint
    "https://api.github.com/users/#{@username}/events/public"
  end

  def fetch_commits
    @commits = HTTParty.get(api_endpoint)
  end
end

dhh = GitHubUser.new('dhh')
