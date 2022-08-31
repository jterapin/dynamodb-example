require 'aws-record'

# Forum class
class Forum
  include Aws::Record
  string_attr :Name, hash_key: true
  string_attr :Owner
  integer_attr :Updated
end

# .find is a class method associated with Aws::Record
#  need to pass in primary key
