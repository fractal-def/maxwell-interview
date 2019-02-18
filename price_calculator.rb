class GroceryCalculator
  
  ITEMS = {
    "Milk" => {
      price: 3.97,
      sale_price: 5,
      sale_quantity: 2
    },
    "Bread" => {
      price: 2.17,
      sale_price: 6,
      sale_quantity: 3
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
    subtotal_items
    print_receipt
  end
  
  private
  
  def count_items(list)
    list.split(',').map(&:strip).map(&:capitalize).each do |item|
      @checkout_list[item] = {quantity: 0, subtotal: 0} unless @checkout_list[item]
      @checkout_list[item][:quantity] += 1
    end
  end
  
  def subtotal_items
    @checkout_list.keys.each do |item| 
      @checkout_list[item][:saved] = 0
      full_price = @checkout_list[item][:quantity] * ITEMS[item][:price]
      if ITEMS[item][:sale_quantity] && @checkout_list[item][:quantity] >= ITEMS[item][:sale_quantity] # if there is a sale and qty is sufficient
          @checkout_list[item][:saved] = full_price - (ITEMS[item][:sale_price] + (@checkout_list[item][:quantity] % ITEMS[item][:sale_quantity] * ITEMS[item][:price])).round(2)
      end
      @checkout_list[item][:subtotal] = full_price - @checkout_list[item][:saved]
      @total += @checkout_list[item][:subtotal]
      @saved += @checkout_list[item][:saved]
    end
  end
  
  def print_receipt
    puts
    puts "Item     Quantity      Price"
    puts "--------------------------------------"
    @checkout_list.each do |item,values|
      puts "#{item}#{" "*(10-item.length)}#{values[:quantity]}#{" "*(13-values[:quantity].to_s.length)}$#{values[:subtotal]}"
    end
    puts
    puts "Total price : $#{@total}"
    puts "You saved $#{'%.2f' % @saved} today."
  end
  
end

puts "Please enter all the items purchased separated by a comma"
list = gets
GroceryCalculator.new(list)
