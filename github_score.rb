# Instructions:
#
# This was developed using ruby version 2.6.2,,,, it will most likely work on lower versions.
#
# run `gem install httparty` from commandline to install dependency
#

require 'httparty'


class GithubScore
  # Any other type of commit gets a score of 1
  COMMIT_SCORES = {
    IssuesEvent: 7,
    IssueCommentEvent: 6,
    PushEvent: 5,
    PullRequestReviewCommentEvent: 4,
    WatchEvent: 3,
    CreateEvent: 2
  }.freeze

  BASE_URL = "https://api.github.com/users/%s/events/public".freeze

  def initialize(username: 'dhh')
    raise ArgumentError.new("username is required") if username.empty?

    @username = username
    @score = 0
    @url = BASE_URL % @username
  end

  def result
    puts "#{@username.upcase}'s github score is #{@score}"
  end

  def get_commits
    response = HTTParty.get(
      @url,
      headers: {
        "User-Agent" => "Httparty"
      }
    )

    return false unless response.code == 200

    return JSON.parse(response.body)
  end

  def score_commits
    commits = get_commits

    return false unless commits

    commits.each do |commit|
      type = commit['type'].to_sym

      next @score += 1 unless COMMIT_SCORES.has_key?(type)

      @score += COMMIT_SCORES[type]
    end
  end
end

gh = GithubScore.new
gh.score_commits
gh.result