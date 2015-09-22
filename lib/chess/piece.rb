class Piece
  attr_accessor :square, :color

  def initialize(square, color)
    @square = square
    @color = color
  end

  def col
    @square % 8 + 1
  end

  def row
    (@square - (@square % 8)) / 8 + 1
  end
end

