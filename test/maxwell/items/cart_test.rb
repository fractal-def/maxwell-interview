require 'test_helper'

describe Maxwell::Items::Cart do
  subject { Maxwell::Items::Cart }
  let (:milk) { subject.new('milk') }
  it 'Exists' do
    assert_instance_of Maxwell::Items::Cart, milk
  end
end