# frozen_string_literal: true

# Methods for preparing information for display
class Display
  attr_reader :board

  def initialize(board: (1..9).to_a)
    @board = board
  end

  def create_visual_board
    board.each_slice(3)
         .map { |row| row.join(" | ") }
         .map { |row| " #{row}\n"}
         .join("---+---+----\n")
  end
end
