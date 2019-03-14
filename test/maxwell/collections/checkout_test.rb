require 'test_helper'

describe Maxwell::Collections::Checkout do
  subject { Maxwell::Collections::Checkout }
  let(:cart_item) { Maxwell::Items::Cart }
  let(:inventory_item) { Maxwell::Items::Inventory }
  let(:purchase_item) { Maxwell::Items::Purchase }

  let(:milk) {
    inventory_item.new(
      'milk',
      price: 397,
      sale: { quantity: 2, price: 500 })}
  let (:milk_item) { cart_item.new('milk') }
  let (:milk_cart) { [milk_item, milk_item, milk_item] }
  let (:milk_purchases) { purchase_item.new(milk_item, milk_cart)}

  let(:bread) {
    inventory_item.new(
      'bread',
      price: 217,
      sale: { quantity: 3, price: 600 })}
  let (:bread_item) { cart_item.new('bread') }
  let (:bread_cart) { [bread_item, bread_item, bread_item] }
  let (:bread_purchases) { purchase_item.new(bread_item, bread_cart)}

 let(:banana) { inventory_item.new('banana',  price: 99) }
 let (:banana_item) { cart_item.new('banana') }
 let (:banana_cart) { [banana_item, banana_item, banana_item] }
 let (:banana_purchases) { purchase_item.new(banana_item, banana_cart) }

 let (:shopping_cart) { [milk_purchases, bread_purchases, banana_purchases]}

 let (:inventory) { [milk, bread, banana] }
 let (:cart) { Maxwell::Collections::Cart.new([milk, bread, banana]) }

  it 'has purchase item' do
    cart.add('milk')
    cart.add('bread')
    checkout = subject.new(cart)
    assert_instance_of Maxwell::Items::Purchase, checkout.items[0]
  end

  it 'cart total' do
    cart.add('milk')
    cart.add('milk')
    cart.add('bread')
    checkout = subject.new(cart)
    assert_equal 717, checkout.total
  end

  it 'cart savings' do
    cart.add('milk')
    cart.add('milk')
    checkout = subject.new(cart)
    assert_equal 294, checkout.savings
  end

  it 'cart to_s' do
    cart.add('milk')
    cart.add('milk')
    cart.add('bread')
    checkout = subject.new(cart)
    assert_equal [["milk", "2", "500"], ["bread", "1", "217"]], checkout.to_s
  end
end