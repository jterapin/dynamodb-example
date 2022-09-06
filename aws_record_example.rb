require 'aws-record'

# .find is a class method associated with Aws::Record

# Forum class
class Forum
  include Aws::Record
  string_attr :Name, hash_key: true
  string_attr :Owner
  epoch_time_attr :Updated

  def save(opts = {})
    self.Updated = Time.now
    super opts
  end

  # define a method called get_all_threads
  # call the query class method from Thread Record
  # pass in :Name
  # after getting the information, print to see what the data looks like
  # what data should this method
  def get_all_threads
    query = ThreadRecord.query(
      # what specific data needs to match
      expression_attribute_values: {
        ':n' => self.Name
      },
      # what attribute i need from ThreadRecord to reference
      expression_attribute_names: {
        '#N' => 'ForumName'
      },
      # what info needs to match
      key_condition_expression: '#N = :n',
      )

    thread_num = 0
    query.each do |thread|
      thread_num += 1
      puts "#{thread_num}"
      puts "Subject: #{thread.rk} \nUpdated:#{thread.Updated}"
      puts "_____________"
    end
  end

end



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
# .to_h to look inside of an object.
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
