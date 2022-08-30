require 'rspec'
require_relative '../foo'

describe 'foo' do
  it 'returns hello' do
    output = foo('Alex')
    expect(output).to eq('Hello Alex')
  end
end