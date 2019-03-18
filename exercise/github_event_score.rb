# frozen_string_literal: true

class GithubEventScore
  attr_reader :username, :point_config

  def initialize(username, point_config)
    @username = username
    @point_config = point_config
  end

  def events
    @events ||= GithubEventFeed.get(username)
  end

  def score
    events.reduce(0) { |sum, event| sum + point_config[event['type']] }
  end
end
