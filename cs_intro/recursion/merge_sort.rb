# frozen_string_literal: true

def merge_sorted_arrays(left, right)
  sorted = []
  l = 0
  r = 0

  while l <= left.length - 1 && r <= right.length - 1
    sorted.push(left[l] < right[r] ? left[(l += 1) - 1] : right[(r += 1) - 1])
  end

  sorted.concat(r > right.length - 1 ? left.slice(l..) : right.slice(r..))
end

def merge_sort(arr)
  return arr if arr.length <= 1

  # sort left half
  left_numbers = arr.slice(0, arr.length / 2)
  sorted_left = merge_sort(left_numbers)
  # sort right half
  right_numbers = arr.slice(arr.length / 2, arr.length)
  # puts "right_numbers: #{right_numbers}"
  sorted_right = merge_sort(right_numbers)
  # merge two halfs
  merge_sorted_arrays(sorted_left, sorted_right)
end

p merge_sort([10, -1, 1])
