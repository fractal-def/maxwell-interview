require "httparty"

class Score
  
  TYPE_VALUES = {
    'IssuesEvent' => 7,
    'IssueCommentEvent' => 6,
    'PushEvent' => 5,
    'PullRequestReviewCommentEvent' => 4,
    'WatchEvent' => 3,
    'CreateEvent' => 2
  }
  
  
  def initialize(username)
    @username = username
    @score = 0
    get_events
    calculate_score
    result
  end
  
  private
  
  def get_events
    @events = HTTParty.get("https://api.github.com/users/#{@username}/events/public", {format: :json}).parsed_response
  end
  
  def calculate_score
    event_types = @events.collect {|event| event['type']}
    scores = event_types.map { |type| TYPE_VALUES[type] || 1 }
    @score = scores.reduce(0, :+)
  end
  
  def result
    puts "#{@username}'s github score is #{@score}"
  end
  
end

Score.new('DHH')
