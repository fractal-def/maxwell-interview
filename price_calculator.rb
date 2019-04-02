
class PriceCalculator

  ITEM_PRICES = {
    milk:   { unit_price: 3.97, sale_quantity: 2, sale_price: 5.00 },
    bread:  { unit_price: 2.17, sale_quantity: 3, sale_price: 6.00 },
    banana: { unit_price: 0.99 },
    apple:  { unit_price: 0.89 }
  }

  def initialize
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp
    items = user_input.split(',').map {|item| item.strip.downcase}

    # Count the quantities of each item
    quantities = Hash.new(0)
    items.each_with_object(quantities) { |item,quantities| quantities[item] += 1 }

    # Add quantity values to list
    quantities.each do |key, val|
      next unless ITEM_PRICES.has_key? key.to_sym
      ITEM_PRICES[key.to_sym] = ITEM_PRICES[key.to_sym].merge({ quantity: val })
    end

    @item_objects = []
    ITEM_PRICES.each do |key, val|
      next unless val.has_key? :quantity
      @item_objects << Item.new(val.merge({name: key.to_s}))
    end

  end

  def print_receipt
    receipt_header
    line_items
    receipt_footer
  end

  def receipt_footer
    total_price
    # total_savings
  end

  def total_price
    puts "\nTotal price : $%s" % @item_objects.inject(0){|sum,item| sum + item.total_due }
  end

  def receipt_header
    puts
    puts "Item     Quantity      Price"
    puts "--------------------------------------"
  end

  def line_items
    @item_objects.each do |item|
      line_item(item: item)
    end
  end

  # In rails I'd use number_to_currency for formatting
  def line_item(item:)
    puts "#{item.name.capitalize.ljust(10, ' ')}#{item.quantity.to_s.ljust(13, ' ')}$#{item.total_due}"
  end

end

class Item
  attr_accessor :name, :quantity

  def initialize(name:, unit_price:, quantity:, sale_quantity: nil, sale_price: nil )
    @name = name
    @unit_price = (unit_price * 100).to_i if unit_price
    @quantity = quantity
    @sale_quantity = sale_quantity
    @sale_price = (sale_price * 100).to_i if sale_price
  end

  def total_due
    total_price_sale_items + total_price_non_sale_items
  end

  def total_due_without_sale
    (@quantity * @unit_price) / 100.0
  end

  def total_savings
    total_due_without_sale - total_due
  end

  def total_price_sale_items
    return 0 unless @sale_price && @sale_quantity

    (quantity_sale_groups * @sale_price) / 100.0
  end

  def total_price_non_sale_items
    (quantity_non_sale_items * @unit_price) / 100.0
  end

  # This is amount of sale groupings,
  # not the quantity of individual sale items
  def quantity_sale_groups
    return 0 unless @sale_quantity
    @quantity / @sale_quantity
  end

  def quantity_non_sale_items
    return @quantity unless @sale_quantity
    @quantity % @sale_quantity
  end

end

pc = PriceCalculator.new
pc.print_receipt
