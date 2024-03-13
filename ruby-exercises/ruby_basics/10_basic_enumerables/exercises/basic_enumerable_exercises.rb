# frozen_string_literal: true

def display_current_inventory(inventory_list)
  inventory_list.each do |key, value|
    puts "#{key}, quantity: #{value}"
  end
end

def display_guess_order(guesses)
  guesses.each_with_index do |guess, index|
    puts "Guess ##{index + 1} is #{guess}"
  end
end

def find_absolute_values(numbers)
  numbers.map(&:abs)
end

def find_low_inventory(inventory_list)
  inventory_list.select do |_item, inventory|
    inventory < 4
  end
end

# rubocop:disable Style/EachWithObject
def find_word_lengths(word_list)
  word_list.reduce({}) do |hash, word|
    hash[word] = word.length
    hash
  end
  # Apparently there is also an each_with_object method
  # word_list.each_with_object({}) do |word, hash|
  #   hash[word] = word.length
  # end
end
# rubocop:enable Style/EachWithObject
