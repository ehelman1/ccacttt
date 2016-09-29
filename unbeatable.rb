class Unbeatable

	attr_reader :marker

	def initialize(marker)
		@marker = marker
	end

	def get_move(board)
		 
		result = board.index(" ")
		winning_combo = [[board[0],board[1],board[2]],
                        [board[3],board[4],board[5]],
                         [board[6],board[7],board[8]],
                         [board[0],board[3],board[6]],
                         [board[1],board[4],board[7]],
                         [board[2],board[5],board[8]],
                         [board[0],board[4],board[8]],
                         [board[2],board[4],board[6]]]

        winning_combo.each do |winner|
        	if winner.count(marker) == 2
        		result = 5
      	 	end
        end
        result
	end
end	
