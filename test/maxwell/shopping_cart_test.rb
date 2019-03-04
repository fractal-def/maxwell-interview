require "test_helper"

class Maxwell::ShoppingCartTest < Minitest::Test
  describe 'ShoppingCart' do
    let (:cart) { Maxwell::ShoppingCart.new }
    let (:item) { Struct.new(:name) }
    let (:milk) { item.new('milk') }
    let (:bread) { item.new('bread') }

    before do
      3.times { cart.add(milk) }
      2.times { cart.add(bread) }
    end

    describe 'attributes' do
      it 'items' do assert cart.items end
    end

    describe 'Public methods' do
      it '#total' do
        expect = 14.50
        assert_equal expect, cart.total
      end

      it '#add' do
        assert_equal bread, cart.add(bread)
      end
    end

    describe 'Private methods. OKAY to delete if they break' do
      it '#sub_total_cart' do
        expect = [['milk', 3, 10.50], ['bread', 2, 4.00]]
        assert_equal expect, cart.send(:sub_total_cart)
      end

      it '#group_items' do
        expect = {
          "milk" => ["milk", "milk", "milk"],
          "bread" => ["bread", "bread"]
        }
        assert_equal expect, cart.send(:group_items)
      end

      it '#group_items' do
        expect = [
          ['milk', 3],
          ['bread', 2]
        ]
        assert_equal expect, cart.send(:count_items)
      end

      it '#get price' do
        expect = 3.50
        assert_equal expect, cart.send(:get_price, milk.name)
      end
    end
  end
end