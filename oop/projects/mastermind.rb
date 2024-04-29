# frozen_string_literal: true

# The whole game
module Mastermind
  # Player
  class Player
    attr_accessor :name, :record

    def initialize(name)
      @name = name
      @record = { win: 0, loss: 0, draw: 0 }
    end

    def update_record(result = 'draw')
      @record[:draw] += 1 if result == 'draw'
      @record[:win] += 1 if result == 'win'
      @record[:loss] += 1 if result == 'loss'
    end
  end

  # Board
  class Board
    attr_accessor :guesses, :feedback, :matches
    attr_reader :turns

    def initialize(secret)
      @secret = secret
      self.guesses = []
      self.matches = []
      @turns = 10
    end

    def add_guess(guess)
      # Need to validate the guess at some point
      @guesses << guess
      @matches << get_matches(guess)
    end

    def winner?
      guesses.last == @secret
    end

    def no_more_guesses?
      guesses_left.zero?
    end

    def guesses_left
      turns - guesses.length
    end

    def print_secret(show_secret)
      puts "| S |#{@secret.map { |s| " #{s} |" }.join}" if show_secret
    end

    def print_guesses_left(show_guesses_left)
      puts "\nYou have #{guesses_left} guesses remaining." if show_guesses_left
    end

    def print_header
      puts "\n| Guess | 1 | 2 | 3 | 4 | Matches |"
      puts '-----------------------------------'
    end

    def get_guess_string(arr)
      arr.map { |s| " #{s} |" }.join.to_s
    end

    def get_match_string(arr)
      arr.map { |s| "#{s} " }.join.to_s
    end

    def print_guesses(index)
      guess = get_guess_string(guesses[index])
      match = get_match_string(matches[index])
      spaces = ' ' * (4 - matches[index].length) * 2
      puts "|   #{index + 1}  #{' ' if index < 9}|#{guess} #{match}#{spaces}|"
      puts '-----------------------------------'
    end

    def print_board(options = {})
      print_header unless guesses.empty?

      (0...guesses.length).each do |i|
        print_guesses(i)
      end
      print_secret(options[:show_secret])
      print_guesses_left(options[:show_guesses_left])
    end

    private

    def add_temp_match(matches, val, temp_secret, index)
      matches << val
      temp_secret[index] = nil
    end

    def get_matches(guess)
      matches = []
      temp_secret = @secret.dup
      guess.each_index do |i|
        found = temp_secret.find_index(guess[i])
        next unless found

        add_temp_match(matches, 2, temp_secret, found) if found == i
        next if found == i

        add_temp_match(matches, temp_secret[found] == guess[found] ? 2 : 1, temp_secret, found)
      end
      matches.shuffle
    end
  end

  # Game
  class Game
    LONG_COLORS = %w[red blue green yellow purple orange].freeze
    SHORT_COLORS = LONG_COLORS.map { |color| color[0, 1].upcase }
    attr_accessor :board, :player

    def initialize(player)
      @secret = 4.times.map { SHORT_COLORS.sample }
      self.board = Board.new(@secret)
      self.player = player
      start
    end

    def start
      print_welcome_message
      until game_over?
        guess = player_guess
        board.add_guess(guess)
        board.print_board({ show_guesses_left: !game_over? })
      end
      print_game_over
    end

    private

    def player_guess
      print "\nEnter guess #{board.guesses.length + 1}: "
      gets.chomp.split
    end

    def print_game_over
      if board.winner?
        puts "You win! You guessed the code! It was #{@secret.join(' ')}."
      elsif board.no_more_guesses?
        puts 'Sorry! You lost! :('
        puts "The secret message was #{@secret.join(' ')}."
      end
    end

    def print_welcome_message
      puts "Welcome to Mastermind, #{player.name}!"
      puts "You will have #{board.turns} guesses to figure out the secret message."
      puts 'The secret message will contain 4 colored pegs. After each guess, you will be given feedback.'
      puts "The color options are: #{LONG_COLORS.map { |color| color }.join(', ')}."
      puts 'Your guess should use the capitalized first letter of the color.'
      puts "For example 'Y R B G' would represent a guess of yellow, red, blue, green in that order."
      puts "If you have guessed a peg of the right color AND the right position, a '2' will be given."
      puts "If you have guessed a peg of the right color BUT the wrong position, a '1' will be given."
      puts "You'll need to use the feedback in the 'Matches' column to inform your next guess."
      puts 'Good luck!'
    end

    def game_over?
      board.winner? or board.no_more_guesses?
    end
  end
end

andy = Mastermind::Player.new('Andy')
Mastermind::Game.new(andy)
