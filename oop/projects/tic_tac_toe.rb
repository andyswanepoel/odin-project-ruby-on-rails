# frozen_string_literal: true

# rubocop:disable Metrics/MethodLength
module TicTacToe
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

  # Game
  class Game
    attr_accessor :board

    def initialize(player1, player2)
      self.board = Board.new
      @players = []
      @players << { player: player1, opponent: player2, mark: 'X', turn?: true }
      @players << { player: player2, opponent: player1, mark: 'O', turn?: false }
    end

    def game_over?
      full = board.full?
      winner = board.winner?
      full or winner
    end

    def start
      until game_over?
        current_player = @players.find { |player| player[:turn?] }
        take_turn current_player
      end

      if board.full?
        finish_game
        return
        # Update stats
      end

      winner = @players.find { |player| player[:mark] == board.winner? }
      finish_game winner
    end

    private

    def play_again
      puts 'Would you like to play again? Y/N'
      play_again = gets.chomp

      if play_again == 'Y'
        board.clear_board
        start
      else
        puts 'Okay, see you later!'
      end
    end

    def finish_game(winner = nil)
      puts 'Game over!'
      board.print_board
      if winner
        update_records(winner[:player].record, :win)
        @players.reject { |player| player == winner }.each do |player|
          update_records(player[:player].record, :loss)
        end
        congratulate_winner(winner)
      else
        puts "It's a draw! Better luck next time!"
        update_draw_records
      end
      play_again
    end

    def update_records(record, result)
      record[result] += 1
    end

    def update_draw_records
      @players.each { |player| player[:player].record[:draw] += 1 }
    end

    def congratulate_winner(winner)
      puts "Congrats, #{winner[:player].name}! You win!"
    end

    def handle_input
      command = gets.chomp
      board.print_board if command == 'B'
      return if command == 'B'

      begin
        position = Integer(command)
        raise unless position.between?(1, 9)
      rescue StandardError
        puts "Please enter a number between 1 and 9 that isn't already taken."
        puts '-----------------------------'
      else
        position
      end
    end

    def take_turn(current_player)
      puts "It's your turn #{current_player[:player].name}! To see the board, enter 'B'."
      puts "Otherwise enter where would you like to place your '#{current_player[:mark]}'?"
      position = handle_input
      board.add_to_board(current_player[:mark], position) if position
      # Swap current player
      @players.each { |player| player[:turn?] = !player[:turn?] } if position
    end
  end
end

# Board
class Board
  def initialize
    clear_board
  end

  def full?
    @game_board.all? { |square| !square.is_a? Numeric }
  end

  def winner?
    winning_row? or winning_col? or winning_diagonal?
  end

  # position will be 1-based
  def add_to_board(mark, position)
    current_mark = @game_board[position - 1]
    if %w[X O].include?(current_mark)
      puts "That position is already take with #{current_mark}"
      false
    else
      @game_board[position - 1] = mark
      true
    end
  end

  def clear_board
    @game_board = Array.new(9).fill { |i| i + 1 }
  end

  def print_board
    puts '-------------'
    3.times do |num|
      puts "| #{@game_board[0 + num * 3]} | #{@game_board[1 + num * 3]} | #{@game_board[2 + num * 3]} |"
      puts '-------------'
    end
  end

  private

  def winning_row?
    rows = [[0, 1, 2], [3, 4, 5], [6, 7, 8]]
    %w[X O].find { |mark| rows.any? { |row| row.all? { |index| @game_board[index] == mark } } }
  end

  def winning_col?
    cols = [[0, 3, 6], [1, 4, 7], [2, 5, 8]]
    %w[X O].find { |mark| cols.any? { |col| col.all? { |index| @game_board[index] == mark } } }
  end

  def winning_diagonal?
    diagonals = [[0, 4, 8], [2, 4, 6]]
    %w[X O].find { |mark| diagonals.any? { |diagonal| diagonal.all? { |index| @game_board[index] == mark } } }
  end
end
# rubocop:enable Metrics/MethodLength

katie = TicTacToe::Player.new('Katie')
andy = TicTacToe::Player.new('Andy')
game = TicTacToe::Game.new(katie, andy)
game.start
