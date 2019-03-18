# frozen_string_literal: true

class GroceryPrompt
  def initialize(config)
    @config = config
    @valid_inventory = config
                         .inventory
                         .map { |item| item['product'].downcase }
                         .to_set
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
      .select { |i| @valid_inventory.include?(i) }
  end
end
