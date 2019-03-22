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
    response = self.class.get("/users/#{@username}/events/public")
    raise "Too many requests" if response.code == 403
  rescue HTTParty::Error
    raise "Unable to connect"
  end

  def total
    events.each do |event|
      @calculator.add(event["type"])
    end
    @calculator.score
  end
end