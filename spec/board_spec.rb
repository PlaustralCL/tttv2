# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  let(:cellx) { double("cell", value: "X") }
  let(:cello) { double("cell", value: "O") }
  let(:cellb) { double("cell", value: 1) }

  describe "#initiate" do
    subject(:game_board) { described_class.new }

    context "when initialized with no board" do
      let(:default_array) { [1, 2, 3, 4, 5, 6, 7, 8, 9] }

      it "creates a 9 element array" do
        expect(game_board.gameboard.size).to eq(9)
      end

      it "every array element is a Cell" do
        expect(game_board.gameboard).to all(be_a(Cell))
      end

      it "cell values are 1 - 9" do
        expect(game_board.gameboard.map(&:value)).to eq(default_array)
      end

      it "creates an array with 9 cell doubles" do
        expect(Cell).to receive(:new).exactly(9).times
        described_class.new
      end
    end
  end

  describe "#game_over" do
    context "when game is tied" do
      let(:tied_gameboard) { [cello, cellx, cello, cellx, cellx, cello, cellx, cello, cellx] }
      subject(:full_board) { described_class.new(tied_gameboard) }

      it "returns true" do
        expect(full_board.game_over?).to be true
      end
    end

    context "when game is won" do
      # let(:horz_winner_o) { [cellx, cellx, cellb, cello, cello, cellb, cello, cello, cello] }
      # subject(:horz_board_winner_o) { described_class.new(horz_winner_o) }
      let(:diag_winner_board) { [cellx, cellx, cello, cellb, cello, cellb, cello, cellb, cellb] }
      subject(:diag_winner) { described_class.new(diag_winner_board) }
      it "returns true" do
        expect(diag_winner.game_over?).to be true
      end
    end

    context "when game is not over" do
      subject(:game_board) { described_class.new }
      it "returns false" do
        expect(game_board.game_over?).to be false

      end
    end
  end

  describe "#full_board?" do
    context "when board is full" do
      let(:tied_gameboard) { [cello, cellx, cello, cellx, cellx, cello, cellx, cello, cellx] }
      subject(:full_board) { described_class.new(tied_gameboard) }
      it "returns true" do
        expect(full_board.full_board?).to be true
      end
    end

    context "when board is not full" do
      let(:partial_gameboard) { [cellx, cellb, cellb, cello, cellb, cellb, cellx, cellb, cellb] }
      subject(:partial_board) { described_class.new(partial_gameboard) }
      it "returns false" do
        expect(partial_board.full_board?).to be false
      end
    end
  end

  describe "#horizontal_winner?" do
    context "when three Xs in a row" do
      let(:horz_winner) { [cellx, cello, cello, cello, cellb, cellb, cellx, cellx, cellx] }
      subject(:horz_board_winner) { described_class.new(horz_winner) }
      it "returns true" do
        expect(horz_board_winner.horizontal_winner?).to be true
      end

      it "changes @winner to winning marker" do
        horz_board_winner.horizontal_winner?
        expect(horz_board_winner.winner).to eq("XXX")
      end
    end

    context "when three Os in a row" do
      let(:horz_winner_o) { [cellx, cellx, cellb, cello, cello, cellb, cello, cello, cello] }
      subject(:horz_board_winner_o) { described_class.new(horz_winner_o) }
      it "returns true" do
        expect(horz_board_winner_o.horizontal_winner?).to be true
      end
    end

    context "when not three in a row" do
      let(:no_winner) { [cellx, cellx, cellb, cello, cello, cellb, cello, cellb, cellb] }
      subject(:no_horz_board_winner) { described_class.new(no_winner) }
      it "return false" do
        expect(no_horz_board_winner.horizontal_winner?).to be false
      end

      it "keeps @winner as nil" do
        no_horz_board_winner.horizontal_winner?
        expect(no_horz_board_winner.winner).to be_empty
      end
    end
  end

  describe "#vertial_winner?" do
    context "when three Xs in a row" do
      let(:vert_winner_board) { [cello, cellx, cello, cellb, cellx, cellb, cellb, cellx, cellb] }
      subject(:vert_winner) { described_class.new(vert_winner_board) }
      it "returns true" do
        expect(vert_winner.vertical_winner?).to eq true
      end
    end

    context "when not three in a row" do
      let(:no_winner_board) { [cellx, cellx, cellb, cello, cello, cellb, cello, cellb, cellb] }
      subject(:no_vert_winner) { described_class.new(no_winner_board) }
      it "return false" do
        expect(no_vert_winner.vertical_winner?).to be false
      end
    end
  end

  describe "#diagonal_winner?" do
    context "when three Os in a row" do
      let(:diag_winner_board) { [cellx, cellx, cello, cellb, cello, cellb, cello, cellb, cellb] }
      subject(:diag_winner) { described_class.new(diag_winner_board) }
      it "returns true" do
        expect(diag_winner.diagonal_winner?).to be true
      end
    end

    context "when not three in a row" do
      let(:no_winner_board) { [cellx, cellx, cellb, cello, cello, cellb, cello, cellb, cellb] }
      # let(:no_winner_board) { [cellx, cellx, cello, cellb, cello, cellb, cello, cellb, cellb] }
      subject(:no_diag_winner) { described_class.new(no_winner_board) }
      it "return false" do
        expect(no_diag_winner.diagonal_winner?).to be false
      end
    end
  end

  describe "#update_board" do
    let(:blank_board) { [cellb, cellb, cellb, cellb, cellb, cellb, cellb, cellb, cellb] }
    subject(:game_board) { described_class.new(blank_board) }

    context "when an X is added" do
      let(:add_x) { [1, 2, 3, 4, "X", 6, 7, 8, 9] }

      it "only changes one cell to X" do
        allow(cellb).to receive(:value).and_return(1, 2, 3, 4, "X", 6, 7, 8, 9)
        allow(cellb).to receive(:update_value)
        game_board.update_board(4, "X")
        expect(game_board.gameboard.map(&:value)).to eq(add_x)
      end
    end

    context "when an O is added" do
      let(:add_o) { [1, 2, 3, 4, 5, 6, 7, 8, "O"] }

      it "only changes one cell to O" do
        allow(cellb).to receive(:value).and_return(1, 2, 3, 4, 5, 6, 7, 8, "O")
        allow(cellb).to receive(:update_value)
        game_board.update_board(8, "O")
        expect(game_board.gameboard.map(&:value)).to eq(add_o)

      end
    end
  end

  describe "#available_cells" do
    let(:partial_board) { [cellb, cellb, cellb, cellb, cellb, cellb, cellb, cellb, cellb] }
    subject(:mid_game) { described_class.new(partial_board) }
    context "when some moves are taken" do
      let(:result) { [2, 3, 4, 6, 7, 8] }

      it "returns list of open cells" do
        allow(cellb).to receive(:value).and_return("O", 2, 3, 4, "X", 6, 7, 8, "X")
        expect(mid_game.available_cells).to eq(result)
      end
    end
  end

end

# Look at the spec/15a in the practice repo for example of testing that
# a message is sent.