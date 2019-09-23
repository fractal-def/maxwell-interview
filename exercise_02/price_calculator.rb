require_relative 'models/price_calculator'

# puts "Please enter all the items purchased separated by a comma:"
# items = gets.chomp
items = 'milk,milk,bread,banana,bread,bread,bread,milk,apple'
price_calculator = PriceCalculator.new(items)
price_calculator.print_total