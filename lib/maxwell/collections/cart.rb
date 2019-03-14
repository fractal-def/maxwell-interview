require_relative './base'
require_relative '../items/cart'

module Maxwell
  module Collections
    class Cart < Base
      attr_reader :inventory

      def self.items
        new(@items)
      end

      def initialize(items, item: Maxwell::Items::Cart)
        @inventory = items
        @item = item
        @items = []
      end

      def add(item)
        # TODO Item Factory
        if find(item)
          i = @item.new(item)
          super(i)
        end
      end

      def find(item_name)
        @inventory.find { |item| item.name == item_name}
      end
    end
  end
end