require_relative './base'
module Maxwell
  module Items
    class Inventory < Base
      attr_reader :price

      def initialize(name, price:, sale: {})
        @price = price
        @sale = sale
        super(name)
      end

      def sale
        @sale.empty? ? super : @sale
      end
    end
  end
end