require_relative 'piece.rb'

class Pawn < Piece
  def pawn_move_square
    self.square + ((self.color == :white)? 8 : -8)
  end

  def pawn_double_move_square
    self.square + ((self.color == :white)? 16 : -16)
  end

  def west_attack_square
    self.square + ((self.color == :white)? 7 : -9)
  end

  def east_attack_square
    self.square + ((self.color == :white)? 9 : -7)
  end

  def moves(game_state)
    available_moves = []

  end
end

