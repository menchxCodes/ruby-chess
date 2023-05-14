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
  end

  def draw?
    # dead position king vs king
    if @current_player.pieces.size == 1 && opposite_player.pieces.size == 1
      puts "draw: king vs king"
      return true
    end

    # dead position king vs king & bishop or king & knight
    if @current_player.pieces.size == 1 && opposite_player.pieces.size == 2
      opposite_player.pieces.each do |piece|
        if piece.is_a?(WhiteKnight) || piece.is_a?(BlackKnight)
          puts "draw:king vs king & knight"
          return true
        end
      end
    end

    if @current_player.pieces.size == 2 && opposite_player.pieces.size == 1
      @current_player.pieces.each do |piece|
        if piece.is_a?(WhiteKnight) || piece.is_a?(BlackKnight)
          puts "draw:king vs king & knight"
          return true
        end
      end
    end

    if @current_player.pieces.size == 1 && opposite_player.pieces.size == 2
      opposite_player.pieces.each do |piece|
        if piece.is_a?(WhiteBishop) || piece.is_a?(BlackBishop)
          puts "draw:king vs king & bishop"
          return true
        end
      end
    end

    if @current_player.pieces.size == 2 && opposite_player.pieces.size == 1
      @current_player.pieces.each do |piece|
        if piece.is_a?(WhiteBishop) || piece.is_a?(BlackBishop)
          puts "draw:king vs king & bishop"
          return true
        end
      end
    end

    # dead position king & bishop vs king & bishop of the same square color
    if @current_player.pieces.size == 2 && opposite_player.pieces.size == 2
      first_bishop = @current_player.pieces.select { |piece| piece.is_a?(WhiteBishop) || piece.is_a?(BlackBishop) }
      second_bishop = @current_player.pieces.select { |piece| piece.is_a?(WhiteBishop) || piece.is_a?(BlackBishop) }
      unless first_bishop.empty? || second_bishop.empty?
        if first_bishop[0].start_pos == [6, 1] && second_bishop[0].start_pos == [3, 8]
          puts "draw: king & bishop vs king & bishop of the same square color"
          return true
        end

        if second_bishop[0].start_pos == [6, 1] && first_bishop[0].start_pos == [3, 8]
          puts "draw: king & bishop vs king & bishop of the same square color"
          return true
        end
      end

      unless first_bishop.empty? || second_bishop.empty?
        if first_bishop[0].start_pos == [3, 1] && second_bishop[0].start_pos == [1, 8]
          puts "draw: king & bishop vs king & bishop of the same square color"
          return true
        end

        if second_bishop[0].start_pos == [3, 1] && first_bishop[0].start_pos == [1, 8]
          puts "draw: king & bishop vs king & bishop of the same square color"
          return true
        end
      end
    end

    # stalemate
    current_legals = calculate_legals(@current_player)
    current_legals.each do |piece_moves|
      piece = piece_at(piece_moves[0][0], piece_moves[0][1])
      piece_moves[1].each do |move|
        try = try_legal_move(piece, move[0], move[1])
        if try == "failure"
          piece_moves[1].delete(move)
        end
      end

      if piece_moves[1].empty?
        current_legals.delete(piece_moves)
      end
    end

    if !checked?(@current_player) && current_legals.empty?
      puts 'draw: stalemate'
      return true
    end

    false
  end

  def win?
    return true if checked? && uncheck_moves.size.zero?

    false
  end

  def checked?(player = @current_player)
    opposite = opposite_player(player)
    opposite_checks = calculate_checks(opposite)
    return false if opposite_checks.size.zero?

    # opposite_checks.each do |check|
    #   puts "check by #{piece_at(check[0][0], check[0][1]).avatar} at #{check[0]} on #{check[1]}"
    # end

    true
  end

  def uncheck_moves(player = @current_player)
    unchecks = []
    legals = calculate_legals(player)
    legals.each do |piece_move|
      uncheck_moves = []
      piece = piece_at(piece_move[0][0], piece_move[0][1])
      moves = piece_move[1]
      moves.each do |move|
        try = try_legal_move(piece, move[0], move[1])
        uncheck_moves << move if try == "success"
      end
      unchecks << [piece.current_pos, uncheck_moves] unless uncheck_moves.empty?
    end
    unchecks
  end

  def play
    until draw? || win?
      puts "\nTurn #{@turn}"
      puts "#{@current_player.name}(#{@current_player.color})'s king is under check" if checked?(@current_player)
      piece_move = player_input
      piece = piece_move[0]
      move = piece_move[1]

      do_move(piece, move[0], move[1])
      puts "#{@current_player.name}(#{@current_player.color}) checks #{opposite_player.name}(#{opposite_player.color})'s king" if checked?(@opposite_player)
      @turn += 1
      change_player
    end
    puts "#{opposite_player.name}(#{opposite_player.color}) wins!" if win?
  end

  def player_input
    puts "\n"
    legals = calculate_legals(@current_player).shuffle
    legals = uncheck_moves.shuffle if checked?
    # puts "legals= #{legals}"

    sample = legals.sample
    sample_piece = sample[0]
    sample_move = sample[1].sample
    # puts "sample= #{sample}"
    # puts "sample piece= #{sample_piece}"
    # puts "sample move= #{sample_move}"

    if @current_player.name == "computer"
      piece = piece_at(sample_piece[0], sample_piece[1])
      try = try_legal_move(piece, sample_move[0], sample_move[1])
      if try == "success"
        return [piece_at(sample_piece[0], sample_piece[1]), sample_move] if try=="success"
      else
        until try == "success" || legals.empty? || sample[1].empty?
          sample = legals.sample
          sample_piece = sample[0]
          if sample_move.nil?
            legals.delete(sample)
            sample = legals.sample
          else
            sample_move = sample[1].pop
          end

          piece = piece_at(sample_piece[0], sample_piece[1])
          puts "sample= #{sample}"
          puts "legals= #{legals}"
          try = try_legal_move(piece, sample_move[0], sample_move[1])
        end
        return [piece_at(sample_piece[0], sample_piece[1]), sample_move]
      end
    end

    puts "#{@current_player.name}(#{@current_player.color}) player, please select the piece and move. example: #{sample_piece.join('')} #{sample_move.join('')}"
    input = gets.chomp!

    until valid_input?(input)
      puts "\n"
      puts "#{@current_player.name}(#{@current_player.color}) player, please select the piece and move. example: #{sample_piece.join('')} #{sample_move.join('')}"
      input = gets.chomp!
    end

    output = input.split(' ')
    # puts "got #{output} as input"
    piece_input = output[0].split('')
    move_input = output[1].split('')

    piece = piece_at(piece_input[0].to_i, piece_input[1].to_i)
    move = [move_input[0].to_i, move_input[1].to_i]

    [piece, move]
  end

  def valid_input?(input)
    input = input.split(' ')
    return false unless input.size == 2

    piece_input = input[0].split('')
    unless piece_input[0].to_i.between?(1, 8) && piece_input[1].to_i.between?(1, 8)
      puts 'invalid move: selected piece is out of bounds'
      return false
    end

    move_input = input[1].split('')
    unless move_input[0].to_i.between?(1, 8) && move_input[1].to_i.between?(1, 8)
      puts 'invalid move: selected move is out of bounds'
      return false
    end

    piece = piece_at(piece_input[0].to_i, piece_input[1].to_i)
    unless @current_player.pieces.include?(piece)
      puts "invalid piece at #{piece_input}"
      return false
    end

    move = [move_input[0].to_i, move_input[1].to_i]
    unless piece.legal_moves(self).include?(move)
      puts "illegal move #{move} for #{piece.avatar} at #{piece.current_pos}"
      return false
    end

    if checked?
      # puts "legals"
      # p calculate_legals(@current_player)
      # puts "unchecks"
      # p uncheck_moves
      uncheck_moves.each do |piece_move|
        # puts "uncheck"
        if piece.current_pos == piece_move[0]
          piece_move[1].each do |m|
            puts "#{piece.current_pos} #{m}"
            return true if move == m
          end
        end
      end

      puts "move #{move} for #{piece.avatar} at #{piece.current_pos} will not remove your check status"
      return false

    end

    if try_legal_move(piece, move[0], move[1]) == "failure"
      puts "move #{move} for #{piece.avatar} at #{piece.current_pos} will result in a check for your king"
      return false
    end

    true
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

  def calculate_checks(player = @current_player)
    output = []
    player.pieces.each do |piece|
      unless piece.is_a?(King)
        moves = piece.check_moves(self)
        output << [piece.current_pos, moves] unless moves.empty?
      end
    end
    output
  end

  def allowed_move?
    opposite_checks = calculate_checks(opposite_player)
    return true if opposite_checks.size == 0

    false
  end

  def try_legal_move(piece, x_move, y_move)
    move = [x_move, y_move]
    result = nil
    return "illegal move" unless piece.legal_moves(self).include?(move)

    target_piece = piece_at(x_move, y_move)
    previous_pos = piece.current_pos

    if target_piece.is_a?(White)
      @player_one.lost << target_piece
      @player_one.pieces.delete(target_piece)

    elsif target_piece.is_a?(Black)
      @player_two.lost << target_piece
      @player_two.pieces.delete(target_piece)
    end

    piece.moves << move
    piece.current_pos = move
    @board[previous_pos[1]][previous_pos[0]] = ' '
    @board[move[1]][move[0]] = piece

    if allowed_move?
      result = "success"
      # print_board
    else
      # puts "move will result in a check for #{@current_player}, please try again:"
      result = "failure"
    end

    piece.moves.pop
    piece.current_pos = previous_pos
    @board[move[1]][move[0]] = target_piece
    @board[previous_pos[1]][previous_pos[0]] = piece

    if target_piece.is_a?(White)
      @player_one.pieces << target_piece
      @player_one.lost.delete(target_piece)
    elsif target_piece.is_a?(Black)
      @player_two.pieces << target_piece
      @player_two.lost.delete(target_piece)
    end

    result
  end

  def do_move(piece, x_move, y_move)
    move = [x_move, y_move]
    target_piece = piece_at(x_move, y_move)
    previous_pos = piece.current_pos

    if target_piece.is_a?(White)
      @player_one.lost << target_piece
      @player_one.pieces.delete(target_piece)

    elsif target_piece.is_a?(Black)
      @player_two.lost << target_piece
      @player_two.pieces.delete(target_piece)
    end

    piece.moves << move
    piece.current_pos = move
    @board[previous_pos[1]][previous_pos[0]] = ' '
    @board[move[1]][move[0]] = piece

    # castle-special-move
    if piece.is_a?(WhiteKing)
      # puts 'white-castle'
      special_move = move[0] - previous_pos[0]

      # white-right-castle
      if special_move == 2
        puts 'white-right-castle'
        white_rook = piece_at(8, 1)
        @board[1][6] = white_rook
        white_rook.moves << [6, 1]
        white_rook.current_pos = [6, 1]
        @board[1][8] = ' '
        puts "rook: #{white_rook.current_pos}"
      end

      # white-left-castle
      if special_move == -2
        puts 'white-left-castle'
        white_rook = piece_at(1, 1)
        @board[1][4] = white_rook
        white_rook.moves << [4, 1]
        white_rook.current_pos = [4, 1]
        @board[1][1] = ' '
      end
    end

    if piece.is_a?(BlackKing)
      # puts 'black-castle'
      special_move = move[0] - previous_pos[0]

      # black-right-castle
      if special_move == 2
        puts 'black-right-castle'
        black_rook = piece_at(8, 8)
        @board[8][6] = black_rook
        black_rook.moves << [6, 8]
        black_rook.current_pos = [6, 8]
        @board[8][8] = ' '
        puts "rook: #{black_rook.current_pos}"
      end

      # white-left-castle
      if special_move == -2
        puts 'black-left-castle'
        black_rook = piece_at(1, 8)
        @board[8][4] = black_rook
        black_rook.moves << [4, 8]
        black_rook.current_pos = [4, 8]
        @board[8][1] = ' '
        puts "rook: #{black_rook.current_pos}"
      end
    end

    print_board
    puts "#{@current_player.name}(#{@current_player.color}) moved #{piece.avatar} at #{previous_pos} to #{move}."
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
    puts white_lost unless @player_one.lost.empty?

    black_lost = "black-lost:"
    @player_two.lost.each {|piece| black_lost.concat(piece.avatar) }
    puts black_lost unless @player_two.lost.empty?
  end

  def piece_at(x_pos, y_pos)
    @board[y_pos][x_pos]
  end

  def find_opposite_king(player = opposite_player)
    if player.is_a?(White)
      find_white_king
    elsif player.is_a?(Black)
      find_black_king
    end
  end

  def find_current_king(player = @current_player)
    if player.is_a?(White)
      find_white_king
    elsif player.is_a?(Black)
      find_black_king
    end
  end

  def find_white_king
    player_one.pieces.each do |piece|
      return piece if piece.avatar == "\u2654"
    end
  end

  def find_black_king
    player_two.pieces.each do |piece|
      return piece if piece.avatar == "\u265a"
    end
  end

  def setup_pieces
    setup_white_pieces
    setup_white_pawns

    setup_black_pieces
    setup_black_pawns
  end

  private

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
