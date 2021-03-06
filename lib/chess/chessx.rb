require_relative 'gosu.rb'

class Chess
  attr_reader :pieces_by_piece, :pieces_by_square

  def initialize
    @board = []
    @pieces_by_piece = starting_pieces
    @pieces_by_square = pieces_to_squares
    @active_player = nil
    @next_queen = {white: 2, black: 2}
    @checked = {white: false, black: false}
    @castle = {white: [:wR1, :wR2], black: [:bR1, :bR2]}
    reset_en_passant
  end

  def to_s
    update_board
    start = 64
    8.times do
      p "#{start/8}|#{@board.slice(start - 8, 8).map { |s| (s)? s : '___' }.join("|")}|"
      start -= 8
    end
    p " | a | b | c | d | e | f | g | h |"
    return nil
  end

  def starting_pieces
    {white: {wR1: 0, wN1: 1, wB1: 2, wQ1: 3, wK1: 4, wB2: 5, wN2: 6, wR2: 7, wP1: 8, wP2: 9, wP3: 10, wP4: 11, wP5: 12, wP6: 13, wP7: 14, wP8: 15}, black: {bP1: 48, bP2: 49, bP3: 50, bP4: 51, bP5: 52, bP6: 53, bP7: 54, bP8: 55, bR1: 56, bN1: 57, bB1: 58, bQ1: 59, bK1: 60, bB2: 61, bN2: 62, bR2: 63}}
  end

  def pieces_to_squares
    squares = {white: {}, black: {}}
    @pieces_by_piece[:white].each do |p|
      squares[:white][p[1]] = p[0]
    end
    @pieces_by_piece[:black].each do |p|
      squares[:black][p[1]] = p[0]
    end
    squares
  end

  def update_board
    @board = [nil]*64
    @pieces_by_piece[:white].each do |p|
      @board[p[1]] = p[0]
    end
    @pieces_by_piece[:black].each do |p|
      @board[p[1]] = p[0]
    end
  end

  def start_game
    puts "***********************************"
    puts "*****WELCOME TO CHESS AND SHIT*****"
    puts "***********************************"
    puts self
    wait_for_move
  end

  def wait_for_move
    unless win
      if !@active_player || @active_player == :black
        @active_player = :white
      else
        @active_player = :black
      end
      
      color = @active_player
      puts "Player #{color.to_s}: your turn"

      confirm = false
      while !confirm
        move_valid = false
        while !move_valid
          piece = get_player_piece
          user_square = get_player_square
          square = convert_user_square(user_square)
          move_valid = check_valid_move(piece, square, color)
          puts "Move invalid!" unless move_valid
        end
        confirm = get_player_confirmation(piece, user_square)
      end

      remove_taken_piece(square, color)
      reset_check
      reset_en_passant
      set_en_passant(piece, square, color) if piece[1] == 'P'
      @pieces_by_piece[color][piece] = square
      queen_any_pawns(piece, square, color)
      update_castleable_rooks(piece, color)
      move_castled_rook(piece, square)
      @pieces_by_square = pieces_to_squares
      set_check(color)

      puts self
      wait_for_move
    else
      puts "Omg player #{@active_player} totes just won by checkmate!"
    end
  end

  def get_player_piece
    print "What piece would you like to move? (eg. wP1) "
    gets.chomp.to_sym
  end

  def get_player_square
    print "Where should it go? (eg. a3) "
    gets.chomp
  end

  def convert_user_square(user_square)
    ary_square = (user_square[1].to_i - 1) * 8
    case user_square[0].downcase
    when 'a'
      ary_square += 0
    when 'b'
      ary_square += 1
    when 'c'
      ary_square += 2
    when 'd'
      ary_square += 3
    when 'e'
      ary_square += 4
    when 'f'
      ary_square += 5
    when 'g'
      ary_square += 6
    when 'h'
      ary_square += 7
    end
  end

  def get_player_confirmation(piece, square)
    print "Confirm #{piece} to #{square} y/n: "
    gets.chomp == 'y'
  end

  def remove_taken_piece(square, color)
    other_color = (color == :white)? :black : :white
    if @en_passant_squares[other_color].include?(square)
      ep_offset = (color == :white)? -8 : 8
      @pieces_by_piece[other_color].delete(@pieces_by_square[other_color][square + ep_offset])
    elsif @pieces_by_square[other_color].include?(square)
      @pieces_by_piece[other_color].delete(@pieces_by_square[other_color][square])
    end
  end

  def reset_en_passant
    @en_passant_squares = {white: [], black: []}
  end

  def set_en_passant(piece, square, color)
    ep_offset = (color == :white)? 16 : -16
    if @pieces_by_piece[color][piece] + ep_offset == square
      @en_passant_squares[color] << square - ep_offset / 2
    end
  end

  def queen_any_pawns(piece, square, color)
   if (in_row?(8, square) && color == :white) ||
      (in_row?(1, square) && color == :black)
     @pieces_by_piece[color].delete(piece)
     @pieces_by_piece[color]["#{color[0]}Q#{@next_queen[color]}".to_sym] = square
     @next_queen[color] += 1
   end 
  end

  def update_castleable_rooks(piece, color)
    other_color = (color == :white)? :black : :white
    if piece[1] == 'K'
      @castle[color] = []
    elsif piece[1] == 'R'
      @castle[color] -= [piece]
    end
    @castle[color].each {|r| @castle[color].delete(r) unless @pieces_by_piece[color].include?(r) }
    @castle[other_color].each {|r| @castle[other_color].delete(r) unless @pieces_by_piece[other_color].include?(r) }
  end

  def move_castled_rook(piece, square)
    if piece == :wK1
      if square == 2
        @pieces_by_piece[:white][:wR1] = 3
      elsif square == 6
        @pieces_by_piece[:white][:wR2] = 5
      end
    elsif piece == :bK1
      if square == 58
        @pieces_by_piece[:black][:bR1] = 59
      elsif square == 62
        @pieces_by_piece[:black][:bR2] = 61
      end
    end
  end

  def win
    color = (@active_player == :white)? :black : :white
    return false unless @checked[color]
    winning = true
    @pieces_by_piece[color].keys.each do |piece|
      squares = get_moves(piece, color)
      if squares.size > 0
        squares.each do |square|
          winning = false if check_valid_move(piece, square, color)
        end
      end
    end
    return winning
  end

  def check_valid_move(piece, square, color)
    return false unless @pieces_by_piece[color].include?(piece)
    if @checked[color]
      get_moves(piece, color).include?(square) && check_defended?(piece, square, color)
    else
      get_moves(piece, color).include?(square)
    end
  end

  def get_moves(piece, color)
    case piece[1]
    when 'P'
      get_pawn_moves(@pieces_by_piece[color][piece], color)
    when 'N'
      get_knight_moves(@pieces_by_piece[color][piece], color)
    when 'B'
      get_bishop_moves(@pieces_by_piece[color][piece], color)
    when 'R'
      get_rook_moves(@pieces_by_piece[color][piece], color)
    when 'Q'
      get_queen_moves(@pieces_by_piece[color][piece], color)
    when 'K'
      get_king_moves(@pieces_by_piece[color][piece], color)
    end
  end

  def attacked_squares(color)
    @attacked_squares = []
    @pieces_by_piece[color].each do |piece|
      @attacked_squares << get_moves(piece, color)
    end
    @attacked_squares
  end
    
  def reset_check
    @checked = {white: false, black: false}
  end

  def set_check(color)
    other_color = (color == :white)? :black : :white
    @pieces_by_piece[color].each do |piece|
      if get_moves(piece[0], color).include?(@pieces_by_piece[other_color]["#{other_color[0]}K1".to_sym])
        @checked[other_color] = true 
      end
    end
  end

  def check_defended?(piece, square, color)
    other_color = (color == :white)? :black : :white
    real_pieces = Marshal.load(Marshal.dump(@pieces_by_piece))
    real_squares  = Marshal.load(Marshal.dump(@pieces_by_square))
    real_check = Marshal.load(Marshal.dump(@checked))
    piece_to_remove = @pieces_by_square[color][square]
    @pieces_by_piece[color].delete(piece_to_remove) if piece_to_remove
    piece_to_remove = @pieces_by_square[other_color][square]
    @pieces_by_piece[other_color].delete(piece_to_remove) if piece_to_remove
    @pieces_by_piece[color][piece] = square
    @pieces_by_square = pieces_to_squares
    reset_check
    set_check(other_color)
    if @checked[color]
      @pieces_by_piece = real_pieces
      @pieces_by_square = real_squares
      @checked = real_check
      return false
    else
      @pieces_by_piece = real_pieces
      @pieces_by_square = real_squares
      @checked = real_check
      return true
    end
  end

  def in_column?(col, square)
    square % 8 + 1 == col
  end

  def in_row?(row, square)
    square >= (row - 1) * 8 && square < row * 8
  end

  def add_king_square?(square, row, col, offset, color)
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       !@pieces_by_square[color].include?(target_square)
      @moveable_squares << target_square
    end
  end

  def add_castle_squares?(color)
    if color == :white &&
       !@checked[:white]
      if @castle[color].include?(:wR1) &&
         @pieces_by_square[:white].keys - [1, 2, 3] == @pieces_by_square[:white].keys && 
         @pieces_by_square[:black].keys - [1, 2, 3] == @pieces_by_square[:black].keys &&
         !attacked_squares(:black).include?(2) &&
         !attacked_squares(:black).include?(3)
        @moveable_squares << 2
      end
      if @castle[color].include?(:wR2) &&
         @pieces_by_square[:white].keys - [5, 6] == @pieces_by_square[:white].keys && 
         @pieces_by_square[:black].keys - [5, 6] == @pieces_by_square[:black].keys &&
         !attacked_squares(:black).include?(5) &&
         !attacked_squares(:black).include?(6)
        @moveable_squares << 6
      end
    elsif color == :black &&
          !@checked[:black]
      if @castle[color].include?(:bR1) &&
         @pieces_by_square[:white].keys - [57, 58, 59] == @pieces_by_square[:white].keys && 
         @pieces_by_square[:black].keys - [57, 58, 59] == @pieces_by_square[:black].keys &&
         !attacked_squares(:white).include?(58) &&
         !attacked_squares(:white).include?(59)
        @moveable_squares << 58
      end
      if @castle[color].include?(:bR2) &&
         @pieces_by_square[:white].keys - [61, 62] == @pieces_by_square[:white].keys && 
         @pieces_by_square[:black].keys - [61, 62] == @pieces_by_square[:black].keys &&
         !attacked_squares(:white).include?(61) &&
         !attacked_squares(:white).include?(62)
        @moveable_squares << 62
      end
    end
  end

  def add_pawn_move_square?(square, offset, color)
    target_square = square + offset
    other_color = (color == :white)? :black : :white
    if !@pieces_by_square[:white].include?(target_square) &&
       !@pieces_by_square[:black].include?(target_square)
      @moveable_squares << target_square
    end
    target_square += offset
    if (in_row?(2, square) &&
       color == :white ||
       in_row?(7, square) &&
       color == :black) &&
       !@pieces_by_square[:white].include?(target_square) &&
       !@pieces_by_square[:black].include?(target_square)
      @moveable_squares << target_square
    end
  end

  def add_pawn_attack_square?(square, col, offset, color)
    other_color = (color == :white)? :black : :white
    target_square = square + offset
    if !in_column?(col, square) &&
       (@pieces_by_square[other_color].include?(target_square) ||
        @en_passant_squares[other_color].include?(target_square))
      @moveable_squares << target_square
    end
  end

  def add_square?(square, row, col, offset, color)
    other_color = (color == :white)? :black : :white
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       !@pieces_by_square[color].include?(target_square)
      @moveable_squares << target_square
      add_square?(target_square, row, col, offset, color) unless @pieces_by_square[other_color].include?(target_square)
    end
  end

  def add_knight_square?(square, row1, row2, col1, col2, offset, color)
    target_square = square + offset
    if !in_row?(row1, square) &&
       !in_row?(row2, square) &&
       !in_column?(col1, square) &&
       !in_column?(col2, square) &&
       !@pieces_by_square[color].include?(target_square)
      @moveable_squares << target_square
    end
  end

  def get_pawn_moves(square, color)
    @moveable_squares = []
    p_offset = (color == :white)? 8 : -8
    add_pawn_move_square?(square, p_offset, color)
    p_offset = (color == :white)? 7 : -9
    add_pawn_attack_square?(square, 1, p_offset, color)
    p_offset = (color == :white)? 9 : -7
    add_pawn_attack_square?(square, 8, p_offset, color)
    @moveable_squares 
  end

  def get_knight_moves(square, color)
    @moveable_squares = []
    add_knight_square?(square, 1, 2, 1, 0, -17, color)
    add_knight_square?(square, 1, 2, 8, 0, -15, color)
    add_knight_square?(square, 1, 0, 1, 2, -10, color)
    add_knight_square?(square, 1, 0, 7, 8, -6, color)
    add_knight_square?(square, 8, 0, 1, 2, 6, color)
    add_knight_square?(square, 8, 0, 7, 8, 10, color)
    add_knight_square?(square, 7, 8, 1, 0, 15, color)
    add_knight_square?(square, 7, 8, 8, 0, 17, color)
    @moveable_squares
  end

  def get_bishop_moves(square, color)
    @moveable_squares = []
    add_square?(square, 1, 1, -9, color)
    add_square?(square, 1, 8, -7, color)
    add_square?(square, 8, 1, 7, color)
    add_square?(square, 8, 8, 9, color)
    @moveable_squares
  end

  def get_rook_moves(square, color)
    @moveable_squares = []
    add_square?(square, 1, 0, -8, color)
    add_square?(square, 0, 1, -1, color)
    add_square?(square, 0, 8, 1, color)
    add_square?(square, 8, 0, 8, color)
    @moveable_squares
  end

  def get_queen_moves(square, color)
    @moveable_squares = []
    add_square?(square, 1, 1, -9, color)
    add_square?(square, 1, 0, -8, color)
    add_square?(square, 1, 8, -7, color)
    add_square?(square, 0, 1, -1, color)
    add_square?(square, 0, 8, 1, color)
    add_square?(square, 8, 1, 7, color)
    add_square?(square, 8, 0, 8, color)
    add_square?(square, 8, 8, 9, color)
    @moveable_squares
  end

  def get_king_moves(square, color)
    @moveable_squares = []
    add_king_square?(square, 1, 1, -9, color)
    add_king_square?(square, 1, 0, -8, color)
    add_king_square?(square, 1, 8, -7, color)
    add_king_square?(square, 0, 1, -1, color)
    add_king_square?(square, 0, 8, 1, color)
    add_king_square?(square, 8, 1, 7, color)
    add_king_square?(square, 8, 0, 8, color)
    add_king_square?(square, 8, 8, 9, color)
    add_castle_squares?(color)
    @moveable_squares
  end
end

