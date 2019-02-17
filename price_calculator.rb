require 'pp'

class GroceryCalculator
  
  ITEMS = {
    "Milk" => {
      price: 3.97,
      salePrice: 5,
      saleQuantity: 2
    },
    "Bread" => {
      price: 2.17,
      salePrice: 6,
      saleQuantity: 3
    },
    "Banana" => {
      price: 0.99
    },
    "Apple" => {
      price: 0.89
    }
  }
  
  def initialize(list)
    @total = 0
    @saved = 0
    @checkout_list = {}
    count_items(list)
    result
  end
  
  private
  
  def count_items(list)
    list.split(',').map(&:strip).each do |item|
      @checkout_list[item] = {quantity: 0, subtotal: 0} unless @checkout_list[item]
      @checkout_list[item][:quantity] += 1
    end
  end
  
  def result
    puts "Item     Quantity      Price"
    puts "--------------------------------------"
    pp @checkout_list
    puts
    puts "Total price : $#{@total}"
    puts "You saved $#{@saved} today."
  end
  
end

puts "Please enter all the items purchased separated by a comma"
list = gets
GroceryCalculator.new(list)
