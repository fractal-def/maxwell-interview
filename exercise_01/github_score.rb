require 'httparty'
require_relative './score_calculator'

class GitHubScore
  include HTTParty
  base_uri 'api.github.com'

  def initialize(username)
    @username = username 
    @calculator = ScoreCalculator.new
  end

  def events
    self.class.get("/users/#{@username}/events/public")
  rescue #Rate Limit Error?
    # do something?
  end

  def total
    events.each do |event|
      @calculator.add(event["type"])
    end
    @calculator.score
  end
end