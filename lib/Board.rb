require './lib/Pawn.rb'
require './lib/Rook.rb'
require './lib/Bishop.rb'
require './lib/Queen.rb'
require './lib/Knight.rb'
require './lib/Piece.rb'

class Board
  attr_accessor :board, :player_one, :player_two

  def initialize
    @board = create_board
    @player_one = White.new
    @player_two = Black.new
  end

  def calculate_legals(player)
    output = []
    player.pieces.each do |piece|
      legals = Array.new(2) {Array.new}
      moves = piece.legal_moves(self)
      legals[0] = piece.start_pos unless moves.empty?
      legals[1].replace(moves) unless moves.empty?
      output << legals unless moves.empty?
    end
    output
  end

  def create_board
    # string = ' abcdefgh'
    string = ' 12345678'
    new_board = Array.new(9) { Array.new(9) }
    new_board.each_with_index do |row, row_index|
      row.each_with_index do |_col, col_index|
        new_board[0][col_index] = string[col_index] if row_index.zero?

        new_board[row_index][0] = row_index if col_index.zero?

        new_board[row_index][col_index] = ' ' unless row_index.zero? || col_index.zero?
      end
    end
    new_board
  end

  def print_board
    puts "\n"

    @board.reverse.each do |row|
      string = ''
      row.each do |col|
        col.kind_of?(Piece) ? string.concat(" #{col.avatar} |"): string.concat(" #{col} |")
      end
      puts string
      puts '------------------------------------'
    end
  end

  def piece_at(x_pos, y_pos)
    @board[y_pos][x_pos]
  end

  def setup_pieces

    setup_white_pieces
    setup_white_pawns

    setup_black_pieces
    setup_black_pawns
  end

  def setup_white_pawns
    @board[2].each_index do |index|
      @board[2][index] = WhitePawn.new(index, 2) unless index.zero?
    end
    @board[2].each_with_index { |piece, index| @player_one.pieces.push(piece) unless index.zero? || piece == ' ' }
  end

  def setup_white_pieces
    @board[1][1] = WhiteRook.new(1, 1)
    @board[1][2] = WhiteKnight.new(2, 1)
    @board[1][3] = WhiteBishop.new(3, 1)
    @board[1][4] = WhiteQueen.new(4, 1)
    # @board[1][5] = WhiteKing.new(5, 1)
    @board[1][6] = WhiteBishop.new(6, 1)
    @board[1][7] = WhiteKnight.new(7, 1)
    @board[1][8] = WhiteRook.new(8, 1)
    @board[1].each_with_index { |piece, index| @player_one.pieces.push(piece) unless index.zero? || piece == ' ' }
  end

  def setup_black_pawns
    @board[7].each_index do |index|
      @board[7][8 - index] = BlackPawn.new(8 - index, 7) unless index == 8
    end
    @board[7].each_with_index { |piece, index| @player_two.pieces.push(piece) unless index.zero? || piece == ' ' }
  end

  def setup_black_pieces
    @board[8][1] = BlackRook.new(1, 8)
    @board[8][2] = BlackKnight.new(2, 8)
    @board[8][3] = BlackBishop.new(3, 8)
    @board[8][4] = BlackQueen.new(4, 8)
    # @board[1][5] = BlackKing.new(5, 8)
    @board[8][6] = BlackBishop.new(6, 8)
    @board[8][7] = BlackKnight.new(7, 8)
    @board[8][8] = BlackRook.new(8, 8)
    @board[8].each_with_index { |piece, index| @player_two.pieces.push(piece) unless index.zero? || piece == ' ' }
  end
end
