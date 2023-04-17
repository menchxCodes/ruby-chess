require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen'
require './lib/Knight'
require './lib/Piece'

class King
  def within_bound?(move)
    return true if move[0].between?(1, 8) && move[1].between?(1, 8)

    false
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

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0], @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1]]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0], @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1]]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end
    ghost_perm = []
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

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0], @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1]]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0], @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1]]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    unless !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                        ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                      ghost_move[1]).is_a?(King)

      @legal_moves.push(ghost_move)
    end

    @legal_moves
  end
end
