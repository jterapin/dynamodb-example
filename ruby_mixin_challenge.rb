module DataAttr
  # this method gets called when anyone does an `include DataAttr` in their classes
  # sub_class will be the class that is module is being included in
  def self.included(klass)
    # we use a trick here to allow us to define new class methods
    # see: https://www.culttt.com/2015/07/08/working-with-mixins-in-ruby
    klass.send(:extend, DataAttrClassMethods)
    # different syntax from what i seen before
    # instead of the above, they used
    # klass.extend(DataAttrClassMethods)
    # using .send method forces our variables to be public instead of private
  end

  # TODO: Define a "data" method that returns @data



  module DataAttrClassMethods
    # any  methods we define here will end up being class methods on any
    # classes that includes DataAttr (thanks to the extend above!)

    # TODO: define the data_attr method, which should take a single symbol as input
    # and should use `define_method`, see: https://medium.com/@camfeg/dynamic-method-definition-with-rubys-define-method-b3ffbbee8197

  end
end

class MyClass
  include DataAttr

  data_attr :my_item #data_attr is a class method that our DataAttr will define.  It will add the my_item method to our class!
end



class Foo

  def initialize
    @data = {}
  end

  def data
    @data
  end

  def my_item
    @data[:my_item]
    # instance variables
    # single symbols
  end

  # style convention for set methods
  def my_item=(value)
    @data[:my_item] = value
  end

end





