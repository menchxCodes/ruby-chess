require './lib/Board.rb'
require './lib/Pawn.rb'
require './lib/Bishop.rb'
require './lib/Rook.rb'
require './lib/Queen.rb'
require './lib/King.rb'
require './lib/Piece.rb'

class WhiteKnight < White
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u2658"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []
    knight_moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]

    knight_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      @legal_moves.push(ghost_move) unless !within_bound?(ghost_move) || white_piece?(target)
    end

    @legal_moves
  end

  def check_moves(board)
    check_moves = []
    knight_moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]

    black_king_pos = board.find_black_king.current_pos

    knight_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || white_piece_only?(target)
        check_moves.push(ghost_move) if ghost_move == black_king_pos
        break if target.is_a?(Black)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end

    check_moves
  end
end

class BlackKnight < Black
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u265e"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end
  include Boundries
  def legal_moves(board)
    @legal_moves = []
    knight_moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]

    knight_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      @legal_moves.push(ghost_move) unless !within_bound?(ghost_move) || black_piece?(target)
    end

    @legal_moves
  end

  def check_moves(board)
    check_moves = []
    knight_moves = [[-1, 2], [1, 2], [2, 1], [2, -1], [1, -2], [-1, -2], [-2, -1], [-2, 1]]

    white_king_pos = board.find_white_king.current_pos

    knight_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      until !within_bound?(ghost_move) || black_piece_only?(target)
        check_moves.push(ghost_move) if ghost_move == white_king_pos
        break if target.is_a?(White)

        ghost_move = [ghost_move[0] + move[0], ghost_move[1] + move[1]]
        target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      end
    end

    check_moves
  end
end
