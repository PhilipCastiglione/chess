require_relative 'chess/gosu.rb'
require_relative 'chess/pawn.rb'

class Game
  attr_accessor :pieces, :en_passant

  def initialize
    @pieces = {white: [], black: []}
    @active_player = nil
    @next_queen = {white: 2, black: 2}
    @checked = {white: false, black: false}
    @castle = {white: [:wR1, :wR2], black: [:bR1, :bR2]}
    @en_passant = {white: [], black: []}
  end
end

g = Game.new
p = Pawn.new(9, :white)
p p.col
p p.row
p p.moves(g)
p p.attack_moves(g)

