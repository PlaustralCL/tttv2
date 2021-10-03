# frozen_string_literal: true

require_relative "../lib/cell"

# Tests for the Cell class

describe Cell do
  subject(:new_cell) { described_class.new }

  describe "#update_value" do
    context "when cell has default value" do
      it "updates to 'X'" do
        new_cell.update_value("X")
        expect(new_cell.value).to eq("X")
      end
    end
  end

  describe "#update_color" do
    context "when cell has default color" do
      it "updates to red" do
        new_cell.update_color("red")
        expect(new_cell.color).to eq("red")
      end
    end
  end
end