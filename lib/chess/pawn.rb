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
    m = []
    if unoccupied(move, game.pieces)
      m << move
      if unoccupied(double_move, game.pieces) &&
        (self.row == 2 && self.color == :white ||
         self.row == 7 && self.color == :black)
        m << double_move
      end
    end
   m
  end

  def attack_moves(game)
    m = []
    if (occupied_enemy(west_attack, game.pieces) ||
       game.en_passant[self.other_color].include?(west_attack)) &&
       self.col != 1
        m << west_attack
    end
    if (occupied_enemy(east_attack, game.pieces) ||
       game.en_passant[self.other_color].include?(east_attack)) &&
       self.col != 8
        m << east_attack
    end
    m
  end
end

