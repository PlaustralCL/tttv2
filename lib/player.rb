# frozen_string_literal: true

# Maintain information about the players
class Player
  attr_reader :name, :marker

  def initialize(name: "Player", marker: "X")
    @name = name
    @marker = marker
  end
end
