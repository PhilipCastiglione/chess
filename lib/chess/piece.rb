class Piece
  attr_accessor :square, :color, :other_color

  def initialize(square, color)
    @square = square
    @color = color
    @other_color = (@color == :white)? :black : :white
  end

  def col(square=@square)
    square % 8 + 1
  end

  def row(square=@square)
    (square - (square % 8)) / 8 + 1
  end
  
  def occupied_friendly(square, pieces)
    pieces[@color].map {|p| p.square}.include?(square)
  end

  def occupied_enemy(square, pieces)
    pieces[@other_color].map {|p| p.square}.include?(square)
  end

  def unoccupied(square, pieces)
    !self.occupied_friendly(square, pieces) &&
    !self.occupied_enemy(square, pieces) &&
    square >= 0 &&
    square <= 63
  end
end

