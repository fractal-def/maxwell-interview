# frozen_string_literal: true

class GroceryPrompt
  def initialize(config)
    @config = config
  end

  def input
    loop do
      puts @config.prompt
      user_input = sanitize_input(STDIN.gets)

      break user_input if user_input.length > 0
    end
  end

  private def sanitize_input(user_input)
    user_input
      .downcase
      .split(',')
      .map(&:strip)
      .select { |i| @config.inventory.include?(i) }
  end
end
