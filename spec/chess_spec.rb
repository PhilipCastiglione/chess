require 'spec_helper'

describe Game do

  before :each do
    @game = Game.new
    @pawn = Pawn.new(36, :white)
    @game.pieces[:white] << @pawn
    @knight = Knight.new(41, :white)
    @game.pieces[:white] << @knight
    @bishop = Bishop.new(13, :black)
    @game.pieces[:black] << @bishop
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

