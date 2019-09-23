require 'pry'

class PriceCalculator
  PRICES = {
    milk: { unit_price: 397, sale_price: 500, sale_from: 2 },
    bread: { unit_price: 217, sale_price: 600, sale_from: 3 },
    banana: { unit_price: 99, sale_price: 000, sale_from: 0 },
    apple: { unit_price: 89, sale_price: 000, sale_from: 0 }
  }.freeze

  def initialize(items)
    @items = Hash.new(0)

    items.split(',').each do |item|
      @items[item.to_sym] += 1
    end
  end

  def calculate_subtotal
    subtotal = 0

    @items.each do |item, units|
      subtotal += PRICES[item][:unit_price] * units
    end

    subtotal
  end

  def calculate_total
    total = 0

    @items.each do |item, units|
      sale_from = PRICES[item][:sale_from]
      if sale_from > 0 && units >= sale_from
        regular_price_units = units % sale_from
        sale_price_units = units / sale_from
        total += PRICES[item][:unit_price] * regular_price_units
        total += PRICES[item][:sale_price] * sale_price_units
      else
        total += PRICES[item][:unit_price] * units
      end
    end

    total
  end

  def calculate_savings
    (calculate_subtotal - calculate_total)
  end


  def print_total
    puts "Total price: $#{calculate_total}"
    puts "You saved $#{calculate_savings} today."
  end
end