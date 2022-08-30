# Given an array of integers, write a function to find the K closest values to X.
#
#   def k_closest(arr, x, k):
#   # return k values that are the closest to x
#
#   Example:
#   arr = [9, 4, 3, 6, 2, 1, 9, 10]
# x = 5
# k = 2
#
# Returns: [4, 6]

def k_closest(arr, x, k)
  # sort the array
  sorted = arr.sort {|a,b|(a-x).abs<=>(b-x).abs}
  sorted.first(k)
end
