require_relative 'piece.rb'

class Pawn < Piece
  def move
    self.square + ((self.color == :white)? 8 : -8)
  end

  def double_move
    self.square + ((self.color == :white)? 16 : -16)
  end

  def west_attack
    self.square + ((self.color == :white)? 7 : -9)
  end

  def east_attack
    self.square + ((self.color == :white)? 9 : -7)
  end

  def moves(game)
    available_moves = []
    if unoccupied(move, game.pieces)
      available_moves << move
      if unoccupied(double_move, game.pieces)
        available_moves << double_move
      end
    end
   available_moves
  end

  def attack_moves(game)
    available_moves = []
    if (occupied_enemy(west_attack, game.pieces) ||
       game.en_passant[self.other_color].include?(west_attack)) &&
       self.col != 1
        available_moves << west_attack
    end
    if (occupied_enemy(east_attack, game.pieces) ||
       game.en_passant[self.other_color].include?(east_attack)) &&
       self.col != 8
        available_moves << east_attack
    end
    available_moves
  end
end

