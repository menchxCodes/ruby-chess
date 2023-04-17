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

  def legal_moves(board)
    @legal_moves = []

    move = [@current_pos[0] + 1, @current_pos[1] + 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 1, @current_pos[1] - 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 1, @current_pos[1] + 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 1, @current_pos[1] - 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 2, @current_pos[1] + 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 2, @current_pos[1] - 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 2, @current_pos[1] + 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 2, @current_pos[1] - 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(White) || board.piece_at(move[0], move[1]).is_a?(King)

    @legal_moves
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

  def legal_moves(board)
    @legal_moves = []

    move = [@current_pos[0] + 1, @current_pos[1] + 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 1, @current_pos[1] - 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 1, @current_pos[1] + 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 1, @current_pos[1] - 2]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 2, @current_pos[1] + 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] + 2, @current_pos[1] - 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 2, @current_pos[1] + 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    move = [@current_pos[0] - 2, @current_pos[1] - 1]
    @legal_moves.push(move) unless !within_bound?(move) || board.piece_at(move[0], move[1]).is_a?(Black) || board.piece_at(move[0], move[1]).is_a?(King)

    @legal_moves
  end
end
