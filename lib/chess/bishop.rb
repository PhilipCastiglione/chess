require_relative 'piece.rb'

class Bishop < Piece
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
