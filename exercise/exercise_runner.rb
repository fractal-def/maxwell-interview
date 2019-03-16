class ExerciseRunner
  def self.run!(username:, config_path: nil)
    point_config = GithubEventConfig.new(config_path)
    GithubEventScore.new(username, point_config).score
  end
end
