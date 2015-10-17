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
        expect(@pawn_w1.moves(@game).sort).to eq([23, 31].sort)
        expect(@pawn_w2.moves(@game).sort).to eq([38].sort)
        expect(@pawn_w3.moves(@game).sort).to eq([58].sort)
        expect(@pawn_b1.moves(@game).sort).to eq([5].sort)
        expect(@pawn_b2.moves(@game).sort).to eq([25].sort)
        expect(@pawn_b3.moves(@game).sort).to eq([40, 32].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@pawn_w1.attack_moves(@game).sort).to eq([].sort)
        expect(@pawn_w2.attack_moves(@game).sort).to eq([37].sort)
        expect(@pawn_w3.attack_moves(@game).sort).to eq([].sort)
        expect(@pawn_b1.attack_moves(@game).sort).to eq([].sort)
        expect(@pawn_b2.attack_moves(@game).sort).to eq([26].sort)
        expect(@pawn_b3.attack_moves(@game).sort).to eq([].sort)
      end
    end
  end

  context Rook do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@rook_w.moves(@game).sort).to eq([0, 9, 10, 11, 16, 24, 32, 40].sort)
        expect(@rook_b.moves(@game).sort).to eq([63, 52, 53, 54, 47, 39, 31, 23].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@rook_w.attack_moves(@game).sort).to eq([48].sort)
        expect(@rook_b.attack_moves(@game).sort).to eq([15].sort)
      end
    end
  end

  context Knight do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@knight_w.moves(@game).sort).to eq([32, 25, 27, 36, 52, 59, 57].sort)
        expect(@knight_b.moves(@game).sort).to eq([36, 27, 11, 4, 6, 31, 38].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@knight_w.attack_moves(@game).sort).to eq([48].sort)
        expect(@knight_b.attack_moves(@game).sort).to eq([15].sort)
      end
    end
  end

  context Bishop do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@bishop_w.moves(@game).sort).to eq([17, 19, 35, 44, 53, 62].sort)
        expect(@bishop_b.moves(@game).sort).to eq([44, 46, 28, 19, 10, 1].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@bishop_w.attack_moves(@game).sort).to eq([33].sort)
        expect(@bishop_b.attack_moves(@game).sort).to eq([30].sort)
      end
    end
  end

  context Queen do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@queen_w.moves(@game).sort).to eq([22, 38, 47, 20, 11, 2, 28, 27, 36, 43].sort)
        expect(@queen_b.moves(@game).sort).to eq([35, 36, 27, 20, 43, 52, 61, 41, 25, 16].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@queen_w.attack_moves(@game).sort).to eq([37, 21].sort)
        expect(@queen_b.attack_moves(@game).sort).to eq([42, 26].sort)
      end
    end
  end

  context King do
    describe "#moves" do
      it "returns the valid moves" do
        expect(@king_w.moves(@game).sort).to eq([3, 4, 5, 11, 19, 20].sort)
        expect(@king_b.moves(@game).sort).to eq([58, 59, 60, 52, 44, 43].sort)
      end
    end
    describe "#attack_moves" do
      it "returns the valid attack moves" do
        expect(@king_w.attack_moves(@game).sort).to eq([13, 21].sort)
        expect(@king_b.attack_moves(@game).sort).to eq([50, 42].sort)
      end
    end
  end
end
