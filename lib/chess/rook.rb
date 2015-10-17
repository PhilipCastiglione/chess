require_relative 'piece.rb'

class Rook < Piece
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

  def moves(game)
    m = []
    move_recurse(:move_n, self.square, m, game)
    move_recurse(:move_e, self.square, m, game)
    move_recurse(:move_s, self.square, m, game)
    move_recurse(:move_w, self.square, m, game)
    m
  end

  def attack_moves(game)
    m = []
    attack_move_recurse(:move_n, self.square, m, game)
    attack_move_recurse(:move_e, self.square, m, game)
    attack_move_recurse(:move_s, self.square, m, game)
    attack_move_recurse(:move_w, self.square, m, game)
    m
  end
end
