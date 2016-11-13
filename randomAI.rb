class RandomAI

	attr_accessor :marker

	def initialize(marker)
		@marker = marker
	end
	
	# def get_move(board)
	# 	board.index(" ")
	# end

	# def get_move( marker)

	# 	move = []
	# 	i = 0
	# 	board.each do  |board_spot|

	# 		if board_spot == " "
	# 			move.push(i+1)
	# 		end
	# 		i = i + 1
	# 	end
	# 	move.sample
	# end

	# def random_space(board)
	# 	board.sample(" ")
	# end

	# def array
	# 	#create an array of
	# 	array = [0, 1, 2, 3, 4, 5, 6, 7, 8]
	# end

	def initialize(marker)
		
		@marker = marker
	end

	def valid_space(board, choice)
		board[choice] != "X" || board[choice] != "O"
	end
		



	def get_move(board)
		#create a new array with index # with empty stings and randomly select them
		# board.each_index{|i| board[i]==" "}.sample
		# move = []
		# i = 0
		# board.each do  |board_spot|

		# 	if board_spot == "(i + 1)"
		# 		move.push(i)
		# 	end
		# 	i = i + 1
		# end

		n = rand(1..9)

		if valid_space(board, n) == false
			get_move(board)
		else
			n
		end
		
			
		
		# move.sample


	end
end	

