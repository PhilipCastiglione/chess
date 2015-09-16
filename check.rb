module Check
  def check_valid_move(pieces_by_piece, piece, square, color, checked)
    return false unless pieces_by_piece[color].keys.include?(piece)
    if checked[color]
      get_moves(piece, color).include?(square) && check_defended?(piece, square, color)
    else
      get_moves(piece, color).include?(square)
    end
  end
end
