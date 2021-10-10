# frozen_string_literal: true

require_relative "../lib/display"

describe Display do
  describe "#create_visual_board" do
    context "when given default array" do
      subject(:start_display) { described_class.new }
      let(:starting_string) { " 1 | 2 | 3\n---+---+----\n 4 | 5 | 6\n---+---+----\n 7 | 8 | 9\n" }
      it "makes a string board" do
        expect(start_display.create_visual_board).to eq(starting_string)
      end
    end

    context "when given a game with markers" do
      subject(:updated_display) { described_class.new(board: ["X", "X", "O", 4, "O", 6, 7, "O", 9]) }
      let(:updated_string) { " \e[0;34mX\e[0m | \e[0;34mX\e[0m | \e[0;31mO\e[0m\n---+---+----\n 4 | \e[0;31mO\e[0m | 6\n---+---+----\n 7 | \e[0;31mO\e[0m | 9\n" }

      it "makes the proper string board" do
        expect(updated_display.create_visual_board).to eq(updated_string)
      end
    end
  end

  describe "#add_color" do
    subject(:color_display) { described_class.new(board: ["X", 2, "O"]) }
    let(:updated_boad) { ["\e[0;34mX\e[0m", 2, "\e[0;31mO\e[0m"] }
    context "when X, Y, and number are present" do
      it "adds the proper color" do
        expect(color_display.add_color).to eq(updated_boad)
      end
    end
  end
end
