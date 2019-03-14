require 'test_helper'

describe Maxwell::Items::Null do
  subject { Maxwell::Items::Null }
  let (:milk) { subject.new('milk') }

  it 'Exists' do
    assert_instance_of Maxwell::Items::Null, milk
  end

  describe 'name' do
    it '#name' do
      assert_equal 'milk', milk.name
    end
  end
end

