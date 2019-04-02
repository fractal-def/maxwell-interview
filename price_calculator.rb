
class PriceCalculator

  def initialize
    puts "Please enter all the items purchased separated by a comma"
    user_input = gets.chomp
    @items = user_input.split(',').map(&:strip)

  end


end

PriceCalculator.new