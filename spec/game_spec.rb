# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { double("player", name: "Player1", marker: "X") }
  let(:player2) { double("player", name: "Player2", marker: "O") }
  let(:board_double) { double("board") }

  describe "#valid_input?" do
    subject(:fresh_game) { described_class.new(board: board_double, player1: player1, player2: player2) }

    context "when a digit between 1 and 9 entered" do
      let(:user_input) { "1" }
      it "returns true" do
        expect(fresh_game.valid_input?(user_input)).to be true
      end
    end

    context "when non-digit entered" do
      let(:user_input) { "d" }
      it "returns false" do
        expect(fresh_game.valid_input?(user_input)).to be false
      end
    end

    context "when multi-digit number entered" do
      let(:user_input) { "32" }
      it "returns false" do
        expect(fresh_game.valid_input?(user_input)).to be false
      end
    end

    context "when digit and letter entered" do
      let(:user_input) { "5a" }
      it "returns false" do
        expect(fresh_game.valid_input?(user_input)).to be false
      end
    end
  end
end