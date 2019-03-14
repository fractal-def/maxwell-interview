module Maxwell
  module Items
    class Purchase < Base
      def initialize(inventory_cart)
        @inventory = inventory_cart[0]
        @cart = inventory_cart[1]
        super(@inventory.name)
      end

      def savings
        if on_sale?
          regular_price - sale_items_price
        else
          0
        end
      end

      def total
        sale_items_price + regular_items_price
      end

      def quantity
        @cart.length
      end

      def to_s
        [
          @inventory.name,
          quantity.to_s,
          total.to_s
        ]
      end

    private

      def on_sale?
        quantity >= sale_items_quantity
      end

      def regular_price
        @inventory.price * sale_items_quantity
      end

      def sale_items_price
        if on_sale?
          @inventory.sale[:price]
        else
          0
        end
      end

      def sale_items_quantity
        @inventory.sale[:quantity]
      end

      def regular_items_price
        non_sale_item_count * @inventory.price
      end

      def non_sale_item_count
        if on_sale?
          quantity - @inventory.sale[:quantity]
        else
          quantity
        end
      end
    end
  end
end