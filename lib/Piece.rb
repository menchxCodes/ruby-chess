require './lib/Board'
require './lib/Pawn'
require './lib/Rook'
require './lib/Bishop'
require './lib/Queen.rb'
require './lib/King.rb'
require './lib/Knight.rb'
module Boundries
  def within_bound?(move)
    return true if move[0].between?(1, 8) && move[1].between?(1, 8)

    false
  end 
end
class Piece
  def piece?
    is_a?(Piece)
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
