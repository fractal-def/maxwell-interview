class ScoreCalculator
  attr_reader :score
  @@rubric = {
    "IssuesEvent" => 7,
    "IssueCommentEvent" => 6,
    "PushEvent" => 5,
    "PullRequestReviewCommentEvent" => 4,
    "WatchEvent" => 3,
    "CreateEvent" => 2
  }

  def initialize
    @score = 0
  end

  def add(event)
    # ||1 because requirements say 
    # Any other event (than events in @@rubric) = 1 
    @score += @@rubric[event] || 1
  end
end