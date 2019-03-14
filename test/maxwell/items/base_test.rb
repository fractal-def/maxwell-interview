require 'test_helper'

describe Maxwell::Items::Base do
  subject { Maxwell::Items::Base }
  let (:milk) { subject.new('milk') }
  describe 'methods' do
    it '#name' do
      assert_equal 'milk', milk.name
    end

    it '#sale' do
      assert_equal 0, milk.sale[:price]
    end
  end
end

