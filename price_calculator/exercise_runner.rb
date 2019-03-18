class ExerciseRunner
  def self.run!(config_path:)
    config     = GroceryConfig.new(config_path)
    prompt     = GroceryPrompt.new(config)
    prompt.input
  end
end
