class GroceryCalculator
  attr_reader :groceries

  def initialize(groceries, config)
    grouped_groceries = groceries.each_with_object({}) do |name, memo|
      item = config.inventory[name]
      memo[item] ||= GroceryItemGroup.new(item)
      memo[item].quantity += 1
    end

    @groceries = grouped_groceries.values
  end
end
