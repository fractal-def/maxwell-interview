require "httparty"

class Score
  
  TYPES = {
    'IssuesEvent' => 7,
    'IssueCommentEvent' => 6,
    'PushEvent' => 5,
    'PullRequestReviewCommentEvent' => 4,
    'WatchEvent' => 3,
    'CreateEvent' => 2,
    'OtherEvent' => 1
  }
  
  def initialize(username)
    @username = username
    @score = 0
    get_events
    result
  end
  
  private
  
  def get_events
    events = HTTParty.get("https://api.github.com/users/#{@username}/events/public")
  end
  
  def result
    puts "#{@username}'s github score is #{@score}"
  end
  
end

Score.new('DHH')
