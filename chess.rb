class Board
  def initialize
    @board = []
    @pieces = starting_pieces
    update_board
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

  def testknight
    p @pieces[:white][1]
    p calculate_wN_moves(@pieces[:white][1], @pieces)
    p @pieces[:white][6]
    p calculate_wN_moves(@pieces[:white][6], @pieces)
    p @pieces[:black][9]
    p calculate_bN_moves(@pieces[:black][9], @pieces)
    p @pieces[:black][14]
    p calculate_bN_moves(@pieces[:black][14], @pieces)
  end

  def testbishop
    p "square 35 white"
    p calculate_wB_moves(['',35],@pieces)
    p "square 36 white"
    p calculate_wB_moves(['',36],@pieces)
    p "square 35 black"
    p calculate_bB_moves(['',35],@pieces)
    p "square 36 black"
    p calculate_bB_moves(['',36],@pieces)
    p "square 23 white"
    p calculate_wB_moves(['',23],@pieces)
    p "square 23 black"
    p calculate_bB_moves(['',23],@pieces)
  end

  def testrook
    p "square 35 white"
    p calculate_wR_moves(['',35],@pieces)
    p "square 36 white"
    p calculate_wR_moves(['',36],@pieces)
    p "square 35 black"
    p calculate_bR_moves(['',35],@pieces)
    p "square 36 black"
    p calculate_bR_moves(['',36],@pieces)
    p "square 23 white"
    p calculate_wR_moves(['',23],@pieces)
    p "square 23 black"
    p calculate_bR_moves(['',23],@pieces)
  end

  def testrow
    p in_row?(1,['',3])
    p in_row?(2,['',9])
    p in_row?(3,['',21])
    p in_row?(4,['',28])
    p in_row?(5,['',38])
    p in_row?(6,['',41])
    p in_row?(7,['',54])
    p in_row?(8,['',63])
  end

  def testcol
    p in_column?(1,['',8])
    p in_column?(2,['',9])
    p in_column?(3,['',34])
    p in_column?(4,['',35])
    p in_column?(5,['',20])
    p in_column?(6,['',45])
    p in_column?(7,['',54])
    p in_column?(8,['',63])
  end

  private

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

  def in_column?(col, square)
    square % 8 + 1 == col
  end

  def in_row?(row, square)
    square >= (row - 1) * 8 && square < row * 8
  end

  def add_single_square?(square, row, col, offset, color)
    if !in_row?(row, square) &&
       !in_column?(col, square) &&
       (!@black_squares.include?(square + offset) &&
        color == "b" ||
        !@white_squares.include?(square + offest) &&
        color == "w")
      @moveable_squares << (square + offset)
    end
  end

  def add_square?(square, row, col, offset)
    if !in_row?(row, square) &&
       !in_column?(col, square)
      if !@black_squares.include?(square + offset) &&
         color == "b"
        @moveable_squares << (square + offset)
        add_square?(square + offset, row, col, offset) unless @white_squares.include?(square + offset)
      elsif !@white_squares.include?(square + offset) &&
            color == "w"
        @moveable_squares << (square + offset)
        add_square?(square + offset, row, col, offset) unless @black_squares.include?(square + offset)
      end
    end
  end

  def get_pawn_moves(piece, color)
    @moveable_squares = []
    add_single_square?(piece[1], 0, 0, (color == 'w')? 8 : -8, color)
    @moveable_squares 
  end

  def calculate_wN_moves(piece, pieces)
    moveable_squares = []
    white_squares = pieces[:white].map {|p| p[1]}
    black_squares = pieces[:black].map {|p| p[1]}
    square = piece[1] - 17
    if !in_row?(1, piece[1]) &&
       !in_row?(2, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 15
    if !in_row?(1, piece[1]) &&
       !in_row?(2, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 10
    if !in_row?(1, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !in_column?(2, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 6
    if !in_row?(1, piece[1]) &&
       !in_column?(7, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 6
    if !in_row?(8, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !in_column?(2, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 10
    if !in_row?(8, piece[1]) &&
       !in_column?(7, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 15
    if !in_row?(7, piece[1]) &&
       !in_row?(8, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 17
    if !in_row?(7, piece[1]) &&
       !in_row?(8, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !white_squares.include?(square)
      moveable_squares << square
    end
    moveable_squares
  end

  def calculate_bN_moves(piece, pieces)
    moveable_squares = []
    white_squares = pieces[:white].map {|p| p[1]}
    black_squares = pieces[:black].map {|p| p[1]}
    square = piece[1] - 17
    if !in_row?(1, piece[1]) &&
       !in_row?(2, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 15
    if !in_row?(1, piece[1]) &&
       !in_row?(2, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 10
    if !in_row?(1, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !in_column?(2, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 6
    if !in_row?(1, piece[1]) &&
       !in_column?(7, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 6
    if !in_row?(8, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !in_column?(2, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 10
    if !in_row?(8, piece[1]) &&
       !in_column?(7, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 15
    if !in_row?(7, piece[1]) &&
       !in_row?(8, piece[1]) &&
       !in_column?(1, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 17
    if !in_row?(7, piece[1]) &&
       !in_row?(8, piece[1]) &&
       !in_column?(8, piece[1]) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    moveable_squares
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
end
