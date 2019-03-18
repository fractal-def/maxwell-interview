class ReceiptPrinter
  def initialize(calculator)
    @calculator = calculator
  end

  def print
    table_header
    table_rows
    price_totals
  end

  private

  def table_header
    printf "\n%-15s %-15s %-15s\n%s\n", 'Item', 'Quantity', 'Price', '-' * 45
  end

  def table_rows
    @calculator.groceries.each do |item|
      printf "%-15s %-15d $%-15.2f\n", item.name, item.quantity, item.price
    end
  end

  def price_totals
    printf "\nTotal price: $%.2f\n", @calculator.total_price
    printf "You saved $%.2f today.\n", @calculator.total_saved
  end
end
