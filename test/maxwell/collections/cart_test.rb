require 'test_helper'

describe Maxwell::Collections::Cart do
  let (:item) { Maxwell::Items::Inventory.new('item', price: 100) }
  let (:item2) { Maxwell::Items::Inventory.new('item2', price: 200) }
  let (:store) { Maxwell::Collections::Store.new(items: [item, item2]) }
  subject { Maxwell::Collections::Cart.new([item, item2]) }

  describe 'store context' do
    it 'has access to store inventory' do
      assert_equal store.items, subject.inventory
    end
  end

  it 'add item to cart' do
    subject.add('item')
    assert_instance_of Maxwell::Items::Cart, subject.items[0]
  end
end