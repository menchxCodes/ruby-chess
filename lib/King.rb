require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen'
require './lib/Knight'
require './lib/Piece'

class King
  def white_piece?(piece)
    piece.is_a?(White) || piece.is_a?(King)
  end

  def black_piece?(piece)
    piece.is_a?(Black) || piece.is_a?(King)
  end
end

class WhiteKing < King
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u2654"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []
    king_moves = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]

    king_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      @legal_moves.push(ghost_move) unless !within_bound?(ghost_move) || white_piece?(target)
    end

    # removes moves around the other king
    black_king = board.find_black_king
    black_king_moves = black_king.influence
    black_king_moves.each do |move|
      @legal_moves.delete(move) if black_king_moves.include?(move)
    end

    @legal_moves
  end

  def influence
    influence = []
    king_moves = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]

    king_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      influence.push(ghost_move) if within_bound?(ghost_move)
    end
    influence
  end
end

class BlackKing < King
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u265a"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []
    king_moves = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]

    king_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      @legal_moves.push(ghost_move) unless !within_bound?(ghost_move) || black_piece?(target)
    end

    # removes moves around the other king
    white_king = board.find_white_king
    white_king_moves = white_king.influence
    white_king_moves.each do |move|
      @legal_moves.delete(move) if white_king_moves.include?(move)
    end

    @legal_moves
  end

  def influence
    influence = []
    king_moves = [[0, 1], [1, 1], [1, 0], [1, -1], [0, -1], [-1, -1], [-1, 0], [-1, 1]]

    king_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      influence.push(ghost_move) if within_bound?(ghost_move)
    end
    influence
  end
end
