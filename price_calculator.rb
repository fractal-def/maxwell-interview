#Pricing tables
unit_prices = {
  "milk" => 3.97,
  "bread" => 2.17,
  "banana" => 0.99,
  "apple" => 0.89
}

sale_prices = {
  "milk" => {2 => 5},
  "bread" => {3 => 6}
} 


#Get items from command line
print "Please enter all the items purchased separated by a comma\n"

items = gets.chomp

#Set up data structures to hold results
items_bought = Hash.new(0)
total_receipt = Hash.new(0)

#Set up price calculators
total_price = 0.0
retail_price = 0.0

#Figure out how many of each item is bought
items.split(",").each {|item|
  item = item.strip
  items_bought[item] = items_bought[item] + 1
  retail_price = retail_price + unit_prices[item]
}

#Go through and apply retail or sale price 
items_bought.keys.each {|item|
  total_items = items_bought[item]
  
  if(sale_prices[item])
    sale_items = sale_prices[item].keys.first
    sale_price = sale_prices[item].values.first

    total_receipt[item] = total_receipt[item] + sale_price*(total_items/sale_items)
    total_receipt[item] = total_receipt[item] + (unit_prices[item]*(total_items % sale_items))
  elsif(unit_prices[item])
    total_receipt[item] = total_receipt[item] + unit_prices[item] * total_items
  else
    puts "Invalid item added:" + item
  end  
}

#Get total price
total_price = total_receipt.values.inject(:+)

#Print results
puts "Item\tQuantity\tPrice"
puts "--------------------------------------"

total_receipt.each { |item, price|
  puts "#{item.capitalize}\t#{items_bought[item].to_s}\t$#{price.to_s}"
}

puts "\n\nTotal price : $" + total_price.to_s
puts "\nYou saved $" + (retail_price-total_price).round(2).to_s


