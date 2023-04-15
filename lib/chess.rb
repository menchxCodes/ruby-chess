class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    string = ' abcdefgh'
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
        string.concat(" #{col} |")
      end
      puts string
      puts '------------------------------------'
    end
  end
end
