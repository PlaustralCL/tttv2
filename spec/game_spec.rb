# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { double("player", name: "Player1", marker: "X") }
  let(:player2) { double("player", name: "Player2", marker: "O") }
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

  describe "play_game" do
    subject(:game_play) { described_class.new(board: board_double, player1: player1, player2: player2) }
    context "when game is over" do
      it "calls game_over only once" do
        allow(board_double).to receive(:game_over?).and_return(true)
        allow(game_play).to receive_messages(play_one_round: nil, introduction: nil, final_message: nil, show_board: nil)
        expect(board_double).to receive(:game_over?).once
        game_play.play_game
      end
    end

    context "when two rounds are played before game over" do
      let(:display) { double("display") }
      it "calls game_over? three times before exiting" do
        allow(board_double).to receive(:game_over?).and_return(false, false, true)
        allow(game_play).to receive_messages(play_one_round: nil, introduction: nil, final_message: nil, show_board: nil)
        expect(board_double).to receive(:game_over?).exactly(3).times
        game_play.play_game
      end
    end

    context "when two rounds are played" do
      xit "alternates players" do

      end
    end
  end




end