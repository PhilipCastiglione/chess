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

  def move_recurse(move, ary, game)
    if unoccupied(move, game.pieces)
      ary < move
      move_recurse(move(move), ary, game)
    end
  end

  def attack_moves_recurse(move, ary, game)
    if enemy_occupied(move, game.pieces)
      ary < move
    elsif unoccupied(move, game.pieces)
      attack_moves_recurse(move(move), game.pieces)
    end
  end

  def moves(game)
    m = []
    move_recurse(move_nw, m, game)
    move_recurse(move_ne, m, game)
    move_recurse(move_se, m, game)
    move_recurse(move_sw, m, game)
    m
  end

  def attack_moves(game)
    m = []
    attack_move_recurse(move_nw, m, game)
    attack_move_recurse(move_ne, m, game)
    attack_move_recurse(move_se, m, game)
    attack_move_recurse(move_sw, m, game)
    m
  end
end
