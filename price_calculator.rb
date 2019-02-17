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
  
  def initialize(grocery_list)
    
  end
  
  private
  
end

puts "Please enter all the items purchased separated by a comma"
list = gets
GroceryCalculator.new(list)
