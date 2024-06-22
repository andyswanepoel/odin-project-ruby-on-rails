# frozen_string_literal: true

# Extending the Enumerable module
module Enumerable
  # Runs the block for each item in an Array
  def my_each_with_index
    i = 0
    my_each do |item|
      yield(item, i)
      i += 1
    end
  end

  # Returns a new Array of items that match the block condition
  def my_select
    arr = []
    my_each do |item|
      arr << item if yield(item)
    end
    arr
  end

  # Returns true if all elements in Array satisfy the block condition
  def my_all?
    my_each do |item|
      return false unless yield(item)
    end
    true
  end

  # Returns true if any elements in Array satisfy the block condition
  def my_any?
    my_each do |item|
      return true if yield(item)
    end
    false
  end

  # Returns a new Array of items that match the block condition
  def my_map
    arr = []
    my_each do |item|
      arr << yield(item)
    end
    arr
  end

  # Combines all elements of an Array using an initial value and block expression
  def my_inject(initial)
    memo = initial
    my_each do |item|
      memo = yield(memo, item)
    end
    memo
  end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method
class Array
  # Define my_each here
  def my_each
    # rubocop:disable Style/For
    for item in self
      yield(item)
    end
    # rubocop:enable Style/For
  end
end

# [1, 2, 3].my_each_with_index { |item, index| puts "#{item} is at index #{index}"}
# newArr = [1, 2, 3].my_select { |item| item > 1 }
# p newArr
# puts [2, 2, 3, 4].my_all? { |item| item > 1 }

# mulArr = [1, 2, 3].my_map { |item| item * 2 }
# puts mulArr
# puts [1, 2, 3].my_inject(0) { |sum, item| sum + item}
# rubocop:enable all
