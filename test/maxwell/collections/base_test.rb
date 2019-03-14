require 'test_helper'

describe Maxwell::Collections::Base do
  let (:item) { Maxwell::Items::Base.new('item') }
  let (:item2) { Maxwell::Items::Base.new('item2') }
  subject { Maxwell::Collections::Base.new(items: [item, item2]) }

  describe 'methods' do
    it 'add' do
      original_count = subject.items.count
      subject.add(item)
      refute_equal original_count, subject.items.count
    end

    it 'find' do
      assert_equal item, subject.find(item.name)
    end

    it 'remove' do
      original_count = subject.items.count
      subject.remove(item)
      refute_equal original_count, subject.items.count
    end

    it 'each' do
      names = subject.map { |item| item.name }
      assert_equal [item.name, item2.name], names
    end
  end
end

