require './lib/Board'
require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen.rb'
require './lib/King.rb'
require './lib/Knight.rb'
module Boundries
  # Returns TRUE if a move is within the boundries of the chess board.
  # move = [a,b], a & b are both between 1 and 8 => TRUE
  def within_bound?(move)
    return true if move[0].between?(1, 8) && move[1].between?(1, 8)

    false
  end
end
class Piece
  def white_piece?(piece)
    piece.is_a?(White) || piece.is_a?(King)
  end

  def black_piece?(piece)
    piece.is_a?(Black) || piece.is_a?(King)
  end
end

class White < Piece
  attr_accessor :pieces, :lost

  def initialize
    @pieces = []
    @lost = []
  end
end

class Black < Piece
  attr_accessor :pieces, :lost

  def initialize
    @pieces = []
    @lost = []
  end
end
