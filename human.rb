class Human

	attr_accessor :marker, :name

	def initialize(marker, name)
		@marker = marker
		@name = name
	end

	def get_move(board)
		"No"
	end

	# def get_move(board)
	# 	puts "Pick a space"
	# 	move = gets.chomp.to_i
	# 	if board[move] == " "
	# 		move
	# 	else
	# 		puts "invalid space"
	# 		get_move(board)
	# 	end
	# end
end