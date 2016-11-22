class SequentialAI

	attr_accessor :marker, :name

	def initialize(marker, name)
		@marker = marker
		@name = name
	end

	def get_move(board)
		answer= (board.index(" ") +1)
	end

end