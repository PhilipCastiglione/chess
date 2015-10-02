require_relative 'piece.rb'

class Bishop < Piece
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

  def moves(game)
    m = []
    move_recurse(:move_nw, self.square, m, game)
    move_recurse(:move_ne, self.square, m, game)
    move_recurse(:move_se, self.square, m, game)
    move_recurse(:move_sw, self.square, m, game)
    m
  end

  def attack_moves(game)
    m = []
    attack_move_recurse(:move_nw, self.square, m, game)
    attack_move_recurse(:move_ne, self.square, m, game)
    attack_move_recurse(:move_se, self.square, m, game)
    attack_move_recurse(:move_sw, self.square, m, game)
    m
  end
end
