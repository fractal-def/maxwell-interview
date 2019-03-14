require 'test_helper'

describe Maxwell::Collections::Store do
  let (:item) { Maxwell::Items::Inventory.new('item', price: 100) }
  subject { Maxwell::Collections::Store.new(items: [item]) }

  it 'new checkout' do
    assert_instance_of Maxwell::Collections::Checkout, subject.new_checkout
  end

  it 'new cart' do
    assert_instance_of Maxwell::Collections::Cart, subject.new_cart
  end
end