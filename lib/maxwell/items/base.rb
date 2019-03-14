module Maxwell
  module Items
    class Base
      attr_reader :name
      def initialize(name)
        @name = name
      end

      def sale
        { quantity: 0, price: 0 }
      end
    end
  end
end