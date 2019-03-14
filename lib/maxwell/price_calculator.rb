# About:
# Price Calculator was created with 2 sets of Base Classes: Collections & Items

# 4 Collection Classes (found in lib/maxwell/collections/)
  # Collections manage the Store, Cart, and Checkout Processes

# 1. Base Class
  # Manages add, remove, find,
  # Create hash table of items

# 2. Store < Base
  # Set Inventory
  # Create multiple Shopping Carts
  # Create multiple Checkouts

# 3. Cart < Base
  # Adds Items as 'string'
  # Ensure Items are available for purchase

# 4. Checkout < Base
  # Total Cart Price
  # Total Cart savings (if applicable)
  # Printer Friendly (to_s)


# 4 Item Classes (found in lib/maxwell/items/)
  # Items manage the Inventory, Shopping, and Purchase Processes

# 1. Base
  # Manage name

# 2. Inventory < Base
  # Manage sales and price

# 3. Cart < Base
  # Dumb Items which do not have access to price or sale

# 4. Purchase < Base
  # Manage Item totals, quantity, and savings


# The following is a simple terminal script.
# Run it like so:
# $ ruby lib/maxwell/price_calculator.rb
# > (Enter shopping items from command line)

require_relative './collections/store'
require_relative './items/inventory'

Inventory = [
  Maxwell::Items::Inventory.new('milk',  price: 397, sale: { quantity: 2, price: 500 }),
  Maxwell::Items::Inventory.new('bread',  price: 217, sale: { quantity: 3, price: 600 }),
  Maxwell::Items::Inventory.new('banana',  price: 99),
  Maxwell::Items::Inventory.new('apple',  price: 89 )
]

MESSAGES = {
  start: 'Please enter all the items purchased separated by a comma',
  total: 'Total price : ',
  savings: { start: 'You saved ',
            end: ' today' },
  inventory: 'Current Inventory includes: '
}

module Maxwell
  class Printer
    def initialize(inventory, store: Maxwell::Collections::Store)
      @store = store.new(items: inventory)
      @cart = @store.new_cart
    end

    def print_order
      if @cart.items.length > 0
        header
        puts
        print_cart
        puts
        footer
      else
        puts MESSAGES[:inventory]
        puts
        puts current_inventory
        start
        print_order
      end
    end

    def start
      puts MESSAGES[:start]
      puts
      get_input
    end

  private

    def current_inventory
      @store.collection.keys.join(', ')
    end

    def get_input
      print "> "
      @items = gets
      add_items_to_cart
    end

    def add_items_to_cart
      parse_items.map do |i|
        @cart.add(i)
      end
    end

    def parse_items
      @items.chomp.empty? ? [] : @items.split(',').map { |i| i.strip }
    end

    def print_cart
      @checkout = @store.new_checkout(@cart)
      @checkout.items.each do |item|
        item = item.to_s
        printf("%-19s %-8s %s\n", item[0], item[1], usd(item[2].to_i))
      end
    end

    def header
      printf("%-12s %-15s %1s\n", "Item", "Quantity", "Price")
      print "-" * 36
      puts
    end

    def usd(amount)
      sprintf "$%.2f", (amount.to_f / 100)
    end

    def footer
      puts MESSAGES[:total] + usd(@checkout.total)
      if @checkout.savings > 0
        puts MESSAGES[:savings][:start] +
             usd(@checkout.savings) +
             MESSAGES[:savings][:end]
      end
    end
  end
end


printer = Maxwell::Printer.new(Inventory)
printer.start
printer.print_order


