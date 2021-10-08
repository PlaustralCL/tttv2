# frozen_string_literal: true

# require_relative "board"
# require_relative "display"
# require_relative "player"
# require_relative "cell"

# Control the flow of the game by coordinating the other classes
class Game
  attr_reader :board, :player1, :player2

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
    introduction
    show_board
    play_one_round until board.game_over? # TODO: switch players between rounds
    final_message
  end

  def show_board(display = Display.new)
    puts display.create_visual_board
  end

  def play_one_round
    player_turn # add variable to track input
    # add exit it input == "q"
    # update board with player input (cell -> input, marker -> current_player.marker)
    show_board(Display.new(board: board_values))
    # switch players current_player.object_id == player1 ? player2 : player1
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

  def board_values(grid = board.gameboard)
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
