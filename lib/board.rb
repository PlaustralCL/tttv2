# frozen_string_literal: true

require_relative "cell"

# Holds the state of the board/ game. Can tell when the game is over
class Board
  attr_reader :gameboard, :winner

  def initialize(gameboard = Array.new(9) { |i| Cell.new(value: i + 1) })
    @gameboard = gameboard
    @winner = ""
  end

  def game_over?
    winner? || full_board?
  end

  def full_board?
    gameboard.none? { |cell| cell.value.is_a?(Integer) || cell.value == "" }
  end

  def winner?
    horizontal_winner? || vertical_winner? || diagonal_winner?
  end

  def horizontal_winner?
    game_won?
  end

  def vertical_winner?
    game_won?(gameboard.each_slice(3).to_a.transpose.flatten)
  end

  def diagonal_winner?
    board = gameboard.each_slice(3).to_a
    first_diag = (0..2).map { |i| board[i][i] }
    second_diag = (0..2).map { |i| board[2 - i][i] }
    game_won?(first_diag + second_diag)
  end

  def game_won?(board = gameboard)
    board_values = board.map(&:value).each_slice(3)
    @winner = board_values.select { |row| row.join == "XXX" || row.join == "OOO" }.join
    winner == "XXX" || winner == "OOO"
  end

  def update_board(cell, marker)
    gameboard[cell].update_value(marker)
  end

  def available_cells
    # gameboard.select { |cell| cell.value.is_a?(Integer) }
    # The code above should work, but rspec seemed to have trouble with 'select'.
    # The final line seems convoluted, but it was able to be tested.
    gameboard.map(&:value).join.scan(/\d/).map(&:to_i)
  end
end
