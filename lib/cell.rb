# frozen_string_literal: true

# Holds the marker and color for each cell in the board
class Cell
  attr_reader :value, :color

  def initialize(value: "", color: "")
    @value = value
    @color = color
  end

  def update_value(new_value)
    @value = new_value
  end

  def update_color(new_color)
    @color = new_color
  end
end
