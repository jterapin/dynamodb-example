require 'rspec'
require_relative '../k_closest'

describe 'k_closest' do
  it 'passes the example' do
    arr = [9, 4, 3, 6, 2, 1, 9, 10]
    x = 5
    k = 2
    output = k_closest(arr, x, k)
    expect(output).to eq([4, 6])
  end
end