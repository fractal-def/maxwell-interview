# frozen_string_literal: true

# Pricing
#
# Item     Unit price        Sale price
# --------------------------------------
# Milk      $3.97            2 for $5.00
# Bread     $2.17            3 for $6.00
# Banana    $0.99
# Apple     $0.89

OUTPUT_FORMAT = '%-9s %-14s %-15s'
PRICING = {
  apple: [0.89],
  banana: [0.99],
  bread: [2.17, 2.17, 6.00],
  milk: [3.97, 5.00]
}

@saved = 0.00
@total = 0.00
@cart = Hash.new { |hash, key| hash[key] = 0 }

puts 'Please enter all the items purchased separated by a comma'
@items = gets.strip

@items.split(',').each do |item|
  @cart[item.strip] += 1
end

puts "\n" + OUTPUT_FORMAT %  ['Item', 'Quantity', 'Price']
puts '--------------------------------------'
@cart.each do |item, quantity|
  next if quantity.zero?

  price_list = PRICING[item.to_sym]
  best_price, remainder = quantity.divmod(price_list.length)

  item_total = (price_list.last * best_price)
  item_total += (price_list[remainder - 1] * remainder)

  @total += item_total
  @saved += (price_list.first * quantity) - item_total

  puts OUTPUT_FORMAT % [item.capitalize, quantity, item_total]
end

puts "\nTotal price : $#{@total}"
puts "You saved $#{@saved.round(2)} today."
