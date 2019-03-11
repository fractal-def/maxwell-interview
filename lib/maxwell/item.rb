module Maxwell
  class Item
    attr_reader :name, :sale, :price

    def initialize(name:, sale:{}, price:)
      @price = price
      @sale = sale
      @name = name
    end

    def has_sale?
      @sale.empty? ? false : true
    end
  end
end