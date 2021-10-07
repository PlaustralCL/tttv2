# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { double("player", name: "Player1", marker: "X") }
  let(:player2) { double("player", name: "Player2", marker: "O") }
  let(:board_double) { double("board") }

  describe "#verify_input" do
    subject(:verify_game) { described_class.new(board: board_double, player1: player1, player2: player2) }
    let(:choices) { [2, 3, 4, 6, 7, 8] }

    context "when a valid choice is entered" do
      let(:user_input) { "2" }
      it "returns 2" do
        expect(verify_game.verify_input(user_input, choices)).to be("2")
      end
    end

    context "when input is q" do
      let(:user_input) { "q" }
      it "returns q" do
        expect(verify_game.verify_input(user_input, choices)).to be("q")
      end
    end
    context "when 0 entered" do
      let(:user_input) { "1" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when letter that is not q is entered" do
      let(:user_input) { "d" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when multi-digit number entered" do
      let(:user_input) { "32" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end

    context "when digit and letter entered" do
      let(:user_input) { "5a" }
      it "returns nil" do
        expect(verify_game.verify_input(user_input, choices)).to be_nil
      end
    end
  end
end