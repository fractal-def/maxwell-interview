# frozen_string_literal: true

class GroceryConfig
  GroceryItem = Struct.new(:product, :unit_price, :sale_price, :sale_quantity)

  def initialize(config_path)
    @config_data = Psych.load(File.read(config_path))
  end

  def inventory
    @inventory ||= @config_data['inventory'].each_with_object({}) do |yml, memo|
      memo[yml['product'].downcase] = GroceryItem.new.tap do |item|
        item.product       = yml['product']
        item.unit_price    = yml['unit_price']
        item.sale_price    = yml['sale_price']
        item.sale_quantity = yml['sale_quantity']
      end
    end
  end

  def prompt
    @config_data['prompt']
  end
end
