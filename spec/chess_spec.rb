require 'spec_helper'

describe Game do

  before :each do
    @game = Game.new

    @pawn_w1 = Pawn.new(15, :white)
    @pawn_w2 = Pawn.new(30, :white)
    @pawn_w3 = Pawn.new(50, :white)
    @rook_w = Rook.new(8, :white)
    @knight_w = Knight.new(42, :white)
    @bishop_w = Bishop.new(26, :white)
    @queen_w = Queen.new(29, :white)
    @king_w = King.new(12, :white)

    @pawn_b1 = Pawn.new(13, :black)
    @pawn_b2 = Pawn.new(33, :black)
    @pawn_b3 = Pawn.new(48, :black)
    @rook_b = Rook.new(55, :black)
    @knight_b = Knight.new(21, :black)
    @bishop_b = Bishop.new(37, :black)
    @queen_b = Queen.new(34, :black)
    @king_b = King.new(51, :black)

    @game.pieces[:white] << @pawn_w1
    @game.pieces[:white] << @pawn_w2
    @game.pieces[:white] << @pawn_w3
    @game.pieces[:white] << @knight_w
    @game.pieces[:white] << @bishop_w
    @game.pieces[:white] << @rook_w
    @game.pieces[:white] << @queen_w
    @game.pieces[:white] << @king_w

    @game.pieces[:black] << @pawn_b1
    @game.pieces[:black] << @pawn_b2
    @game.pieces[:black] << @pawn_b3
    @game.pieces[:black] << @knight_b
    @game.pieces[:black] << @bishop_b
    @game.pieces[:black] << @rook_b
    @game.pieces[:black] << @queen_b
    @game.pieces[:black] << @king_b
  end

  context Pawn do

    describe "#moves" do
      it "returns the valid moves" do
        expect(@pawn.moves(@game)).to eq([44])
      end
    end

    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@pawn.attack_moves(@game)).to eq([])
      end
    end
    
  end

  context Knight do

    describe "#moves" do
      it "returns the valid moves" do
        expect(@knight.moves(@game)).to eq([56, 58, 51, 35, 26, 24])
      end
    end

    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@knight.attack_moves(@game)).to eq([])
      end
    end

  end

  context Bishop do

    describe "#moves" do
      it "returns the valid moves" do
        expect(@bishop.moves(@game)).to eq([20, 27, 34, 22, 31, 6, 4])
      end
    end

    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@bishop.attack_moves(@game)).to eq([41])
      end
    end

  end

end

