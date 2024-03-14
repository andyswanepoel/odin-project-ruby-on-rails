# frozen_string_literal: true

def get_new_char(char, offset, is_upper)
  return char if char.downcase.ord < 'a'.ord || char.downcase.ord > 'z'.ord

  new_char = ('a'.ord + (char.downcase.ord - 'a'.ord + offset) % 26).chr
  is_upper ? new_char.upcase : new_char
end

def caesar_cipher(string, offset)
  out = []
  string.each_char do |char|
    is_upper = char == char.upcase
    out << get_new_char(char, offset, is_upper)
  end
  out.join
end

puts caesar_cipher('Rcvo v nomdib!', 5)
