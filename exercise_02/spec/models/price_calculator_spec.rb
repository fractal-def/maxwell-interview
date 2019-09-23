require_relative '../../models/price_calculator'

RSpec.describe PriceCalculator do
  it 'correctly calculates the total and savings with items on sale' do
    items='milk,milk,bread,banana,bread,bread,bread,milk,apple'
    price_calculator = PriceCalculator.new(items)
    expect(price_calculator.calculate_all_total).to eq(1902)
    expect(price_calculator.calculate_all_savings).to eq(345)
  end

  it 'correctly calculates the total and savings without items on sale' do
    items='banana,banana,banana,apple,apple,apple, apple'
    price_calculator = PriceCalculator.new(items)
    expect(price_calculator.calculate_all_total).to eq(653)
    expect(price_calculator.calculate_all_savings).to eq(0)
  end

  it 'correctly calculates the total and savings with items on sale but not meeting the minimum number of units' do
    items='milk,bread,bread,apple,apple,banana,banana'
    price_calculator = PriceCalculator.new(items)
    expect(price_calculator.calculate_all_total).to eq(1207)
    expect(price_calculator.calculate_all_savings).to eq(0)
  end
end