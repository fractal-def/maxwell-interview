require_relative 'models/price_calculator'

puts "Please enter all the items purchased separated by a comma:"
items = gets.chomp
price_calculator = PriceCalculator.new(items)
price_calculator.print_total