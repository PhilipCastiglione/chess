require_relative 'piece.rb'

class Queen < Piece
  def moves(game)
    m = []
    move_recurse(:move_n, self.square, m, game)
    move_recurse(:move_ne, self.square, m, game)
    move_recurse(:move_e, self.square, m, game)
    move_recurse(:move_se, self.square, m, game)
    move_recurse(:move_s, self.square, m, game)
    move_recurse(:move_sw, self.square, m, game)
    move_recurse(:move_w, self.square, m, game)
    move_recurse(:move_nw, self.square, m, game)
    m
  end

  def attack_moves(game)
    m = []
    attack_move_recurse(:move_n, self.square, m, game)
    attack_move_recurse(:move_ne, self.square, m, game)
    attack_move_recurse(:move_e, self.square, m, game)
    attack_move_recurse(:move_se, self.square, m, game)
    attack_move_recurse(:move_s, self.square, m, game)
    attack_move_recurse(:move_sw, self.square, m, game)
    attack_move_recurse(:move_w, self.square, m, game)
    attack_move_recurse(:move_nw, self.square, m, game)
    m
  end
end
