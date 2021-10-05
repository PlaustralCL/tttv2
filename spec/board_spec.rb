# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  let(:cellx) { double("cell", value: "X") }
  let(:cello) { double("cell", value: "O") }
  let(:cellb) { double("cell", value: "") }

  describe "#initiate" do
    subject(:game_board) { described_class.new }
    let(:cell_double) { double(Cell) }
    context "when initialized with no board" do
      it "creates a 9 element array" do
        expect(game_board.gameboard.size).to eq(9)
      end

      it "array element is a Cell" do
        expect(game_board.gameboard).to all(be_a(Cell))
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




end