require './lib/Board.rb'
require './lib/Pawn.rb'
require './lib/Bishop.rb'
require './lib/Queen.rb'
require './lib/Knight.rb'
require './lib/King.rb'
require './lib/Piece.rb'

class WhiteRook < White
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u2656"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []

    rook_moves = [[1, 0], [0, -1], [-1, 0], [0, 1]]

    rook_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || white_piece?(target)
        @legal_moves << ghost_move
        break if target.is_a?(Black)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end
    @legal_moves
  end

  def check_moves(board)
    checks = []
    rook_moves = [[1, 0], [0, -1], [-1, 0], [0, 1]]

    black_king_pos = board.find_black_king.current_pos

    rook_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || white_piece_only?(target)
        checks.push(ghost_move) if ghost_move == black_king_pos
        break if target.is_a?(Black)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end
    checks
  end
end

class BlackRook < Black
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u265c"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []

    rook_moves = [[1, 0], [0, -1], [-1, 0], [0, 1]]

    rook_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || black_piece?(target)
        @legal_moves << ghost_move
        break if target.is_a?(White)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end
    @legal_moves
  end

  def check_moves(board)
    checks = []
    rook_moves = [[1, 0], [0, -1], [-1, 0], [0, 1]]

    white_king_pos = board.find_white_king.current_pos

    rook_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || black_piece_only?(target)
        checks.push(ghost_move) if ghost_move == white_king_pos
        break if target.is_a?(White)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end
    checks
  end
end
