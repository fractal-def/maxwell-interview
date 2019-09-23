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
  end

  def generate_score
    fetch_commits
    @score = 0
    commit_types = @commits.map{|c| snakecase(c['type'])}

    commit_types.each do |type|
      @score += SCORES[type.to_sym] ? SCORES[type.to_sym] : SCORES[:other]
    end

    puts "#{@username}'s github score is #{@score}"
  end

  private

  def api_endpoint
    "https://api.github.com/users/#{@username.downcase}/events/public"
  end

  def fetch_commits
    @commits = HTTParty.get(api_endpoint)
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

dhh = GitHubUser.new('DHH')
dhh.generate_score