# frozen_string_literal: true

def coffee_drink?(drink_list)
  drink_list.include?('coffee') or drink_list.include?('espresso')
end

def correct_guess?(guess_list, answer)
  # use #any? to return true when any element of the guess_list (array) equals the answer (number)
  guess_list.any? do |guess|
    guess == answer
  end
end

def twenty_first_century_years?(year_list)
  # use #all? to return true when all of the years in the year_list (array) are between 2001 and 2100
  year_list.all? do |year|
    year.between? 2001, 2100
  end
end

def correct_format?(word_list)
  # use #none? to return true when none of the words in the word_list (array) are in upcase
  word_list.none? do |word|
    word == word.upcase
  end
end

def valid_scores?(score_list, perfect_score)
  # use #one? to return true when only one value in the score_list (hash) is equal to the perfect_score (number)
  score_list.one? do |_key, score|
    score == perfect_score
  end
end
