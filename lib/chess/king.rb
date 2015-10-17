require_relative 'piece.rb'

class King < Piece
  def moves(game)
    m = []
    if unoccupied(move_n, game.pieces) &&
      self.row != 8
      m << move_n
    end
    if unoccupied(move_ne, game.pieces) &&
      self.row != 8 &&
      self.col != 8
      m << move_ne
    end
    if unoccupied(move_e, game.pieces) &&
      self.col != 8
      m << move_e
    end
    if unoccupied(move_se, game.pieces) &&
      self.row != 1 &&
      self.col != 8
      m << move_se
    end
    if unoccupied(move_s, game.pieces) &&
      self.row != 1
      m << move_s
    end
    if unoccupied(move_sw, game.pieces) &&
      self.row != 1 &&
      self.col != 1
      m << move_sw
    end
    if unoccupied(move_w, game.pieces) &&
      self.col != 1
      m << move_w
    end
    if unoccupied(move_nw, game.pieces) &&
      self.row != 8 &&
      self.col != 1
      m << move_nw
    end
    m
  end

  def attack_moves(game)
    m = []
    if occupied_enemy(move_n, game.pieces) &&
      self.row != 8
      m << move_n
    end
    if occupied_enemy(move_ne, game.pieces) &&
      self.row != 8 &&
      self.col != 8
      m << move_ne
    end
    if occupied_enemy(move_e, game.pieces) &&
      self.col != 8
      m << move_e
    end
    if occupied_enemy(move_se, game.pieces) &&
      self.row != 1 &&
      self.col != 8
      m << move_se
    end
    if occupied_enemy(move_s, game.pieces) &&
      self.row != 1
      m << move_s
    end
    if occupied_enemy(move_sw, game.pieces) &&
      self.row != 1 &&
      self.col != 1
      m << move_sw
    end
    if occupied_enemy(move_w, game.pieces) &&
      self.col != 1
      m << move_w
    end
    if occupied_enemy(move_nw, game.pieces) &&
      self.row != 8 &&
      self.col != 1
      m << move_nw
    end
    m
  end
end
