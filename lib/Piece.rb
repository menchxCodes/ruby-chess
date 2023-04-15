require './lib/Board.rb'
require './lib/Pawn.rb'
require './lib/Rook.rb'
require './lib/Bishop.rb'

class Piece
    def piece?
        return self.kind_of?(Piece)
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

