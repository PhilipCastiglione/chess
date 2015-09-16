module Check
  def check_valid_move(pieces_by_piece, piece, square, color, checked)
    return false unless pieces_by_piece[color].keys.include?(piece)
    if checked[color]
      get_moves(piece, color).include?(square) && check_defended?(pieces_by_piece, piece, square, color)
    else
      get_moves(piece, color).include?(square)
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
end
