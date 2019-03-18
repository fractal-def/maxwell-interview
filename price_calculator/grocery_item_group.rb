class GroceryItemGroup
  attr_accessor :quantity

  def initialize(grocery_item)
    @grocery_item = grocery_item
    @quantity = 0
  end

  def name
    @grocery_item.product
  end

  def price
    sale_items_price + standard_items_price
  end

  def presale_price
    @quantity * @grocery_item.unit_price
  end

  private

  def sale_items_price
    if sale_eligible?
      (@quantity / @grocery_item.sale_quantity) * @grocery_item.sale_price
    else
      0
    end
  end

  def standard_items_price
    standard_items = sale_eligible? ? @quantity % @grocery_item.sale_quantity
                                    : @quantity
    standard_items * @grocery_item.unit_price
  end

  def sale_eligible?
    @grocery_item.sale_price && @grocery_item.sale_quantity
  end
end
