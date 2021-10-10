# frozen_string_literal: true

require_relative "color"
# Methods for preparing information for display
class Display
  attr_reader :board

  def initialize(board: (1..9).to_a)
    @board = board
  end

  def create_visual_board
    add_color
    board.each_slice(3)
         .map { |row| row.join(" | ") }
         .map { |row| " #{row}\n"}
         .join("---+---+----\n")
  end

  def add_color
    color_codes = { "X" => "blue", "O" => "red" }
    @board = board.map do |marker|
      if %w[X O].include?(marker)
        marker.public_send(color_codes[marker])
      else
        marker
      end
    end
  end
end
