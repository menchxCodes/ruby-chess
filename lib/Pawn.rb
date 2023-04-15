require './lib/Board.rb'
require './lib/Bishop.rb'
require './lib/Rook.rb'
require './lib/Queen.rb'
require './lib/Piece.rb'
require './lib/Knight.rb'

class WhitePawn < White
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u2659"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []
    # single-forward_move
    unless board.piece_at(@current_pos[0], @current_pos[1] + 1).kind_of?(Piece) && @current_pos[1] != 8
      # puts 'single-forward_move'
      @legal_moves.push([@current_pos[0], @current_pos[1] + 1])
    end

    # double-forward-move
    blocked_forward = board.piece_at(@current_pos[0], @current_pos[1] + 1).kind_of?(Piece) || board.piece_at(@current_pos[0], @current_pos[1] + 2).kind_of?(Piece)
    if @moves.empty? && !blocked_forward
      # puts 'double-forward-move'
      @legal_moves.push([@current_pos[0], @current_pos[1] + 2])
    end

    #left-attack
    if board.piece_at(@current_pos[0] - 1, @current_pos[1] + 1).kind_of?(Black) && @current_pos[0] != 1
      # puts 'left-attack'
      @legal_moves.push([@current_pos[0] - 1, @current_pos[1] + 1])
    end

    # right-attack
    if board.piece_at(@current_pos[0] + 1, @current_pos[1] + 1).kind_of?(Black) && @current_pos[0] != 8
      # puts 'right-attack'
      @legal_moves.push([@current_pos[0] + 1, @current_pos[1] + 1])
    end

    @legal_moves
  end
end

class BlackPawn < Black
  attr_reader :avatar, :start_pos
  attr_accessor :moves, :current_pos

  def initialize(x_pos, y_pos)
    @avatar = "\u265f"
    @start_pos = [x_pos, y_pos]
    @current_pos = @start_pos
    @moves = []
  end

  def legal_moves(board)
    @legal_moves = []
    # single-forward_move
    unless board.piece_at(@current_pos[0], @current_pos[1] - 1).kind_of?(Piece) && @current_pos[1] != 1
      # puts 'single-forward_move'
      @legal_moves.push([@current_pos[0], @current_pos[1] - 1])
    end

    # double-forward-move
    blocked_forward = board.piece_at(@current_pos[0], @current_pos[1] - 1).kind_of?(Piece) || board.piece_at(@current_pos[0], @current_pos[1] - 2).kind_of?(Piece)
    if @moves.empty? && !blocked_forward
      # puts 'double-forward-move'
      @legal_moves.push([@current_pos[0], @current_pos[1] - 2])
    end

    # left-attack
    if board.piece_at(@current_pos[0] - 1, @current_pos[1] - 1).kind_of?(White) && @current_pos[0] != 1
      # puts 'left-attack'
      @legal_moves.push([@current_pos[0] - 1, @current_pos[1] - 1])
    end

    # right-attack
    if board.piece_at(@current_pos[0] + 1, @current_pos[1] - 1).kind_of?(White) && @current_pos[0] != 8
      # puts 'right-attack'
      @legal_moves.push([@current_pos[0] + 1, @current_pos[1] - 1])
    end

    @legal_moves
  end
end
