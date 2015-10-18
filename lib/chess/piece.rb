class Piece
  attr_accessor :square, :color, :other_color

  def initialize(square, color)
    @square = square
    @color = color
    @other_color = (@color == :white)? :black : :white
  end

  # SELF LOCATION
  def col(square=@square)
    square % 8 + 1
  end

  def row(square=@square)
    (square - (square % 8)) / 8 + 1
  end

  # BOARD SQUARE CHECKS
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

  # SELF MOVE FUNCTIONS
  def move_n(position=self.square)
    position + 8
  end

  def move_e(position=self.square)
    position + 1
  end

  def move_s(position=self.square)
    position - 8
  end

  def move_w(position=self.square)
    position - 1
  end

  def move_nw(position=self.square)
    position + 7
  end

  def move_ne(position=self.square)
    position + 9
  end

  def move_se(position=self.square)
    position - 7
  end

  def move_sw(position=self.square)
    position - 9
  end

  # NOW WITH EXTRA KNIGHT MOVE
  def move_wnw
    self.square + 6
  end

  def move_nnw
    self.square + 15
  end

  def move_nne
    self.square + 17
  end

  def move_ene
    self.square + 10
  end

  def move_ese
    self.square - 6
  end

  def move_sse
    self.square - 15
  end

  def move_ssw
    self.square - 17
  end

  def move_wsw
    self.square - 10
  end

  # SELF MOVE RECURSION
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
    if unoccupied(target_square, game.pieces) &&
      !hit_edge(move, square)
      ary << target_square
      move_recurse(move, target_square, ary, game)
    end
  end

  def attack_move_recurse(move, square, ary, game)
    target_square = self.send(move, square)
    if occupied_enemy(target_square, game.pieces)
      ary << target_square
    elsif unoccupied(target_square, game.pieces) &&
      !hit_edge(move, square)
      attack_move_recurse(move, target_square, ary, game)
    end
  end
end
