require_relative './base'
require_relative './cart'
require_relative './checkout'

module Maxwell
  module Collections
    class Store < Base

      def initialize(items:, cart: Cart, checkout: Checkout)
        @cart = cart
        @checkout = checkout
        super(items: items)
      end

      def new_cart
        @cart.new(@items)
      end

      def new_checkout(cart=@cart)
        @checkout.new(cart)
      end
    end
  end
end