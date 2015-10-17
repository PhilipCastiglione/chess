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
        expect(@pawn_w1.moves(@game)).to eq([23, 31])
        expect(@pawn_w2.moves(@game)).to eq([38])
        expect(@pawn_w3.moves(@game)).to eq([58])
        expect(@pawn_b1.moves(@game)).to eq([5])
        expect(@pawn_b2.moves(@game)).to eq([25])
        expect(@pawn_b3.moves(@game)).to eq([40, 32])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@pawn_w1.attack_moves(@game)).to eq([])
        expect(@pawn_w2.attack_moves(@game)).to eq([37])
        expect(@pawn_w3.attack_moves(@game)).to eq([])
        expect(@pawn_b1.attack_moves(@game)).to eq([26])
        expect(@pawn_b2.attack_moves(@game)).to eq([])
        expect(@pawn_b3.attack_moves(@game)).to eq([])
      end
    end
  end

  context Rook do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@rook_w.moves(@game)).to eq([0, 9, 10, 11, 16, 24, 32, 40])
        expect(@rook_b.moves(@game)).to eq([63, 52, 53, 54, 47, 39, 31, 23])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@rook_w.attack_moves(@game)).to eq([48])
        expect(@rook_b.attack_moves(@game)).to eq([15])
      end
    end
  end

  context Knight do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@knight_w.moves(@game)).to eq([32, 25, 27, 36, 52, 59, 57])
        expect(@knight_b.moves(@game)).to eq([36, 27, 11, 4, 6, 31, 38])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@knight_w.attack_moves(@game)).to eq([48])
        expect(@knight_b.attack_moves(@game)).to eq([15])
      end
    end
  end

  context Bishop do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@bishop_w.moves(@game)).to eq([17, 19, 35, 44, 53, 62])
        expect(@bishop_b.moves(@game)).to eq([44, 46, 28, 19, 10, 1])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@bishop_w.attack_moves(@game)).to eq([33])
        expect(@bishop_b.attack_moves(@game)).to eq([30])
      end
    end
  end

  context Queen do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@queen_w.moves(@game)).to eq([22, 38, 47, 20, 11, 2, 28, 27, 36, 43])
        expect(@queen_b.moves(@game)).to eq([35, 36, 27, 20, 43, 52, 61, 41, 25, 16])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@queen_w.attack_moves(@game)).to eq([])
        expect(@queen_b.attack_moves(@game)).to eq([])
      end
    end
  end

  context King do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@king_w.moves(@game)).to eq([3, 4, 5, 11, 19, 20])
        expect(@king_b.moves(@game)).to eq([58, 59, 60, 52, 44, 43])
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@king_w.attack_moves(@game)).to eq([13, 21])
        expect(@king_b.attack_moves(@game)).to eq([50, 42])
      end
    end
  end
end
