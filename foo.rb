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