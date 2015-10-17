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

  def hit_edge(move, target_square)
    this_row = self.row(target_square)
    next_row = self.row(self.send(move, target_square))
    this_col = self.col(target_square)
    next_col = self.col(self.send(move, target_square))
    (this_row == 1 &&
     next_row == 8) ||
    (this_row == 8 &&
     next_row == 1) ||
    (this_col == 1 &&
     next_col == 8) ||
    (this_col == 8 &&
     next_col == 1)
  end

  def move_recurse(move, square, ary, game)
    target_square = self.send(move, square)
    if unoccupied(target_square, game.pieces)
      ary << target_square
      move_recurse(move, target_square, ary, game) unless hit_edge(move, target_square)
    end
  end

  def attack_move_recurse(move, square, ary, game)
    target_square = self.send(move, square)
    if occupied_enemy(target_square, game.pieces)
      ary << target_square
    elsif unoccupied(target_square, game.pieces)
      attack_move_recurse(move, target_square, ary, game) unless hit_edge(move, target_square)
    end
  end
end

