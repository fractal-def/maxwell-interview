require 'httparty'

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
    @score = 0
  end

  def fetch_commits
    @commits = JSON.parse(HTTParty.get(api_endpoint).body)
  end

  def generate_score(commits = nil)
    @commits ||= commits
    commit_types = @commits.map{|c| snakecase(c['type'])}

    commit_types.each do |type|
      @score += SCORES[type.to_sym] ? SCORES[type.to_sym] : SCORES[:other]
    end
  end

  def print_score
    puts "#{@username}'s github score is #{@score}"
  end

  private

  def api_endpoint
    "https://api.github.com/users/#{@username.downcase}/events/public"
  end

  # From Rails' ActiveSupport file 'lib/core/facets/string/snakecase.rb', line 15
  def snakecase(word)
    word.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr('-', '_').
    gsub(/\s/, '_').
    gsub(/__+/, '_').
    downcase
  end
end