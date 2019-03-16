# frozen_string_literal: true

class GithubEventScore
  def self.run!(username, point_config)
    new(username, GithubEventConfig.new(point_config)).score
  end

  attr_reader :username, :point_config

  def initialize(username, point_config)
    @username = username
    @point_config = point_config
  end

  def events
    [{'type' => 'IssuesEvent'}, {'type' => 'UnknownEvent'}]
  end

  def score
    events.reduce(0) do |sum, event|
      sum += point_config[event['type']]
    end
  end
end
