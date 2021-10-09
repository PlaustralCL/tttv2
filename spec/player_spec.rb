# frozen_string_literal: true

require_relative "../lib/player"

describe Player do
  let(:board_double) { double("board") }

  describe "#verify_input" do
    subject(:verify_game) { described_class.new }
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
    subject(:player_loop) { described_class.new }
    let(:choices) { [2, 3, 4, 6, 7, 8] }

    context "when user input is valid" do
      it "stops loop and does not recieve error message" do
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices)
        allow(player_loop).to receive(:player_input).and_return(valid_input)
        expect(player_loop).not_to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q")
        player_loop.player_turn(board_double)
      end
    end

    context "when user input enters incorrect choice once, then a valid choice" do
      let(:choices1) { [2, 3, 4, 6, 7, 8] }
      let(:choices2) { [2, 3, 4, 6, 7, 8] }
      it "completes loops and displays error message once" do
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices1, choices2)
        allow(player_loop).to receive(:player_input)
        allow(player_loop).to receive(:verify_input).and_return(nil, valid_input)
        expect(player_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q").once
        player_loop.player_turn(board_double)
      end
    end

    context "when user inputs two incorrect values, then a valid input" do
      let(:choices1) { [2, 3, 4, 6, 7, 8] }
      let(:choices2) { [2, 3, 4, 6, 7, 8] }
      let(:choices3) { [2, 3, 4, 6, 7, 8] }
      let(:choices4) { [2, 3, 4, 6, 7, 8] }
      it "completes loops and displays error message twice" do
        valid_input = "3"
        allow(board_double).to receive(:available_cells).and_return(choices1, choices2, choices3, choices4)
        allow(player_loop).to receive(:player_input)
        allow(player_loop).to receive(:verify_input).and_return(nil, nil, valid_input)
        expect(player_loop).to receive(:puts).with("Input Error! Please use one of the following choices: 2, 3, 4, 6, 7, 8, q").twice
        player_loop.player_turn(board_double)
      end
    end
  end

end