# frozen_string_literal: true

# Maintain information about the players and methods for player actions
class Player
  attr_reader :name, :marker

  def initialize(name: "Player", marker: "X")
    @name = name
    @marker = marker
  end

  def player_turn(board = Board.new)
    loop do
      available_cells = board.available_cells
      input = verify_input(player_input, available_cells)
      return input if input

      puts "Input Error! Please use one of the following choices: #{available_cells.push("q").join(", ")}"
    end
  end

  def verify_input(user_input, choices = nil)
    choices << "q"
    return user_input if choices.map(&:to_s).include?(user_input)
  end

  def player_input
    puts "#{name}, please select a number (1 - 9) that is available for your turn"
    gets.chomp.downcase
  end
end
