class ExerciseRunner
  def self.run!(username:, config_path: nil)
    point_config = GithubEventConfig.new(config_path)
    event_score = GithubEventScore.new(username, point_config)

    puts "#{username}'s github score is #{event_score.score}"
  end
end
