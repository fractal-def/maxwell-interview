
class PriceCalculator

  INPUT_PATTERN = /\w+/

  def initialize
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp
    @items = user_input.scan(INPUT_PATTERN)

  end


end

PriceCalculator.new