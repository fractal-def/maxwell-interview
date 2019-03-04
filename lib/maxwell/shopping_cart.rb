module Maxwell
  class ShoppingCart

    attr_reader :items

    def initialize
      @items = []
    end

    def add(item)
      @items.push(item.name)
      item
    end

    def total
      sub_total_cart.reduce(0) { |sum, item| sum += item[2] }
    end

  private

    def sub_total_cart
      count_items.map do |item|
        [ item[0], item[1], sub_total_item(item) ]
      end
    end

    def group_items
      @items.group_by { |i| i }
    end

    def get_price(item)
      catalog = {
        'milk' => 350,
        'bread' => 200
      }
      price = catalog[item]
      price.to_f / 100
    end

    def count_items
      group_items.map do |item, quantity|
        [item, quantity.length ]
      end
    end

    def sub_total_item(item)
      get_price(item[0]) * item[1]
    end
  end
end