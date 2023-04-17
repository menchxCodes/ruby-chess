require './lib/Board'
require './lib/Pawn'
require './lib/Bishop'
require './lib/Rook'
require './lib/Knight'
require './lib/King'
require './lib/Piece'

class WhiteQueen < White
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u2655"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] + 1, ghost_move[1] + 1]
    end
    # puts "#{count} moves Up-right"

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] + 1, ghost_move[1] - 1]
    end
    # puts "#{count} moves down-right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] - 1, ghost_move[1] + 1]
    end
    # puts "#{count} moves up-left"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] - 1, ghost_move[1] - 1]
    end
    # puts "#{count} moves down-left"

    ghost_move = [@current_pos[0], @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0], ghost_move[1] + 1]
    end
    # puts "#{count} moves Up"

    ghost_move = [@current_pos[0], @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0], ghost_move[1] - 1]
    end
    # puts "#{count} moves down"

    ghost_move = [@current_pos[0] + 1, @current_pos[1]]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] + 1, ghost_move[1]]
    end
    # puts "#{count} moves right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1]]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(White) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(Black)

      ghost_move = [ghost_move[0] - 1, ghost_move[1]]
    end
    # puts "#{count} moves left"

    @legal_moves
  end
end

class BlackQueen < Black
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u265b"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] + 1, ghost_move[1] + 1]
    end
    # puts "#{count} moves Up-right"

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] + 1, ghost_move[1] - 1]
    end
    # puts "#{count} moves down-right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] - 1, ghost_move[1] + 1]
    end
    # puts "#{count} moves up-left"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] - 1, ghost_move[1] - 1]
    end
    # puts "#{count} moves down-left"

    ghost_move = [@current_pos[0], @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0], ghost_move[1] + 1]
    end
    # puts "#{count} moves Up"

    ghost_move = [@current_pos[0], @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0], ghost_move[1] - 1]
    end
    # puts "#{count} moves down"

    ghost_move = [@current_pos[0] + 1, @current_pos[1]]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] + 1, ghost_move[1]]
    end
    # puts "#{count} moves right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1]]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0],
                                                       ghost_move[1]).is_a?(Black) || board.piece_at(ghost_move[0],
                                                                                                     ghost_move[1]).is_a?(King)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).is_a?(White)

      ghost_move = [ghost_move[0] - 1, ghost_move[1]]
    end
    # puts "#{count} moves left"

    @legal_moves
  end
end
