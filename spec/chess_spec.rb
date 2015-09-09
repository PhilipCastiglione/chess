require 'spec_helper'

describe Chess do
  before :each do
    @chess = Chess.new
  end

  describe "#get_pawn_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_pawn_moves, @chess.pieces[:white][8], 'w')).to eq([16])
    end
  end

  describe "#get_knight_moves" do

  end

  describe "#get_bishop_moves" do

  end

  describe "#get_rook_moves" do

  end

  describe "#get_queen_moves" do

  end

  describe "#get_king_moves" do

  end
end

