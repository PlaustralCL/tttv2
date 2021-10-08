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

  describe "#player_turn" do
    subject(:game_loop) { described_class.new(board: board_double, player1: player1, player2: player2) }
    let(:choices) { [2, 3, 4, 6, 7, 8] }

    context "when user input is valid" do
      it "stops loop and does not recieve error message" do
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices)
        allow(game_loop).to receive(:player_input).and_return(valid_input)
        expect(game_loop).not_to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q")
        game_loop.player_turn
      end
    end

    context "when user input enters incorrect choice once, then a valid choice" do
      let(:choices1) { [2, 3, 4, 6, 7, 8] }
      let(:choices2) { [2, 3, 4, 6, 7, 8] }
      it "completes loops and displays error message once" do
        letter = "d"
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices1, choices2)
        allow(game_loop).to receive(:player_input).and_return(letter, valid_input)
        expect(game_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q").once
        game_loop.player_turn
      end
    end

    context "when user inputs two incorrect values, then a valid input" do
      let(:choices1) { [2, 3, 4, 6, 7, 8] }
      let(:choices2) { [2, 3, 4, 6, 7, 8] }
      let(:choices3) { [2, 3, 4, 6, 7, 8] }
      let(:choices4) { [2, 3, 4, 6, 7, 8] }
      it "completes loops and displays error message twice" do
        letter = "d"
        taken_cell = "5"
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices1, choices2, choices3, choices4)
        allow(game_loop).to receive(:player_input).and_return(letter, taken_cell, valid_input)
        expect(game_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q").twice
        game_loop.player_turn
      end
    end
  end

  describe "#board_values" do
    subject(:game_values) { described_class.new(board: board_double, player1: player1, player2: player2) }
    let(:cellx) { double("cell", value: "X") }
    let(:cello) { double("cell", value: "O") }
    let(:cellb) { double("cell", value: 1) }
    let(:grid) { [cello, cellb, cellb, cellb, cellx, cellb, cellb, cellb, cellx] }
    let(:result) { ["O", 1, 1, 1, "X", 1, 1, 1, "X"] }
    context "when array of cell objects is provided" do
      it "returns array of cell values" do
        expect(game_values.board_values(grid)).to eq(result)
      end
    end
  end

  describe "play_game" do
    subject(:game_play) { described_class.new(board: board_double, player1: player1, player2: player2) }
    context "when game is over" do
      it "calls game_over only once" do
        allow(board_double).to receive(:game_over?).and_return(true)
        expect(board_double).to receive(:game_over?).once
        game_play.play_game
      end
    end

    context "when two rounds are played before game over" do
      it "calls game_over? three times before exiting" do
        allow(board_double).to receive(:game_over?).and_return(false, false, true)
        expect(board_double).to receive(:game_over?).exactly(3).times
        game_play.play_game
      end
    end
  end



end