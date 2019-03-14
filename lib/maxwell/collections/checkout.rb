require_relative '../items/purchase'
require_relative './store'
require_relative './base'

module Maxwell
  module Collections
    class Checkout < Base

      def initialize(cart, purchase_item: Maxwell::Items::Purchase)
        @purchase_item = purchase_item
        @cart = cart
        super(items: purchase_items)
      end

      def total
        pluck('total').reduce(:+) || 0
      end

      def savings
        pluck('savings').reduce(:+) || 0
      end

      def to_s
        pluck('to_s')
      end

    private

      def pluck(attr)
        items.map { |item| item.send(attr) }
      end

      def purchase_items
        cart_inventory.map { |inventory_cart| @purchase_item.new(inventory_cart) }
      end

      def cart_inventory
        group_items.map do |inventory_item, cart_items|
          [ @cart.find(inventory_item), cart_items ]
        end
      end

      def group_items
        @cart.items.group_by { |item| item.name }
      end
    end
  end
end