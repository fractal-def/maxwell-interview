require "test_helper"

class Maxwell::ItemTest < Minitest::Test
  describe 'Item' do
    let (:sale) {{ quantity: 2, price: 500 }}
    subject { Maxwell::Item.new(name: 'milk', sale: sale, price: 397) }

    it '#name' do
      assert_equal 'milk', subject.name
    end

    it '#has_sale?' do
      no_sale = Maxwell::Item.new(name: 'milk', price: 0)
      assert_equal false, no_sale.has_sale?
    end

    it '#price' do
      assert_equal 397, subject.price
    end

    it '#sale' do
      assert_equal sale, subject.sale
    end
  end
end