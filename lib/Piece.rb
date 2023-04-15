require './lib/Board'
require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen.rb'
require './lib/Knight.rb'

class Piece
  def piece?
    is_a?(Piece)
  end

  def within_bound?(move)
    return true if move[0].between?(1, 8) && move[1].between?(1, 8)

    false
  end
end

class White < Piece
  def initialize
    @white_pieces = []
    @white_lost = []
  end
end

class Black < Piece
  def initialize
    @black_pieces = []
    @black_lost = []
  end
end
