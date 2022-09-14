module DataAttr
  # this method gets called when anyone does an `include DataAttr` in their classes
  # sub_class will be the class that is module is being included in
  def self.included(klass)
    # we use a trick here to allow us to define new class methods
    # see: https://www.culttt.com/2015/07/08/working-with-mixins-in-ruby
    klass.send(:extend, DataAttrClassMethods)
    # different syntax from what i seen before (`klass.extend(DataAttrClassMethods)`)
    # using .send method forces our variables to be public instead of private

  end

  def initialize
    @data = {}
  end

  # TODO: Define a "data" method that returns @data
  def data
    @data
  end


  module DataAttrClassMethods
    # any  methods we define here will end up being class methods on any
    # classes that includes DataAttr (thanks to the extend above!)

    # TODO: define the data_attr method, which should take a single symbol as input
    # and should use `define_method`, see: https://medium.com/@camfeg/dynamic-method-definition-with-rubys-define-method-b3ffbbee8197
    define_method('data_attr') do |my_item|
      "This is #{my_item}" # add a method to a class
    end
    # define method allows you to create other methods! which is why it is used
    # my_item does two things - return data and set data

  end
end

class MyClass
  include DataAttr

  data_attr :my_item #data_attr is a class method that our DataAttr will define.
  # It will add the my_item method to our class!

end

class Foo
  # code that wants to read or write those instances of variables
  # must use helper methods such as
  # attr_reader, attr_writer or attr_accessor
  attr_accessor :title

  # when creating an instance of Foo, this ensures we are
  # creates an empty hash called data
  # the @ indicates instance variable - which is specific to the class
  def initialize(title)
    @data = {}
    @title = title
  end

  def data
    @data
  end

  def my_item
    @data[:my_item]
    # instance variables
    # single symbols
  end

  # setter for my_item
  def my_item=(value)
    @data[:my_item] = value
  end

end