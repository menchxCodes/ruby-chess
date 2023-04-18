require './lib/Pawn.rb'
require './lib/Rook.rb'
require './lib/Bishop.rb'
require './lib/Queen.rb'
require './lib/Knight.rb'
require './lib/King.rb'
require './lib/Piece.rb'

class Board
  attr_accessor :board, :player_one, :player_two

  def initialize
    @board = create_board
    @player_one = White.new
    @player_two = Black.new
    @current_player = @player_one
    @turn = 0
    @temp = ""
  end

  def white_piece?(piece)
    piece.is_a?(White) && !piece.is_a?(King)
  end

  def black_piece?(piece)
    piece.is_a?(Black) && !piece.is_a?(King)
  end

  def random_loop
    until calculate_legals(@current_player).empty?
      break if @current_player.pieces.size == 1 && @current_player.pieces[0].is_a?(King)

      break if opposite_player.pieces.size == 1 && opposite_player.pieces[0].is_a?(King)

      @turn += 1
      do_random_legal_move(@current_player)
      print_board
      puts @turn
      change_player
      puts "#{@current_player} turn"
    end
  end

  def change_player(player = @current_player)
    case player
    when @player_one
      @current_player = @player_two
    when @player_two
      @current_player = @player_one
    end
  end

  def opposite_player(player = @current_player)
    return @player_one if player == @player_two

    @player_two
  end

  def calculate_legals(player)
    output = []
    player.pieces.each do |piece|
      legals = Array.new(2) {Array.new}
      moves = piece.legal_moves(self)

      legals[0] = piece.current_pos unless moves.empty?
      legals[1].replace(moves) unless moves.empty?
      output << legals unless moves.empty?
    end
    output
  end

  def do_random_legal_move(player)
    legals = calculate_legals(player)
    sample = legals.sample
    random_piece = sample[0]
    return if random_piece.nil?

    random_move = sample[1].sample
    puts "movable pieces=#{legals.size} legal moves= #{sample[1].size}"
    puts "piece:#{random_piece} move:#{random_move}"

    piece = piece_at(random_piece[0], random_piece[1])
    piece.moves.push(random_move)
    target_piece = piece_at(random_move[0], random_move[1])

    if target_piece.is_a?(King)
      @temp.concat("KING DELETED #{@turn} |")
    end

    if target_piece.is_a?(Piece)
      opposite_player.lost << target_piece
      opposite_player.pieces.delete(target_piece)
    end
    @board[random_move[1]][random_move[0]] = piece
    piece.current_pos = [random_move[0], random_move[1]]
    @board[random_piece[1]][random_piece[0]] = ' '
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
        col.is_a?(Piece) || col.is_a?(King) ? string.concat(" #{col.avatar} |"): string.concat(" #{col} |")
      end
      puts string
      puts '------------------------------------'
    end
    white_lost = "white-lost:"
    @player_one.lost.each {|piece| white_lost.concat(piece.avatar) }
    puts white_lost

    black_lost = "black-lost:"
    @player_two.lost.each {|piece| black_lost.concat(piece.avatar) }
    puts black_lost
    puts @temp
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
    @board[1][5] = WhiteKing.new(5, 1)
    @board[1][6] = WhiteBishop.new(6, 1)
    @board[1][7] = WhiteKnight.new(7, 1)
    @board[1][8] = WhiteRook.new(8, 1)
    @board[1].each_with_index { |piece, index| @player_one.pieces.push(piece) unless index.zero? }
  end

  def setup_black_pawns
    @board[7].each_index do |index|
      @board[7][8 - index] = BlackPawn.new(8 - index, 7) unless index == 8
    end
    @board[7].each_with_index { |piece, index| @player_two.pieces.push(piece) unless index.zero? }
  end

  def setup_black_pieces
    @board[8][1] = BlackRook.new(1, 8)
    @board[8][2] = BlackKnight.new(2, 8)
    @board[8][3] = BlackBishop.new(3, 8)
    @board[8][4] = BlackQueen.new(4, 8)
    @board[8][5] = BlackKing.new(5, 8)
    @board[8][6] = BlackBishop.new(6, 8)
    @board[8][7] = BlackKnight.new(7, 8)
    @board[8][8] = BlackRook.new(8, 8)
    @board[8].each_with_index { |piece, index| @player_two.pieces.push(piece) unless index.zero? }
  end
end
