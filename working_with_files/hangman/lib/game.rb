# frozen_string_literal: true

require 'json'

# Hangman
module Hangman
  # The game
  class Game
    attr_accessor :name, :guesses, :word, :correct_guesses
    attr_reader :turns

    def initialize(saved_game = nil)
      @turns = 11
      if saved_game
        initialize_saved_game(saved_game)
      else
        initialize_new_game
      end
    end

    private

    def initialize_saved_game(saved_game)
      self.name = saved_game['name']
      self.guesses = saved_game['guesses']
      self.word = saved_game['word']
      self.correct_guesses = saved_game['correct_guesses']
      start(returning_player: true)
    end

    def initialize_new_game
      puts 'What is your name?'
      self.name =  gets.chomp
      self.guesses = []
      self.word = select_word_from_list
      self.correct_guesses = Array.new(word.length) { nil }
      start
    end

    def select_word_from_list
      file = File.open('./words.txt')
      filtered_words = file.readlines.map(&:chomp).filter { |word| word.length >= 5 && word.length <= 12 }
      file.close
      filtered_words.sample
    end

    def start(returning_player: false)
      puts "TEST: the chosen word: #{word}"
      if returning_player
        puts "Welcome back, #{name}! You have #{turns - guesses.length} guesses remaining to find the word!"
      else
        puts "Welcome to Hangman, #{name}! You have #{turns} guesses to find the word!"
      end

      puts "Let's begin!"
      turn until game_over?
    end

    def game_over?
      winner? || no_more_guesses?
    end

    def winner?
      correct_guesses.filter(&:nil?).empty?
    end

    def no_more_guesses?
      guesses.length == @turns
    end

    def turn
      print_guesses_remaining
      print_current_word
      # need to make sure same letter isn't picked
      puts "\nPick a letter or enter 'save' to save your progress."
      guess = gets.chomp
      save_game if guess == 'save'
      guesses << guess
      add_correct_guesses(guess) if word.include?(guess)
    end

    def print_guesses_remaining
      guesses_remaining = @turns - guesses.length
      if guesses_remaining == 1
        puts 'Last guess! Make it count!'
      else
        puts "\nGuesses remaining: #{@turns - guesses.length}"
      end
    end

    def print_current_word
      puts("Word: #{correct_guesses.map { |letter| letter.nil? ? '_' : letter }.join}")
    end

    def add_correct_guesses(guess)
      word.split('').each_with_index { |char, i| correct_guesses[i] = char if char == guess }
    end

    def save_game
      # serialize :name, :guesses, :word, :correct_guesses
      # even though you make your hash with symbols, they get serialized into strings
      game_data = JSON.generate({ name: name, guesses: guesses, word: word, correct_guesses: correct_guesses })
      # create directory
      Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
      # create file
      filename = "saved_games/#{name.downcase}_#{Time.now.strftime('%d-%m-%Y')}.json"
      # save file
      File.open(filename, 'w') do |file|
        file.puts game_data
      end
    end
  end
end

puts 'Would you like to load a saved game? Y/N'
load_saved_game = gets.chomp == 'Y'
if load_saved_game
  saved_games = Dir.children('saved_games')
  puts 'Saved games:'
  puts saved_games
  puts 'What is the name of your saved game?'

  saved_game_file = File.read("saved_games/#{gets.chomp}")

  saved_game = JSON.parse(saved_game_file)
  Hangman::Game.new(saved_game)
else
  Hangman::Game.new
end
