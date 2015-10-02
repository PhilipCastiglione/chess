require_relative 'piece.rb'

class Knight < Piece
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

  def moves(game)
    m = []
    if self.col != 1
      if self.row != 1
        if unoccupied(move_ssw, game.pieces) &&
          self.row != 2 &&
          m < move_ssw
        end
        if unoccupied(move_wsw, game.pieces) &&
          self.col != 2 &&
          m < move_wsw
        end
      elsif self.row != 8
        if unoccupied(move_wnw, game.pieces) &&
          self.col != 2 &&
          m < move_wnw
        end
        if unoccupied(move_nnw, game.pieces) &&
          self.row != 7 &&
          m < move_nnw
        end
      end
    elsif self.col != 8
      if self.row != 1
        if unoccupied(move_ese, game.pieces) &&
          self.col != 7 &&
          m < move_ese
        end
        if unoccupied(move_sse, game.pieces) &&
          self.row != 2 &&
          m < move_sse
        end
      elsif self.row != 8
        if unoccupied(move_nne, game.pieces) &&
          self.row != 7 &&
          m < move_nne
        end
        if unoccupied(move_ene, game.pieces) &&
          self.col != 7 &&
          m < move_ene
        end
      end
    end
    m
  end

  def attack_moves(game)
    m = []
    if self.col != 1
      if self.row != 1
        if occupied_enemy(move_ssw, game.pieces) &&
          self.row != 2 &&
          m < move_ssw
        end
        if occupied_enemy(move_wsw, game.pieces) &&
          self.col != 2 &&
          m < move_wsw
        end
      elsif self.row != 8
        if occupied_enemy(move_wnw, game.pieces) &&
          self.col != 2 &&
          m < move_wnw
        end
        if occupied_enemy(move_nnw, game.pieces) &&
          self.row != 7 &&
          m < move_nnw
        end
      end
    elsif self.col != 8
      if self.row != 1
        if occupied_enemy(move_ese, game.pieces) &&
          self.col != 7 &&
          m < move_ese
        end
        if occupied_enemy(move_sse, game.pieces) &&
          self.row != 2 &&
          m < move_sse
        end
      elsif self.row != 8
        if occupied_enemy(move_nne, game.pieces) &&
          self.row != 7 &&
          m < move_nne
        end
        if occupied_enemy(move_ene, game.pieces) &&
          self.col != 7 &&
          m < move_ene
        end
      end
    end
    m
  end
end

