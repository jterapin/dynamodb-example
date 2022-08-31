puts "Hello World!"
def foo(name)
  "Hello #{name}"
end

# def bar(first_name:, last_name:)
#   "Hello #{first_name} #{last_name}"
# end

def bar(opts={})
  "Hello #{opts[:name]}"
end

class Foo

  # lets you access the attribute
  # also comes with a setter (to update attributes)
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def hello
    "Hello #{@name}"
  end
end