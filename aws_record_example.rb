require 'aws-record'

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
  def threads # Ruby Style - 'threads' instead of get_all_threads
    # returning just the item collection
    ThreadRecord.query(
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
  end
end


# Thread class
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

class Debug
  include Aws::Record
  string_attr :id, hash_key: true
  string_attr :rk, range_key: true
end
