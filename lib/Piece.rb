require './lib/Board.rb'
require './lib/Pawn.rb'

class Piece
    def piece?
        return self.kind_of?(Piece)
    end
end

class White < Piece
    def initialize
        @white_pieces = []
    end
end

class Black < Piece
    def initialize
        @black_pieces = []
    end
end

