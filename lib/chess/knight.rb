require_relative 'piece.rb'

class Knight < Piece
  def moves(game)
    m = []
    if unoccupied(move_wnw, game.pieces) &&
      self.col != 1 &&
      self.col != 2 &&
      self.row != 8 &&
      m << move_wnw
    end
    if unoccupied(move_nnw, game.pieces) &&
      self.col != 1 &&
      self.row != 7 &&
      self.row != 8 &&
      m << move_nnw
    end
    if unoccupied(move_nne, game.pieces) &&
      self.col != 8 &&
      self.row != 7 &&
      self.row != 8 &&
      m << move_nne
    end
    if unoccupied(move_ene, game.pieces) &&
      self.col != 7 &&
      self.col != 8 &&
      self.row != 8 &&
      m << move_ene
    end
    if unoccupied(move_ese, game.pieces) &&
      self.col != 7 &&
      self.col != 8 &&
      self.row != 1 &&
      m << move_ese
    end
    if unoccupied(move_sse, game.pieces) &&
      self.col != 8 &&
      self.row != 1 &&
      self.row != 2 &&
      m << move_sse
    end
    if unoccupied(move_ssw, game.pieces) &&
      self.col != 1 &&
      self.row != 1 &&
      self.row != 2 &&
      m << move_ssw
    end
    if unoccupied(move_wsw, game.pieces) &&
      self.col != 1 &&
      self.col != 2 &&
      self.row != 1 &&
      m << move_wsw
    end
    m
  end

  def attack_moves(game)
    m = []
    if occupied_enemy(move_wnw, game.pieces) &&
      self.col != 1 &&
      self.col != 2 &&
      self.row != 8 &&
      m << move_wnw
    end
    if occupied_enemy(move_nnw, game.pieces) &&
      self.col != 1 &&
      self.row != 7 &&
      self.row != 8 &&
      m << move_nnw
    end
    if occupied_enemy(move_nne, game.pieces) &&
      self.col != 8 &&
      self.row != 7 &&
      self.row != 8 &&
      m << move_nne
    end
    if occupied_enemy(move_ene, game.pieces) &&
      self.col != 7 &&
      self.col != 8 &&
      self.row != 8 &&
      m << move_ene
    end
    if occupied_enemy(move_ese, game.pieces) &&
      self.col != 7 &&
      self.col != 8 &&
      self.row != 1 &&
      m << move_ese
    end
    if occupied_enemy(move_sse, game.pieces) &&
      self.col != 8 &&
      self.row != 1 &&
      self.row != 2 &&
      m << move_sse
    end
    if occupied_enemy(move_ssw, game.pieces) &&
      self.col != 1 &&
      self.row != 1 &&
      self.row != 2 &&
      m << move_ssw
    end
    if occupied_enemy(move_wsw, game.pieces) &&
      self.col != 1 &&
      self.col != 2 &&
      self.row != 1 &&
      m << move_wsw
    end
    m
  end
end
