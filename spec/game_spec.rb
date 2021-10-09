# frozen_string_literal: true

require_relative "../lib/game"

describe Game do
  let(:player1) { double("player1", name: "Player 1", marker: "X") }
  let(:player2) { double("player2", name: "Player 2", marker: "O") }
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
      allow(game_play).to receive_messages(introduction: nil, show_board: nil, final_message: nil)
    end

    context "when game is over" do
      it "calls game_over only once" do
        allow(game_play).to receive_messages(play_one_round: nil)
        allow(board_double).to receive(:game_over?).and_return(true)
        expect(board_double).to receive(:game_over?).once
        game_play.play_game
      end
    end

    context "when two rounds are played before game over" do
      it "calls game_over? three times before exiting" do
        allow(game_play).to receive_messages(play_one_round: nil)
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
      it "breaks the loop" do
        allow(board_double).to receive(:game_over?).and_return(false, false, true)
        allow(game_play).to receive(:play_one_round).and_return("quit")
        expect(game_play).to receive(:play_one_round).once
        game_play.play_game

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
        allow(board_double).to receive(:update_board)
        expect(player1).to receive(:player_turn).once
        game_round.play_one_round(player1)
      end
    end

    context "when it it player 1's turn" do
      it "it calls player_turn for player 1" do
        allow(board_double).to receive(:update_board)
        allow(game_round).to receive(:show_board)
        expect(player2).to receive(:player_turn).once
        game_round.play_one_round(player2)
      end
    end

    context "when the player inputs 'q'" do
      it "returns without updating the board" do
        allow(player1).to receive(:marker).and_return("X")
        allow(player1).to receive(:player_turn).and_return("q")
        expect(board_double).not_to receive(:update_board)
        game_round.play_one_round(player1)

      end
    end

    context "when player inputs a number" do
      it "updates the correct cell with the marker" do
        allow(game_round).to receive(:show_board)
        allow(player1).to receive(:marker).and_return("X")
        allow(player1).to receive(:player_turn).and_return("5")
        expect(board_double).to receive(:update_board).with(5, "X")
        game_round.play_one_round(player1)
      end
    end
  end

  describe "#final_message" do
    subject(:game_final) { described_class.new(board: board_double, player1: player1, player2: player2) }
    context "when the game is a tie" do
      it "shows tie message" do
        tie_phrase = "The game was tied.\n Thanks for playing!\n"
        allow(board_double).to receive(:winner).and_return("")
        expect { game_final.final_message }.to output(tie_phrase).to_stdout
      end
    end

    context "when player 1 wins" do
      it "states player 1 won" do
        player1_phrase = "Player 1 won!\n Thanks for playing!\n"
        allow(board_double).to receive(:winner).and_return("XXX")
        expect { game_final.final_message }.to output(player1_phrase).to_stdout
      end
    end

    context "when player 2 wins" do
      it "states player 2 won" do
        player2_phrase = "Player 2 won!\n Thanks for playing!\n"
        allow(board_double).to receive(:winner).and_return("YYY")
        expect { game_final.final_message }.to output(player2_phrase).to_stdout

      end
    end
  end




end