require_relative './shopping_cart'

Item = Struct.new(:name)
cart = Maxwell::ShoppingCart.new

puts 'Please enter all the items purchased separated by a comma'

items = gets.chomp
# puts "milk,milk, bread,banana,bread,bread,bread,milk,apple"
# items = "milk,milk, bread,banana,bread,bread,bread,milk,apple"

items.split(',').map { |i| i.strip}.map do |i|
  item = Item.new(i)
  cart.add(item)
end

def header
  printf("%-12s %-15s %1s\n", "Item", "Quantity", "Price")
  print "-" * 36
  puts
end

def print_cart(cart)
  cart.sub_total_cart.each do |item|
    printf("%-19s %-8s $%s\n", item[0], item[1], item[2])
  end
  puts
end

if cart.total > 0
  header
  print_cart(cart)
  puts "Your total is $#{cart.total}"
  if cart.savings > 0
    puts "You saved $#{cart.savings}"
  end
else
  puts 'Sorry, we do not have anything of those things.'
end
