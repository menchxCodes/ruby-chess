require './lib/Board'
require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen'
require './lib/King'
require './lib/Knight'

module Boundries
  # Returns TRUE if a move is within the boundries of the chess board.
  # move = [a,b], a & b are both between 1 and 8 => TRUE
  def within_bound?(move)
    return true if move[0].between?(1, 8) && move[1].between?(1, 8)

    false
  end
end

# All non-king White & Black pieces inherit from the "Piece" class.
class Piece
  # returns TRUE if piece is a white piece or a king of either color.
  # Useful for determining if a piece is non-takable.
  def white_piece?(piece)
    piece.is_a?(White) || piece.is_a?(King)
  end

  def white_piece_only?(piece)
    piece.is_a?(White) || piece.is_a?(WhiteKing)
  end

  def black_piece_only?(piece)
    piece.is_a?(Black) || piece.is_a?(BlackKing)
  end

  # returns TRUE if piece is a black piece or a king of either color.
  # Useful for determining if a piece is non-takable.
  def black_piece?(piece)
    piece.is_a?(Black) || piece.is_a?(King)
  end
end

# White class is to be used for all non-king white pieces.
class White < Piece
  attr_accessor :pieces, :lost
  attr_reader :name

  def initialize
    @name = "computer"
    @pieces = []
    @lost = []
  end
end

# Black class is to be used for all non-king black pieces.
class Black < Piece
  attr_accessor :pieces, :lost
  attr_reader :name

  def initialize
    @name = "computer"
    @pieces = []
    @lost = []
  end
end
