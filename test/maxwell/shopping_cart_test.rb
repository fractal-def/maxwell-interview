require "test_helper"

class Maxwell::ShoppingCartTest < Minitest::Test
  describe 'ShoppingCart' do
    let (:cart) { Maxwell::ShoppingCart.new }
    let (:item) { Maxwell::Item }
    let (:milk) { item.new(name: 'milk', price: 397) }
    let (:bread) { item.new(name: 'bread', price: 217) }
    let (:banana) { item.new(name: 'banana', price: 99) }
    let (:apple) { item.new(name: 'apple', price: 89) }

    before do
      3.times { cart.add(milk) }
      4.times { cart.add(bread) }
      1.times { cart.add(apple) }
      1.times { cart.add(banana) }
    end

    describe 'attributes' do
      it 'items' do assert cart.items end
      it 'savings' do assert cart.savings end
    end

    describe 'Public methods' do
      it '#total' do
        expect = 19.02
        assert_equal expect, cart.total
      end

      it '#add' do
        assert_equal bread, cart.add(bread)
      end

      it '#add does not blow up' do
        cart.empty_cart
        cheese = item.new(name: 'cheese', price: 0)
        assert_equal 'Sorry not here', cart.add(cheese)
      end

      it '#sub_total_cart' do
        expect = [["milk", 3, 8.97], ["bread", 4, 8.17], ["apple", 1, 0.89], ["banana", 1, 0.99]]
        assert_equal expect, cart.sub_total_cart
      end

      it 'the savings' do
        expect = 3.45
        assert_equal expect, cart.savings
      end

      it 'remove all items' do
        assert_equal [], cart.empty_cart
      end

      it 'savings is only when items quality' do
        cart.empty_cart
        cart.add(milk)
        assert_equal 0, cart.savings
      end
    end

    describe 'Private methods. OKAY to delete if they break' do

      it '#group_items' do
        expect = {
          "milk"   => ["milk", "milk", "milk"],
          "bread"  => ["bread", "bread", "bread", "bread"],
          "apple"  => ["apple"],
          "banana" => ["banana"]
        }

        assert_equal expect, cart.send(:group_items)
      end

      it '#group_items' do
        expect = [["milk", 3], ["bread", 4], ["apple", 1], ["banana", 1]]
        assert_equal expect, cart.send(:count_items)
      end

      it '#get price' do
        expect = 3.97
        assert_equal expect, cart.send(:get_price, milk.name)
      end

      it 'price' do
        expect = 8.97
        assert_equal expect, cart.send(:price, ['milk', 3])
      end

      it 'get_sale' do
        expect =  { quantity: 2, price: 500 }
        assert_equal expect, cart.send(:get_sale,milk.name)
      end
    end
  end
end