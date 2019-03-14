require 'test_helper'

describe Maxwell::Items::Inventory do
  subject { Maxwell::Items::Inventory }
  let (:milk) { subject.new('milk', price: 397, sale: sale) }
  let (:sale) {{ quantity: 2, price: 500 }}

  it 'Exists' do
    assert_instance_of Maxwell::Items::Inventory, milk
  end

  describe 'methods' do
    it '#price' do
      assert_equal 397, milk.price
    end

    describe 'sale' do
      it 'with sale' do
        assert_equal 500, milk.sale[:price]
      end

      it 'without sale' do
        milk = subject.new('milk', price: 397)
        assert_equal 0, milk.sale[:price]
      end
    end
  end
end

