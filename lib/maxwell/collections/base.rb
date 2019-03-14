module Maxwell
  module Collections
    class Base
      include Enumerable
      attr_reader :items, :collection

      def initialize(items:[])
        @items = items
        create_collection
      end

      def add(item)
          items.push(item)
      end

      def each(&block)
        items.each(&block)
      end

      def remove(item)
        _item = collection.delete(item.name)
        @items = items.reject { |i| i.name == _item.name }
      end

      def find(item_name)
        collection[item_name]
      end

      def create_collection
        @collection = items.inject({}) do |collection, item|
          name = item.name
          collection[name] = item
          collection
        end
      end
    end
  end
end