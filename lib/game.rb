# frozen_string_literal: true

# Control the flow of the game by coordinating the other classes
class Game
  attr_reader :board, :player1, :player2, :guess

  def initialize(
    board: Board.new,
    player1: Player.new(name: "Player 1", marker: "X"),
    player2: Player.new(name: "Player 2", marker: "O")
  )
    @board = board
    @player1 = player1
    @player2 = player2
  end

  def play_game
    # introduction
    play_one_round until board.game_over?
    # final_message
  end

  def play_one_round

  end

  def player_turn
    loop do
      input = verify_input(player_input)
      return input if input

      puts "Input Error! Please use one of the following choices: #{board.available_cells.push("q").join(", ")}"
    end
  end

  def verify_input(user_input, choices = board.available_cells)
    choices << "q"
    return user_input if choices.map(&:to_s).include?(user_input)
  end

  def board_values(grid = board)
    grid.map(&:value)
  end

  def final_message
    puts "Thanks for playing!"
  end

  private

  def player_input
    puts "Please select a number (1 - 9) that is available for your turn"
    gets.chomp.downcase
  end

  def introduction
    puts "Welcome to Tic Tac Toe\n"
  end

end
