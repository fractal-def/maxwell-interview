require 'pry'

class PriceCalculator
  PRICES = {
    milk: { unit_price: 3.97, sale_price: 5.00, sale_from: 2 },
    bread: { unit_price: 2.17, sale_price: 6.00, sale_from: 3 },
    banana: { unit_price: 0.99, sale_price: 0.00, sale_from: 0 },
    apple: { unit_price: 0.89, sale_price: 0.00, sale_from: 0 }
  }.freeze

  def initialize(items)
    @items = Hash.new(0)

    items.split(',').each do |item|
      @items[item.to_sym] += 1
    end
  end

  def calculate_subtotal
    subtotal = 0.0

    @items.each do |item, units|
      subtotal += PRICES[item][:unit_price] * units
    end

    subtotal.round(2)
  end

  def calculate_total
    total = 0.0

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

    total.round(2)
  end

  def calculate_savings
    (calculate_subtotal - calculate_total).round(2)
  end


  def print_total
    puts "Total price: $#{calculate_total}"
    puts "You saved $#{calculate_savings} today."
  end
end