require 'spec_helper'

describe Chess do
  before :each do
    @chess = Chess.new
  end

  describe "#get_pawn_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_pawn_moves, @chess.pieces[:white][:wP1], 'w')).to eq([16])
    end
  end

  describe "#get_knight_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_knight_moves, @chess.pieces[:white][:wN1], 'w')).to eq([16, 18])
    end
  end

  describe "#get_bishop_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_bishop_moves, @chess.pieces[:white][:wB1], 'w')).to eq([])
    end
  end

  describe "#get_rook_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_rook_moves, @chess.pieces[:white][:wR1], 'w')).to eq([])
    end
  end

  describe "#get_queen_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_queen_moves, @chess.pieces[:white][:wQ1], 'w')).to eq([])
    end
  end

  describe "#get_king_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_king_moves, @chess.pieces[:white][:wK1], 'w')).to eq([])
    end
  end
end

