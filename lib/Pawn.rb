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
  include Boundries
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
      @legal_moves.push([@current_pos[0], @current_pos[1] + 2]) unless blocked_forward || board.piece_at(@current_pos[0], @current_pos[1] + 2).is_a?(King)
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
                      @current_pos[1] + 1).is_a?(Black) && !board.piece_at(@current_pos[0] + 1,
                                                                          @current_pos[1] + 1).is_a?(King) && @current_pos[0] != 8
      # puts 'right-attack'
      @legal_moves.push([@current_pos[0] + 1, @current_pos[1] + 1])
    end

    @legal_moves
  end

  def check_moves(board)
    check_moves = []
    white_pawn_moves = [[-1, 1], [1, 1]]

    black_king_pos = board.find_black_king.current_pos

    white_pawn_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      unless !within_bound?(ghost_move) || white_piece_only?(target)
        check_moves.push(ghost_move) if ghost_move == black_king_pos
      end
    end

    check_moves
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
  include Boundries
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
      @legal_moves.push([@current_pos[0], @current_pos[1] - 2]) unless blocked_forward || board.piece_at(@current_pos[0], @current_pos[1] - 2).is_a?(King)
    end

    # left-attack
    if board.piece_at(@current_pos[0] - 1,
                      @current_pos[1] - 1).is_a?(White) && !board.piece_at(@current_pos[0] - 1,
                                                                          @current_pos[1] - 1).is_a?(King) && @current_pos[0] != 1
      # puts 'left-attack'
      @legal_moves.push([@current_pos[0] - 1, @current_pos[1] - 1])
    end

    # right-attack
    if board.piece_at(@current_pos[0] + 1,
                      @current_pos[1] - 1).is_a?(White) && !board.piece_at(@current_pos[0] + 1,
                                                                          @current_pos[1] - 1).is_a?(King) && @current_pos[0] != 8
      # puts 'right-attack'
      @legal_moves.push([@current_pos[0] + 1, @current_pos[1] - 1])
    end

    @legal_moves
  end

  def check_moves(board)
    check_moves = []
    black_pawn_moves = [[-1, -1], [1, -1]]

    white_king_pos = board.find_white_king.current_pos

    black_pawn_moves.each do |move|
      ghost_move = [@current_pos[0] + move[0], @current_pos[1] + move[1]]
      target = board.piece_at(ghost_move[0], ghost_move[1]) if within_bound?(ghost_move)
      unless !within_bound?(ghost_move) || black_piece_only?(target)
        check_moves.push(ghost_move) if ghost_move == white_king_pos
      end
    end

    check_moves
  end
end
