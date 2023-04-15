require './lib/Pawn.rb'

require './lib/Rook.rb'
require './lib/Bishop.rb'
require './lib/Piece.rb'

class Board
  attr_accessor :board

  def initialize
    @board = create_board
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
    setup_white_pawns
    setup_black_pawns
  end

  def setup_white_pawns
    @board[2].each_index do |index|
      @board[2][index] = WhitePawn.new(index, 2) unless index.zero?
    end
  end

  def setup_black_pawns
    @board[7].each_index do |index|
      @board[7][8 - index] = BlackPawn.new(8 - index, 7) unless index == 8
    end
  end
end


