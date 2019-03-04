CATALOG = {
  'milk' => { price: 397, has_sale: true, sale: { quantity: 2, price: 500 } },
  'bread' => { price: 217, has_sale: true, sale: { quantity: 3, price: 600 } },
  'banana' => { price: 99, has_sale: false, sale: {} },
  'apple' => { price: 89, has_sale: false, sale: {} }
}

module Maxwell
  class ShoppingCart

    attr_reader :items, :catalog

    def initialize(catalog: CATALOG)
      @items = []
      @catalog = catalog
    end

    def add(item)
      if catalog[item.name].nil?
        'Sorry not here'
      else
        @items.push(item.name)
        item
      end
    end

    def total
      sub_total_cart.reduce(0) { |sum, item| sum += item[2] }.round(2)
    end

    def sub_total_cart
      count_items.map do |item|
        [ item[0], item[1], price(item) ]
      end
    end

    def savings
      original = original_prices.reduce(0) do |sum, item|
        sum += item[0] * item[1]
      end
      (original - total).round(2)
    end

    def empty_cart
      @items = []
    end

  private

    def original_prices
      count_items.map do |item|
        [ item[1], get_price(item[0]) ]
      end
    end

    def group_items
      @items.group_by { |item| item }
    end

    def get_price(item)
      price = catalog[item][:price]
      to_money(price)
    end

    def to_money(price)
      price.to_f / 100
    end

    def count_items
      group_items.map do |item, quantity|
        [ item, quantity.length ]
      end
    end

    def price(item)
      total_items = item[1]
      sale = get_sale(item[0])
      sale_item_count = sale[:quantity]
      total = if item[1] >= sale_item_count
        sale_price = to_money(sale[:price])
        regular_items = total_items - sale_item_count
        regular_price = regular_items * get_price(item[0])
        sale_price + regular_price
      else
        get_price(item[0]) * total_items
      end
      total.round(2)
    end

    def get_sale(item)
      if catalog[item][:has_sale]
        catalog[item][:sale]
      else
        { quantity: 1, price: catalog[item][:price] }
      end
    end
  end
end