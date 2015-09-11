class Chess
  attr_reader :pieces

  def initialize
    @board = []
    @pieces = starting_pieces
    @active_player = nil
    store_pieces
    update_board
    #start_game
  end

  def to_s
    start = 64
    8.times do
      p "|#{@board.slice(start - 8, 8).map { |s| (s)? s : '__' }.join("|")}|"
      start -= 8
    end
    return nil
  end

  def starting_pieces
    {white: {'wR1': 0, 'wN1': 1, 'wB1': 2, 'wQ1': 3, 'wK1': 4, 'wB2': 5, 'wN2': 6, 'wR2': 7, 'wP1': 8, 'wP2': 9, 'wP3': 10, 'wP4': 11, 'wP5': 12, 'wP6': 13, 'wP7': 14, 'wP8': 15}, black: {'bP1': 48, 'bP2': 49, 'bP3': 50, 'bP4': 51, 'bP5': 52, 'bP6': 53, 'bP7': 54, 'bP8': 55, 'bR1': 56, 'bN1': 57, 'bB1': 58, 'bQ1': 59, 'bK1': 60, 'bB2': 61, 'bN2': 62, 'bR2': 63}}
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
    @white_squares = @pieces[:white].values
    @black_squares = @pieces[:black].values
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

  def get_pawn_moves(square, color)
    @moveable_squares = []
    add_single_square?(square, 0, 0, (color == 'w')? 8 : -8, color)
    @moveable_squares 
  end

  def get_knight_moves(square, color)
    @moveable_squares = []
    add_knight_square?(square, 1, 2, 1, 0, -17 , color)
    add_knight_square?(square, 1, 2, 8, 0, -15 , color)
    add_knight_square?(square, 1, 0, 1, 2, -10 , color)
    add_knight_square?(square, 1, 0, 7, 8, -6 , color)
    add_knight_square?(square, 8, 0, 1, 2, 6 , color)
    add_knight_square?(square, 8, 0, 7, 8, 10 , color)
    add_knight_square?(square, 7, 8, 1, 0, 15 , color)
    add_knight_square?(square, 7, 8, 8, 0, 17 , color)
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
    add_single_square?(square, 1, 1, -9, color)
    add_single_square?(square, 1, 0, -8, color)
    add_single_square?(square, 1, 8, -7, color)
    add_single_square?(square, 0, 1, -1, color)
    add_single_square?(square, 0, 8, 1, color)
    add_single_square?(square, 8, 1, 7, color)
    add_single_square?(square, 8, 0, 8, color)
    add_single_square?(square, 8, 8, 9, color)
    @moveable_squares
  end

  def start_game
    puts "WELCOME TO CHESS AND SHIT"
    puts self
    wait_for_move
  end

  def wait_for_move
    unless win
      if !@active_player || @active_player == 'black'
        @active_player = 'white'
      else
        @active_player = 'black'
      end
      
      puts "Player #{@active_player}: your turn"

      begin
        move = get_player_move
        square = get_player_square
        confirm = get_player_confirmation
        move_valid = check_valid_move(move, square, @active_player)
      end while !confirm && !move_valid

    else
      #do win stuff
    end
  end

  def get_player_move
    print "What piece would you like to move? "
    gets.chomp
  end

  def get_player_square
    print "Where should it go? "
    gets.chomp
  end

  def get_player_confirmation
    print "Confirm #{piece} to #{square} y/n: "
    gets.chomp
  end

  def check_valid_move(move, square, color)
  end

  def win

  end
end

chess = Chess.new

