# frozen_string_literal: true

class GroceryConfig
  def initialize(config_path)
    @config_data = Psych.load(File.read(config_path))
  end

  def inventory
    @config_data['inventory']
  end

  def prompt
    @config_data['prompt']
  end
end
