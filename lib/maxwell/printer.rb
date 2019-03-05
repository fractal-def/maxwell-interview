require_relative './shopping_cart'

Item = Struct.new(:name)

MESSAGES = {
  start: 'Please enter all the items purchased separated by a comma',
  total: 'Total price : $',
  savings: { start: 'You saved $',
            end: ' today' }
}

module Maxwell
  class Printer
    attr_reader :items, :cart

    def initialize(cart: Maxwell::ShoppingCart)
      @cart = cart.new
    end

    def print_order
      if cart.total > 0
        header
        puts
        print_cart
        puts
        footer
      else
        puts 'Add Items In order to checkout'
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

    def get_input
      print "> "
      @items = gets
      parse_items
      add_items_to_cart
    end

    def parse_items
      @items.split(',').map { |i| i.strip }
    end

    def print_cart
      cart.sub_total_cart.each do |item|
        printf("%-19s %-8s $%s\n", item[0], item[1], item[2])
      end
    end

    def add_items_to_cart
      parse_items.map do |i|
        item = Item.new(i)
        cart.add(item)
      end
    end

    def header
      printf("%-12s %-15s %1s\n", "Item", "Quantity", "Price")
      print "-" * 36
      puts
    end

    def footer
      puts MESSAGES[:total] + cart.total.to_s
      if cart.savings > 0
        puts MESSAGES[:savings][:start] +
             cart.savings.to_s +
             MESSAGES[:savings][:end]
      end
    end
  end
end