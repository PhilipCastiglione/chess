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

  describe "Pawn" do

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
end

