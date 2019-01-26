PRICE_TABLE = {
    "milk" => {
        "base_price" => 397,
        "promotion_price" => 250,
        "promotion_quantity" => 2,
    },

    "bread" => {
        "base_price" => 217,
        "promotion_price" => 200,
        "promotion_quantity" => 3,
    },

    "banana" => {
        "base_price" => 99,
    },

    "apple" => {
        "base_price" => 89,
    },
}

def validate_items(basket)
  items = basket.split(',').map {|item| item.strip}.reject(&:empty?).reject do |item|
    !PRICE_TABLE.map {|price_table_item| price_table_item.first}.include?(item)
  end

  if items.length > 0
    items
  else
    abort "Your basket is empty!"
  end
end

def scan_items(items)
  purchased_items = {}

  items.each do |item|
    if purchased_items[item]
      if purchased_items[item]['quantity']
        purchased_items[item]['quantity'] = purchased_items[item]['quantity'] + 1
      else
        purchased_items[item]['quantity'] = 1
      end
    else
      purchased_items[item] = {}
      purchased_items[item]['quantity'] = 1
    end
  end

  purchased_items
end

def calculate_price_of_items(item, quantity)
  promotion_price = PRICE_TABLE[item]['promotion_price']
  promotion_quantity = PRICE_TABLE[item]['promotion_quantity']
  item_base_price = PRICE_TABLE[item]['base_price']
  promotion_exists = promotion_price && promotion_quantity

  if promotion_exists
    num_items_at_full_price = quantity % promotion_quantity
    num_items_at_promotion_price = quantity - num_items_at_full_price

    (num_items_at_full_price * item_base_price) + (num_items_at_promotion_price * promotion_price)
  else
    quantity * item_base_price
  end
end

def calculate_full_price_of_items(item_name, item_values)
  item_values['quantity'] * PRICE_TABLE[item_name]['base_price']
end

def purchase_items(validated_items)
  scan_items(validated_items).map do |item_name, item_values|
    {
        item_name => {
            quantity: item_values['quantity'],
            item_total: calculate_price_of_items(item_name, item_values['quantity']),
            full_price_item_total: calculate_full_price_of_items(item_name, item_values),
        }
    }
  end
end

def format_currency(value)
  '%.2f' % (value / 100.0)
end

def receipt(items_purchased)
  total_price = items_purchased.reduce(0) {|sum, item| sum + item.first[1][:item_total]}
  savings = items_purchased.reduce(0) {|sum, item| sum + item.first[1][:full_price_item_total]} - total_price

  puts "\n"
  puts "Item     Quantity      Price"
  puts "--------------------------------------"

  items_purchased.each do |item|
    puts "#{item.first[0]}\t\s\s#{item.first[1][:quantity]}\t\t $#{format_currency(item.first[1][:item_total])}"
  end

  puts "\n"
  puts "Total price : $#{format_currency(total_price)}"
  puts "You saved $#{format_currency(savings)} today."

end

def calculate_groceries(basket = [])
  validated_items = validate_items(basket)
  purchased_items = purchase_items(validated_items)

  puts receipt(purchased_items)
end

puts 'Please enter all the items purchased separated by a comma:'
calculate_groceries(gets)