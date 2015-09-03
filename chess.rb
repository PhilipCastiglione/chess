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

  private

  def starting_pieces
    [['wR', 0, []], ['wN', 1, []], ['wB', 2, []], ['wQ', 3, []], ['wK', 4, []], ['wB', 5, []], ['wN', 6, []], ['wR', 7, []], ['wP', 8, []], ['wP', 9, []], ['wP', 10, []], ['wP', 11, []], ['wP', 12, []], ['wP', 13, []], ['wP', 14, []], ['wP', 15, []], ['bP', 48, []], ['bP', 49, []], ['bP', 50, []], ['bP', 51, []], ['bP', 52, []], ['bP', 53, []], ['bP', 54, []], ['bP', 55, []], ['bR', 56, []], ['bN', 57, []], ['bB', 58, []], ['bQ', 59, []], ['bK', 60, []], ['bB', 61, []], ['bN', 62, []], ['bR', 63, []]]
  end

  def update_board
    @board = [nil]*64
    @pieces.each do |p|
      @board[p[1]] = p[0]
    end
  end

  def populate_moves(pieces)
    pieces.map |do| p
      self.send("calculate_#{p[0]}_moves".to_sym, p)
    end
  end

  def calculate_wP_moves(piece)
  end

  def calculate_bP_moves(piece)
  end

  def calculate_wN_moves(piece)
  end

  def calculate_bN_moves(piece)
  end

  def calculate_wB_moves(piece)
  end

  def calculate_bB_moves(piece)
  end

  def calculate_wR_moves(piece)
  end

  def calculate_bR_moves(piece)
  end

  def calculate_wQ_moves(piece)
  end

  def calculate_bQ_moves(piece)
  end

  def calculate_wK_moves(piece)
  end

  def calculate_bK_moves(piece)
  end
end

