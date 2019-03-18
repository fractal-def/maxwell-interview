class GroceryCalculator
  def initialize(groceries, config)
    grouped_groceries = groceries.each_with_object({}) do |name, memo|
      item = config.inventory[name]
      memo[item] ||= GroceryItemGroup.new(item)
      memo[item].quantity += 1
    end

    @groceries = grouped_groceries.values
  end

  def total_price
    @groceries.reduce(0.0) { |sum, group| sum + group.price }
  end

  def total_saved
    presale_price = @groceries.reduce(0.0) { |sum, group| sum + group.presale_price }
    presale_price - total_price
  end
end
