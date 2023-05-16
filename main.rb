require './lib/Board'

# Game rules TO-DO:
# -Fix castle move to exclude castle move if the opposite player is checking the squares
#  king is trying to move through
# -en passant for pawns
# -let player choose pawn promotion instead of always giving them a queen.

# --Manual Game
puts '[1]New Game  [2]Load Game'

input = gets.chomp!

case input.to_i
when 1
  gameboard = Board.new
  gameboard.setup_pieces
  gameboard.print_board
  gameboard.play
when 2
  new_board = Marshal.load(File.open('save/save_1.txt', 'r'))
  new_board.play
end
