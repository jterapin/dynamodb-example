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

# Thread class
#
class ThreadRecord
  include Aws::Record
  set_table_name "Thread"
  string_attr :ForumName, hash_key: true
  string_attr :rk, range_key: true, database_attribute_name: 'Subject'
  epoch_time_attr :Updated

  # overriding class method from Aws::Record
  # need to look into the source code to match opts
  def save(opts = {})
    # passing in options from the save class from source code
    self.Updated = Time.now
    super opts
  end

end

# .find to see if the class exists
# .to_h to look inside of an objectt.
# method that ends with ? means return true or false
# method that ends with ! means dangerous, mutate original data

# save! checks to see if the object has all info to perform save
# if object method has raise errors, the method might be marked with !

# dirty method on class will show what attributes has been changed on local machine

# Debug class
class Debug
  include Aws::Record
  string_attr :id, hash_key: true
  string_attr :rk, range_key: true
end
