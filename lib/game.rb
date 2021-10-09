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
    current_player = player1
    until board.game_over?
      break if play_one_round(current_player) == "quit"

      current_player = current_player == player1 ? player2 : player1
    end
    final_message
  end

  def show_board(display = Display.new(board_values))
    puts display.create_visual_board
  end

  def play_one_round(current_player)
    cell = current_player.player_turn
    return "quit" if cell == "q"

    board.update_board(cell.to_i, current_player.marker)
    show_board
  end

  def board_values(grid = board.gameboard)
    grid.map(&:value)
  end

  def final_message
    puts "Thanks for playing!"
  end

  private

  def introduction
    puts "Welcome to Tic Tac Toe\n"
  end

end
