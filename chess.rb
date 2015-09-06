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

  def calculate_wP_moves(piece, pieces)
    moveable_squares = []
    white_squares = pieces[:white].map {|p| p[1]}
    black_squares = pieces[:black].map {|p| p[1]}
    square = piece[1] + 8
    if !white_squares.include?(square) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] + 7
    if black_squares.include?(square) &&
       !in_column?(1, piece[1])
      moveable_squares << square
    end
    square = piece[1] + 9
    if black_squares.include?(square) &&
       !in_column?(8, piece[1])
      moveable_squares << square
    end
    moveable_squares 
  end

  def calculate_bP_moves(piece, pieces)
    moveable_squares = []
    white_squares = pieces[:white].map {|p| p[1]}
    black_squares = pieces[:black].map {|p| p[1]}
    square = piece[1] - 8
    if !white_squares.include?(square) &&
       !black_squares.include?(square)
      moveable_squares << square
    end
    square = piece[1] - 9
    if white_squares.include?(square) &&
       !in_column?(1, piece[1])
      moveable_squares << square
    end
    square = piece[1] - 7
    if white_squares.include?(square) &&
       !in_column?(8, piece[1])
      moveable_squares << square
    end
    moveable_squares 
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

  def calculate_wB_moves(piece, pieces)
    @moveable_squares = []
    @white_squares = pieces[:white].map {|p| p[1]}
    @black_squares = pieces[:black].map {|p| p[1]}
    def add_sw_square?(square)
      if !in_row?(1, square) &&
         !in_column?(1, square) &&
         !@white_squares.include?(square - 9)
        @moveable_squares << (square - 9)
        add_sw_square?(square - 9) unless @black_squares.include?(square - 9)
      end
    end
    add_sw_square?(piece[1])
    def add_se_square?(square)
      if !in_row?(1, square) &&
         !in_column?(8, square) &&
         !@white_squares.include?(square - 7)
        @moveable_squares << (square - 7)
        add_se_square?(square - 7) unless @black_squares.include?(square - 7)
      end
    end
    add_se_square?(piece[1])
    def add_nw_square?(square)
      if !in_row?(8, square) &&
         !in_column?(1, square) &&
         !@white_squares.include?(square + 7)
        @moveable_squares << (square + 7)
        add_nw_square?(square + 7) unless @black_squares.include?(square + 7)
      end
    end
    add_nw_square?(piece[1])
    def add_ne_square?(square)
      if !in_row?(8, square) &&
         !in_column?(8, square) &&
         !@white_squares.include?(square + 9)
        @moveable_squares << (square + 9)
        add_ne_square?(square + 9) unless @black_squares.include?(square + 9)
      end
    end
    add_ne_square?(piece[1])
    @moveable_squares
  end

  def calculate_bB_moves(piece, pieces)
    @moveable_squares = []
    @white_squares = pieces[:white].map {|p| p[1]}
    @black_squares = pieces[:black].map {|p| p[1]}
    def add_sw_square?(square)
      if !in_row?(1, square) &&
         !in_column?(1, square) &&
         !@black_squares.include?(square - 9)
        @moveable_squares << (square - 9)
        add_sw_square?(square - 9) unless @white_squares.include?(square - 9)
      end
    end
    add_sw_square?(piece[1])
    def add_se_square?(square)
      if !in_row?(1, square) &&
         !in_column?(8, square) &&
         !@black_squares.include?(square - 7)
        @moveable_squares << (square - 7)
        add_se_square?(square - 7) unless @white_squares.include?(square - 7)
      end
    end
    add_se_square?(piece[1])
    def add_nw_square?(square)
      if !in_row?(8, square) &&
         !in_column?(1, square) &&
         !@black_squares.include?(square + 7)
        @moveable_squares << (square + 7)
        add_nw_square?(square + 7) unless @white_squares.include?(square + 7)
      end
    end
    add_nw_square?(piece[1])
    def add_ne_square?(square)
      if !in_row?(8, square) &&
         !in_column?(8, square) &&
         !@black_squares.include?(square + 9)
        @moveable_squares << (square + 9)
        add_ne_square?(square + 9) unless @white_squares.include?(square + 9)
      end
    end
    add_ne_square?(piece[1])
    @moveable_squares
  end

  def calculate_wR_moves(piece, pieces)
  end

  def calculate_bR_moves(piece, pieces)
  end

  def calculate_wQ_moves(piece, pieces)
  end

  def calculate_bQ_moves(piece, pieces)
  end

  def calculate_wK_moves(piece, pieces)
  end

  def calculate_bK_moves(piece, pieces)
  end
end

