module ValidateMoves
  def check_valid_move(pieces_by_piece, piece, square, color, checked)
    return false unless pieces_by_piece[color].keys.include?(piece)
    if checked[color]
      get_moves(piece, color).include?(square) && check_defended?(pieces_by_piece, piece, square, color)
    else
      get_moves(pieces_by_piece, piece, color).include?(square)
    end
  end

  def get_moves(pieces_by_piece, piece, color)
    case piece[1]
    when 'P'
      get_pawn_moves(pieces_by_piece[color][piece], color)
    when 'N'
      get_knight_moves(pieces_by_piece[color][piece], color)
    when 'B'
      get_bishop_moves(pieces_by_piece[color][piece], color)
    when 'R'
      get_rook_moves(pieces_by_piece[color][piece], color)
    when 'Q'
      get_queen_moves(pieces_by_piece[color][piece], color)
    when 'K'
      get_king_moves(pieces_by_piece[color][piece], color)
    end
  end


  def reset_check(check_state)
    check_state = {white: false, black: false}
  end

  def set_check(color, pieces_by_piece, check_state)
    other_color = (color == :white)? :black : :white
    pieces_by_piece[color].each do |p|
      if get_moves(piece, color).include?(pieces_by_piece[other_color]["#{other_color[0]}K1".to_sym])
        check_state[other_color] = true 
      end
    end
  end

  def check_defended?(pieces_by_piece, piece, square, color)

  end
e
  def in_column?(col, square)
    square % 8 + 1 == col
  end

  def in_row?(row, square)
    square >= (row - 1) * 8 && square < row * 8
  end

  def add_king_square?(pieces_by_square, square, row, col, offset, color, moveable_square)
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       !pieces_by_square[color].include?(target_square)
      moveable_squares << target_square
    end
  end

  def add_pawn_move_square?(pieces_by_square, square, offset, color, moveable_squares)
    target_square = square + offset
    other_color = (color == :white)? :black : :white
    if !pieces_by_square[:white].include?(target_square) &&
       !pieces_by_square[:black].include?(target_square)
      moveable_squares << target_square
    end
    target_square = square + offset * 2
    if (in_row?(2, square) &&
       color == :white) ||
       (in_row?(7, square) &&
       color == :black) &&
       !pieces_by_square[:white].include?(target_square) &&
       !pieces_by_square[:black].include?(target_square)
      moveable_squares << target_square
    end
  end

  def add_pawn_attack_square?(pieces_by_square, square, col, offset, color, en_passant_squares, moveable_squares)
    other_color = (color == :white)? :black : :white
    target_square = square + offset
    if !in_column?(col, square) &&
       (pieces_by_square[other_color].include?(target_square) ||
        en_passant_squares[other_color].include?(target_square))
      moveable_squares << target_square
    end
  end

  def add_square?(pieces_by_square, square, row, col, offset, color, moveable_squares)
    other_color = (color == :white)? :black : :white
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       !pieces_by_square[color].include?(target_square)
      moveable_squares << target_square
      add_square?(target_square, row, col, offset, color) unless pieces_by_square[other_color].include?(target_square)
    end
  end

  def add_knight_square?(pieces_by_square, square, row1, row2, col1, col2, offset, color, moveable_squares)
    target_square = square + offset
    if !in_row?(row1, square) &&
       !in_row?(row2, square) &&
       !in_column?(col1, square) &&
       !in_column?(col2, square) &&
       !pieces_by_square[color].include?(target_square)
      moveable_squares << target_square
    end
  end

  def get_pawn_moves(pieces_by_square, square, color)
    moveable_squares = []
    p_offset = (color == :white)? 8 : -8
    add_pawn_move_square?(pieces_by_square, square, p_offset, color, moveable_squares)
    p_offset = (color == :white)? 7 : -9
    add_pawn_attack_square?(pieces_by_square, square, 1, p_offset, color, moveable_squares)
    p_offset = (color == :white)? 9 : -7
    add_pawn_attack_square?(pieces_by_square, square, 8, p_offset, color, moveable_squares)
    moveable_squares 
  end

  def get_knight_moves(pieces_by_square, square, color)
    moveable_squares = []
    add_knight_square?(pieces_by_square, square, 1, 2, 1, 0, -17 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 1, 2, 8, 0, -15 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 1, 0, 1, 2, -10 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 1, 0, 7, 8, -6 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 8, 0, 1, 2, 6 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 8, 0, 7, 8, 10 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 7, 8, 1, 0, 15 , color, moveable_squares)
    add_knight_square?(pieces_by_square, square, 7, 8, 8, 0, 17 , color, moveable_squares)
    moveable_squares
  end

  def get_bishop_moves(pieces_by_square, square, color)
    moveable_squares = []
    add_square?(pieces_by_square, square, 1, 1, -9, color, moveable_squares)
    add_square?(pieces_by_square, square, 1, 8, -7, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 1, 7, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 8, 9, color, moveable_squares)
    moveable_squares
  end

  def get_rook_moves(pieces_by_square, square, color)
    moveable_squares = []
    add_square?(pieces_by_square, square, 1, 0, -8, color, moveable_squares)
    add_square?(pieces_by_square, square, 0, 1, -1, color, moveable_squares)
    add_square?(pieces_by_square, square, 0, 8, 1, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 0, 8, color, moveable_squares)
    moveable_squares
  end

  def get_queen_moves(pieces_by_square, square, color)
    moveable_squares = []
    add_square?(pieces_by_square, square, 1, 1, -9, color, moveable_squares)
    add_square?(pieces_by_square, square, 1, 0, -8, color, moveable_squares)
    add_square?(pieces_by_square, square, 1, 8, -7, color, moveable_squares)
    add_square?(pieces_by_square, square, 0, 1, -1, color, moveable_squares)
    add_square?(pieces_by_square, square, 0, 8, 1, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 1, 7, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 0, 8, color, moveable_squares)
    add_square?(pieces_by_square, square, 8, 8, 9, color, moveable_squares)
    moveable_squares
  end

  def get_king_moves(pieces_by_square, square, color)
    moveable_squares = []
    add_king_square?(pieces_by_square, square, 1, 1, -9, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 1, 0, -8, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 1, 8, -7, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 0, 1, -1, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 0, 8, 1, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 8, 1, 7, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 8, 0, 8, color, moveable_squares)
    add_king_square?(pieces_by_square, square, 8, 8, 9, color, moveable_squares)
    moveable_squares
  end
end

