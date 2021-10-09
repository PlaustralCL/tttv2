# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { double("player1", name: "Player1", marker: "X") }
  let(:player2) { double("player2", name: "Player2", marker: "O") }
  let(:board_double) { double("board") }

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

  describe "#play_game" do
    subject(:game_play) { described_class.new(board: board_double, player1: player1, player2: player2) }

    before do
      allow(game_play).to receive_messages(introduction: nil, final_message: nil, show_board: nil)
    end

    context "when game is over" do
      it "calls game_over only once" do
        allow(board_double).to receive(:game_over?).and_return(true)
        expect(board_double).to receive(:game_over?).once
        game_play.play_game
      end
    end

    context "when two rounds are played before game over" do
      it "calls game_over? three times before exiting" do
        allow(game_play).to receive(:play_one_round).and_return(nil)
        allow(board_double).to receive(:game_over?).and_return(false, false, true)
        expect(board_double).to receive(:game_over?).exactly(3).times
        game_play.play_game
      end
    end

    context "when two rounds are played" do
      it "alternates players" do
        allow(board_double).to receive(:game_over?).and_return(false, false, true)
        expect(game_play).to receive(:play_one_round).with(player1)
        expect(game_play).to receive(:play_one_round).with(player2)
        game_play.play_game
      end
    end

    context "when input is 'q'" do
      xit "exits the loop" do

      end
    end

  end

  describe "#show_board" do
    subject(:game_show) { described_class.new(board: board_double, player1: player1, player2: player2) }
    let(:display) { double("display") }
    context "when needed to show the board" do
      it "calls create_visual_board" do
        allow(game_show).to receive(:puts)
        expect(display).to receive(:create_visual_board).once
        game_show.show_board(display)
      end
    end
  end

  describe "#play_one_round" do
    subject(:game_round) { described_class.new(board: board_double, player1: player1, player2: player2) }
    context "when it it player 1's turn" do
      it "it calls player_turn for player 1" do
        allow(game_round).to receive(:show_board)
        expect(player1).to receive(:player_turn).once
        game_round.play_one_round(player1)
      end
    end

    context "when it it player 1's turn" do
      it "it calls player_turn for player 1" do
        allow(game_round).to receive(:show_board)
        expect(player2).to receive(:player_turn).once
        game_round.play_one_round(player2)
      end
    end

    context "when the player inputs 'q'" do
      xit "returns without updating the board" do
      end
    end
  end

  describe "#final_message" do
    context "when the game is a tie" do
      xit "shows tie message" do

      end
    end

    context "when player 1 wins" do
      xit "states player 1 won" do

      end
    end

    context "when player 2 wins" do
      xit "states player 2 won" do

      end
    end
  end




end