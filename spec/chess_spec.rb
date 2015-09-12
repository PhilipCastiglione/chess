require 'spec_helper'

describe Chess do
  before :each do
    @chess = Chess.new
  end

  describe "#get_pawn_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_pawn_moves, @chess.pieces_by_piece[:white][:wP1], :white)).to eq([16, 24])
    end
  end

  describe "#get_knight_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_knight_moves, @chess.pieces_by_piece[:white][:wN1], :white)).to eq([16, 18])
    end
  end

  describe "#get_bishop_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_bishop_moves, @chess.pieces_by_piece[:white][:wB1], :white)).to eq([])
    end
  end

  describe "#get_rook_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_rook_moves, @chess.pieces_by_piece[:white][:wR1], :white)).to eq([])
    end
  end

  describe "#get_queen_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_queen_moves, @chess.pieces_by_piece[:white][:wQ1], :white)).to eq([])
    end
  end

  describe "#get_king_moves" do
    it "returns the correct moves" do
      expect(@chess.send(:get_king_moves, @chess.pieces_by_piece[:white][:wK1], :white)).to eq([])
    end
  end
end

