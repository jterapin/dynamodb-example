require 'aws-sdk-dynamodb'

# creating a new client
client = Aws::DynamoDB::Client.new


# inputting arguments without curly brackets
# rsp means response
# require params - table_name, attribute_definitions, key_schema, billing_mode
rsp = client.create_table(
  table_name: 'Thread',
  attribute_definitions: [
    {
      attribute_name: 'ForumName',
      attribute_type: 'S'
    },
    {
      attribute_name: 'Subject',
      attribute_type: 'S'
    }
  ],
  key_schema: [
    {
      attribute_name: 'ForumName',
      key_type: 'HASH'
    },
    {
      attribute_name: 'Subject',
      key_type: 'RANGE'
    }
  ],
  billing_mode: 'PAY_PER_REQUEST'
)

# rsp.to_h - shows the data of the object, not all objects but most are supported
# table_status - lets you know if the table is created (CREATED OR ACTIVE)
# below code to check the table status (api call)

resp = client.describe_table(table_name: 'Forum')

# add item to table
# need to convert time to numeric as that's the only data types it accepts
add_item = client.put_item(
  table_name: 'Thread',
  item:
    {
      'ForumName' => 'Forum Test 2',
      'Subject' => 'Subject Test 2',
      'Updated' => Time.now.to_i
    }
  )

# ADD / PUT METHOD
add_item = client.put_item(
  table_name: 'Forum',
  item:
    {
      'Name' => 'Forum 2',
      'Owner' => 'Alex',
    }
)

# GET METHOD
resp = client.get_item(
  table_name: 'Thread',
  key: {
    'ForumName' => 'Forum1',
    'Subject' => 'Subject2'
  }
)

# QUERY
resp = client.query(
  table_name: 'Thread',
  key_condition_expression: 'ForumName = :v1',
  expression_attribute_values:
    {
      ":v1" => 'Forum Test'
    }
)

# DELETE AN ITEM
# two required params: table_name, key
# if the table consists of compound keys, need to provide those both!

# DELETE for Forum
resp = client.delete_item(
  table_name: 'Forum',
  key: {
    'Name': 'Forum 2'
  }
)

# DELETE for Thread - requires two keys
resp = client.delete_item(
  table_name: 'Thread',
  key: {
    'ForumName': 'Forum Test',
    'Subject':'Subject Test 2'
  }
)

# BATCH WRITE for multiple items
# BatchWriteItem can do up to 25 item put or delete operations
# as a reminder, put operation can either create or replace item!
# i can do one batch write call for more than one tables? need to test    result: YES I CAN
#

# simple BatchWriteItem request for one table (put request)
# for table Forum only
resp = client.batch_write_item(
  request_items: {
    'Forum' => [
      {
        put_request: {
          item: {
            'Name' => 'Name 4',
            'Owner' => 'Owner 4 Updated',
            'Updated' =>Time.now.to_i
          }
        }
      },
      {
        put_request: {
          item: {
            'Name' => 'Name 5',
            'Owner' => 'Owner 5 Updated',
            'Updated' =>Time.now.to_i
          }
        }
      },
      {
        delete_request: {
          key: {
            'Name' => 'Test Name',
          }
        }
      }
    ]
  }
)

# question for alex - do i use => or :

# batch write for multiple tables
resp = client.batch_write_item(
  request_items: {
    'Forum' => [
      {
        put_request: {
          item: {
            'Name' => 'Name 6',
            'Owner' => 'Owner 6',
            'Updated' =>Time.now.to_i
          }
        }
      },
      {
        put_request: {
          item: {
            'Name' => 'Name 7',
            'Owner' => 'Owner 7',
            'Updated' =>Time.now.to_i
          }
        }
      },
    ],
    'Thread' => [
      {
        put_request: {
          item: {
            'ForumName' => 'Forum Test 3',
            'Subject' =>'Subject Test 3'
          }
        }
      }
    ]
  }
)

# update_item to do an atomic increment
# example table to test - Thread with an attribute named 'Foo'
resp = client.update_item({
  table_name: 'Thread',
  key: {
    'ForumName' => 'Forum2',
    'Subject' => 'Subject2'
  },
  expression_attribute_values: {
    ':i' => 1,
  },
  update_expression: 'SET Foo = Foo + :i',
  return_values: 'UPDATED_NEW',
})


def increment_foo(client)
  client.update_item({
    table_name: 'Thread',
    key: {
     'ForumName' => 'Forum2',
     'Subject' => 'Subject2'
    },
    expression_attribute_values: {
     ':i' => 1,
    },
    update_expression: 'SET Foo = Foo + :i',
    return_values: 'UPDATED_NEW',
    })
end