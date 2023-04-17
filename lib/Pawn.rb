require './lib/Board'
require './lib/Bishop'
require './lib/Rook'
require './lib/Queen'
require './lib/King'
require './lib/Piece'
require './lib/Knight'

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
    return @legal_moves if @current_pos[1] == 8

    if !board.piece_at(@current_pos[0],
                       @current_pos[1] + 1).is_a?(Piece) && !@current_pos[1] != 8 && !board.piece_at(@current_pos[0],
                                                                                                     @current_pos[1] + 1).is_a?(King)
      # puts 'single-forward_move'
      @legal_moves.push([@current_pos[0], @current_pos[1] + 1])
    end

    # double-forward-move
    if @moves.empty?
      blocked_forward = board.piece_at(@current_pos[0],
                                       @current_pos[1] + 1).is_a?(Piece) || board.piece_at(@current_pos[0],
                                                                                           @current_pos[1] + 2).is_a?(Piece)
      @legal_moves.push([@current_pos[0], @current_pos[1] + 2]) unless blocked_forward
    end

    # left-attack
    if board.piece_at(@current_pos[0] - 1,
                      @current_pos[1] + 1).is_a?(Black) && !board.piece_at(@current_pos[0] - 1,
                                                                           @current_pos[1] + 1).is_a?(King) && @current_pos[0] != 1
      # puts 'left-attack'
      @legal_moves.push([@current_pos[0] - 1, @current_pos[1] + 1])
    end

    # right-attack
    if board.piece_at(@current_pos[0] + 1,
                      @current_pos[1] + 1).is_a?(Black) && board.piece_at(@current_pos[0] + 1,
                                                                          @current_pos[1] + 1).is_a?(King) && @current_pos[0] != 8
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
    return @legal_moves if @current_pos[1] == 1

    # single-forward_move
    if !board.piece_at(@current_pos[0],
                       @current_pos[1] - 1).is_a?(Piece) && !@current_pos[1] != 1 && !board.piece_at(@current_pos[0],
                                                                                                     @current_pos[1] - 1).is_a?(King)
      # puts 'single-forward_move'
      @legal_moves.push([@current_pos[0], @current_pos[1] - 1])
    end

    # double-forward-move
    if @moves.empty?
      blocked_forward = board.piece_at(@current_pos[0],
                                       @current_pos[1] - 1).is_a?(Piece) || board.piece_at(@current_pos[0],
                                                                                           @current_pos[1] - 2).is_a?(Piece)
      @legal_moves.push([@current_pos[0], @current_pos[1] - 2]) unless blocked_forward
    end

    # left-attack
    if board.piece_at(@current_pos[0] - 1,
                      @current_pos[1] - 1).is_a?(White) && board.piece_at(@current_pos[0] - 1,
                                                                          @current_pos[1] - 1).is_a?(King) && @current_pos[0] != 1
      # puts 'left-attack'
      @legal_moves.push([@current_pos[0] - 1, @current_pos[1] - 1])
    end

    # right-attack
    if board.piece_at(@current_pos[0] + 1,
                      @current_pos[1] - 1).is_a?(White) && board.piece_at(@current_pos[0] + 1,
                                                                          @current_pos[1] - 1).is_a?(King) && @current_pos[0] != 8
      # puts 'right-attack'
      @legal_moves.push([@current_pos[0] + 1, @current_pos[1] - 1])
    end

    @legal_moves
  end
end
