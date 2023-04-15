require './lib/Board.rb'
require './lib/Pawn.rb'
require './lib/Rook.rb'
require './lib/Piece.rb'

class WhiteBishop < White
    attr_reader :avatar, :start_pos
    attr_accessor :moves
  def initialize(x_pos, y_pos)
    @avatar = "\u2657"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      ghost_move = [ghost_move[0] + 1, ghost_move[1] + 1]
    end
    puts "#{count} moves Up-right"

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      ghost_move = [ghost_move[0] + 1, ghost_move[1] - 1]
    end
    puts "#{count} moves down-right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      ghost_move = [ghost_move[0] - 1, ghost_move[1] + 1]
    end
    puts "#{count} moves up-left"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      ghost_move = [ghost_move[0] - 1, ghost_move[1] - 1]
    end
    puts "#{count} moves down-left"

    @legal_moves
  end
end

class BlackBishop < Black
    attr_reader :avatar, :start_pos
    attr_accessor :moves
  def initialize(x_pos, y_pos)
    @avatar = "\u265d"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []

    ghost_move = [@current_pos[0] + 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      ghost_move = [ghost_move[0] + 1, ghost_move[1] + 1]
    end
    puts "#{count} moves Up-right"

    ghost_move = [@current_pos[0] + 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      ghost_move = [ghost_move[0] + 1, ghost_move[1] - 1]
    end
    puts "#{count} moves down-right"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] + 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      ghost_move = [ghost_move[0] - 1, ghost_move[1] + 1]
    end
    puts "#{count} moves up-left"

    ghost_move = [@current_pos[0] - 1, @current_pos[1] - 1]
    count = 0
    until !within_bound?(ghost_move) || board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(Black)
      @legal_moves.push(ghost_move)
      count += 1
      break if board.piece_at(ghost_move[0], ghost_move[1]).kind_of?(White)
      ghost_move = [ghost_move[0] - 1, ghost_move[1] - 1]
    end
    puts "#{count} moves down-left"

    @legal_moves
  end
end