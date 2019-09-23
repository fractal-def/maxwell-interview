class PriceCalculator
  PRICES = {
    milk: { unit_price: 397, sale_price: 500, sale_from: 2 },
    bread: { unit_price: 217, sale_price: 600, sale_from: 3 },
    banana: { unit_price: 99, sale_price: 000, sale_from: 0 },
    apple: { unit_price: 89, sale_price: 000, sale_from: 0 }
  }.freeze

  def initialize(items)
    @items = Hash.new(0)

    items.gsub(/\s+/, '').split(',').map(&:downcase).each do |item|
      @items[item.to_sym] += 1
    end
  end

  # calculate total for entire bill
  def calculate_all_total
    @items.map{ |item, units| calculate_total(item, units) }.reduce(:+)
  end

  # calculate savings for entire bill
  def calculate_all_savings
    calculate_all_subtotal - calculate_all_total
  end

  def print_total
    print_total_table
    puts "\n"
    puts "Total price: $#{human_friendly_price(calculate_all_total)}."
    puts "You saved $#{human_friendly_price(calculate_all_savings)} today."
  end

  private

   # calculate subtotal for individual item (without sale)
  def calculate_subtotal(item, units)
    PRICES[item][:unit_price] * units
  end

  # calculate total for individual item
  def calculate_total(item, units)
    total = 0
    unit_price = PRICES[item][:unit_price]
    sale_price = PRICES[item][:sale_price]
    sale_from = PRICES[item][:sale_from]

    if sale_price > 0 && sale_from > 0 && units >= sale_from
      regular_price_units = units % sale_from
      sale_price_units = units / sale_from
      total += unit_price * regular_price_units
      total += sale_price * sale_price_units
    else
      total += unit_price * units
    end

    total
  end

    # calculate subtotal for entire bill
  def calculate_all_subtotal
    @items.map{ |item, units| calculate_subtotal(item, units) }.reduce(:+)
  end

  def human_friendly_price(int)
    int.to_s.length > 2 ? int.to_s.reverse.gsub(/(\d{2})(?=\d)/, '\1.').reverse : int.to_s.reverse.gsub(/(\d{2})/, '\1.0').reverse
  end

  def print_total_table
    print_total_table_header
    print_total_table_body
  end

  def print_total_table_header
    puts "Item     Quantity     Price"
    puts "--------------------------------"
  end

  def print_total_table_body
    @items.each do |item, units|
      print_total_table_row(item,units)
    end
  end

  def print_total_table_row(item, units)
    formatted_item = item.to_s.capitalize
    formatted_units = units.to_s
    item_space = ' ' * (9 - formatted_item.length)
    units_space = ' '* (13 - formatted_units.length)

    puts "#{formatted_item}#{item_space}#{formatted_units}#{units_space}$#{human_friendly_price(calculate_total(item, units))}     "
  end
end