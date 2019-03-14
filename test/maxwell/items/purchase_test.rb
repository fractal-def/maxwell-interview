require 'test_helper'

describe Maxwell::Items::Purchase do
  subject { Maxwell::Items::Purchase }
  let (:cart_item) { Maxwell::Items::Cart.new('milk') }
  let(:inventory_item) {
  Maxwell::Items::Inventory.new('milk',  price: 397, sale: { quantity: 2, price: 500 })
}
 let(:inventory) { inventory_item }
 let(:cart) { [cart_item, cart_item, cart_item] }
 let(:cart2) { [cart_item] }

 describe 'attributes' do

  before do
    @subject = subject.new([inventory, cart])
  end

  it 'name' do
    assert @subject.name
  end

  it 'quantity' do
    assert_equal 3, @subject.quantity
  end

  it 'price total' do
    assert_equal 897, @subject.total
  end

  it 'price savings' do
    @subject = subject.new([inventory, cart2])
    assert_equal 0, @subject.savings
  end

  it 'price savings' do
    @subject = subject.new([inventory, cart2])
    assert_equal 397, @subject.total
  end

  it 'to_s' do
    @subject = subject.new([inventory, cart2])
    assert_equal ['milk', '1', '397'], @subject.to_s
  end
 end
end

