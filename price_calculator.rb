
class PriceCalculator

  ITEMS = {
    milk:   { unit_price: 3.97, sale_quantity: 2, sale_price: 5.00 },
    bread:  { unit_price: 2.17, sale_quantity: 3, sale_price: 6.00 },
    banana: { unit_price: 0.99 },
    apple:  { unit_price: 0.89 }
  }.freeze

  def initialize
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp
    @items = user_input.split(',').map(&:strip)

  end


end

class Item
  require BigDecimal

  def initalize(name:, unit_price:, quantity:, sale_quantity: nil, sale_price: nil )
    @name = name
    @unit_price = BigDecimal(unit_price) if unit_price.is_a? Numeric
    @quantity = quantity
    @sale_quantity = sale_quantity
    @sale_price = BigDecimal(sale_price) if sale_price.is_a? Numeric
  end

  def total_price
    @quantity * @unit_price
  end

  def total_savings
    total_price - total_sale_price
  end

  def total_sale_price
    return 0 unless @sale_price && @sale_quantity

  end


end

PriceCalculator.new