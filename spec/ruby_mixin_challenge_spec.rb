require 'rspec'
require_relative '../ruby_mixin_challenge'

# defining a dummy class to be used
class TestClass
  include DataAttr
  data_attr :my_item
end

# testing the module 'DataAttr'
describe 'DataAttr' do
  let(:my_class){ TestClass.new}

  # checks instance method - data
  describe '#data' do
    it 'returns an empty hash' do
      expect(my_class.data).to eq({})
    end

    it 'returns a populated hash' do
      my_class.my_item = 1
      expect(my_class.data).to eq({my_item:1})
    end
  end

  # should this be outside of the 'DataAttr' block?
  describe 'DataAttrClassMethods' do
    it 'returns my_item value' do
      my_class.my_item = 1
      expect(my_class.my_item).to eq(1)
    end
  end
end
