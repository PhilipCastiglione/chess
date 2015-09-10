class Chess
  attr_reader :pieces

  def initialize
    @board = []
    @pieces = starting_pieces
    store_pieces
    update_board
    start_game
  end

  def to_s
    start = 64
    8.times do
      p "#{start / 8}|#{@board.slice(start - 8, 8).map { |s| (s)? s : '  ' }.join("|")}|"
      start -= 8
    end
    p " | a| b| c| d| e| f| g| h|"
    return nil
  end

  def starting_pieces
    {white: [['wR', 0], ['wN', 1], ['wB', 2], ['wQ', 3], ['wK', 4], ['wB', 5], ['wN', 6], ['wR', 7], ['wP', 8], ['wP', 9], ['wP', 10], ['wP', 11], ['wP', 12], ['wP', 13], ['wP', 14], ['wP', 15]], black: [['bP', 48], ['bP', 49], ['bP', 50], ['bP', 51], ['bP', 52], ['bP', 53], ['bP', 54], ['bP', 55], ['bR', 56], ['bN', 57], ['bB', 58], ['bQ', 59], ['bK', 60], ['bB', 61], ['bN', 62], ['bR', 63]]}
  end

  def update_board
    @board = [nil]*64
    @pieces[:white].each do |p|
      @board[p[1]] = p[0]
    end
    @pieces[:black].each do |p|
      @board[p[1]] = p[0]
    end
  end

  def store_pieces
    @white_squares = @pieces[:white].map {|p| p[1]}
    @black_squares = @pieces[:black].map {|p| p[1]}
  end

  def in_column?(col, square)
    square % 8 + 1 == col
  end

  def in_row?(row, square)
    square >= (row - 1) * 8 && square < row * 8
  end

  def add_single_square?(square, row, col, offset, color)
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       (!@black_squares.include?(target_square) &&
        color == "b" ||
        !@white_squares.include?(target_square) &&
        color == "w")
      @moveable_squares << target_square
    end
  end

  def add_square?(square, row, col, offset, color)
    target_square = square + offset
    if !in_row?(row, square) &&
       !in_column?(col, square)
      if !@black_squares.include?(target_square) &&
         color == "b"
        @moveable_squares << target_square
        add_square?(target_square, row, col, offset, color) unless @white_squares.include?(target_square)
      elsif !@white_squares.include?(target_square) &&
            color == "w"
        @moveable_squares << target_square
        add_square?(target_square, row, col, offset, color) unless @black_squares.include?(target_square)
      end
    end
  end

  def add_knight_square?(square, row1, row2, col1, col2, offset, color)
    target_square = square + offset
    if !in_row?(row1, square) &&
       !in_row?(row2, square) &&
       !in_column?(col1, square) &&
       !in_column?(col2, square) &&
       (!@black_squares.include?(target_square) &&
        color == "b" ||
        !@white_squares.include?(target_square) &&
        color == "w")
      @moveable_squares << target_square
    end
  end

  def get_pawn_moves(piece, color)
    @moveable_squares = []
    add_single_square?(piece[1], 0, 0, (color == 'w')? 8 : -8, color)
    @moveable_squares 
  end

  def get_knight_moves(piece, color)
    @moveable_squares = []
    add_knight_square?(piece[1], 1, 2, 1, 0, -17 , color)
    add_knight_square?(piece[1], 1, 2, 8, 0, -15 , color)
    add_knight_square?(piece[1], 1, 0, 1, 2, -10 , color)
    add_knight_square?(piece[1], 1, 0, 7, 8, -6 , color)
    add_knight_square?(piece[1], 8, 0, 1, 2, 6 , color)
    add_knight_square?(piece[1], 8, 0, 7, 8, 10 , color)
    add_knight_square?(piece[1], 7, 8, 1, 0, 15 , color)
    add_knight_square?(piece[1], 7, 8, 8, 0, 17 , color)
    @moveable_squares
  end

  def get_bishop_moves(piece, color)
    @moveable_squares = []
    add_square?(piece[1], 1, 1, -9, color)
    add_square?(piece[1], 1, 8, -7, color)
    add_square?(piece[1], 8, 1, 7, color)
    add_square?(piece[1], 8, 8, 9, color)
    @moveable_squares
  end

  def get_rook_moves(piece, color)
    @moveable_squares = []
    add_square?(piece[1], 1, 0, -8, color)
    add_square?(piece[1], 0, 1, -1, color)
    add_square?(piece[1], 0, 8, 1, color)
    add_square?(piece[1], 8, 0, 8, color)
    @moveable_squares
  end

  def get_queen_moves(piece, color)
    @moveable_squares = []
    add_square?(piece[1], 1, 1, -9, color)
    add_square?(piece[1], 1, 0, -8, color)
    add_square?(piece[1], 1, 8, -7, color)
    add_square?(piece[1], 0, 1, -1, color)
    add_square?(piece[1], 0, 8, 1, color)
    add_square?(piece[1], 8, 1, 7, color)
    add_square?(piece[1], 8, 0, 8, color)
    add_square?(piece[1], 8, 8, 9, color)
    @moveable_squares
  end

  def get_king_moves(piece, color)
    @moveable_squares = []
    add_single_square?(piece[1], 1, 1, -9, color)
    add_single_square?(piece[1], 1, 0, -8, color)
    add_single_square?(piece[1], 1, 8, -7, color)
    add_single_square?(piece[1], 0, 1, -1, color)
    add_single_square?(piece[1], 0, 8, 1, color)
    add_single_square?(piece[1], 8, 1, 7, color)
    add_single_square?(piece[1], 8, 0, 8, color)
    add_single_square?(piece[1], 8, 8, 9, color)
    @moveable_squares
  end

  def start_game

  end
end
