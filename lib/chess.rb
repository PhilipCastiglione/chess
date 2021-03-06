require_relative 'chess/gosu.rb'
require_relative 'chess/pawn.rb'
require_relative 'chess/rook.rb'
require_relative 'chess/knight.rb'
require_relative 'chess/bishop.rb'
require_relative 'chess/queen.rb'
require_relative 'chess/king.rb'

class Game
  attr_accessor :pieces, :en_passant

  def initialize
    @pieces = {white: [], black: []}
    @active_player = nil
    @checked = {white: false, black: false}
    @castle = {white: [:wR1, :wR2], black: [:bR1, :bR2]}
    @en_passant = {white: [], black: []}
  end

  def start_game
    #make stuff display
    wait_for_move
  end

  def wait_for_move
    
  end
  
end
