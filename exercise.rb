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
  
  def initialize
    @score = 0
    result
  end
  
  private
  
  def result
    puts "DHH's github score is #{@score}"
  end
  
end

Score.new
