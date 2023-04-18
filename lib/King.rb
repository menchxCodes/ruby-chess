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

    @legal_moves
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

    @legal_moves
  end
end
