class GithubEventScore
  def self.run!(username, point_config)
    new(username, point_config).score
  end

  attr_reader :username, :point_config

  def initialize(username, point_config)
    @username = username
    @point_config = point_config
  end

  def score
  end
end
