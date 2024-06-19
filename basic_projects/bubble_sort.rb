# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
def bubble_sort(arr)
  loop do
    swaps = 0
    arr.each_with_index do |num, i|
      next unless i < arr.length - 1 && num > arr[i + 1]

      temp = arr[i + 1]
      arr[i + 1] = num
      arr[i] = temp
      swaps += 1
    end
    break if swaps.zero?
  end
  arr
end
# rubocop:enable Metrics/MethodLength

p bubble_sort([54, 22, 45, 11, 8])
p bubble_sort([8, 11, 22, 45, 54])
p bubble_sort([60, 55, 44, 29, 9])
