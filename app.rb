require 'sinatra'
require_relative "board.rb"
require_relative "sequentialAI.rb"
require_relative "unbeatable.rb"
require_relative "randomAI.rb"
require_relative "human.rb"
#require_relative "aws/s3"

enable :sessions




get '/' do
    erb :index
end

post "/output" do

	session[:board] = Board.new

	player_1 = params[:player_1]

	player_2 = params[:player_2]


		session[:p1] = Human.new("X")
	# if player_1 == "human"

	# 	session[:p1] = Human.new("X")	

	# elsif player_1 == "sequential_ai"

	# 	session[:p1] = SequentialAI.new("X")	

	# else player_1 == "random_ai"

	# 	session[:p1] = RandomAI.new("X")	

	# end

		# session[:p2] = Human.new("O")

	if player_2 == "human"

		session[:p2] = Human.new("O")

	elsif player_2 == "sequential_ai"

		session[:p2] = SequentialAI.new("O")	

	else player_2 == "random_ai"

		session[:p2] = RandomAI.new("O")	

	end



	session[:current_player] = session[:p1]
    

	erb :game, :locals => {:current_player => session[:current_player].marker,
                           :player_1 => session[:p1], :player_2 => session[:p2],
                           :board => session[:board].board_with_positions, 
                           :message =>" "}

end

get '/get_move' do
    
	move = session[:current_player].get_move(session[:board].ttt_board)
		
		if move == "No"
			
			erb :game, :locals => {:current_player => session[:current_player].marker,
        	:player_1 => session[:p1], :player_2 => session[:p2],
        	:board => session[:board].board_with_positions, :message =>" "}
		else 
			session[:board].valid_spot?(move)
			redirect '/make_move?move=' + move.to_s
		# else
		# 	redirect '/get_move'
		end

	#erb :game, :locals => {:current_player => session[:current_player].marker, :player_1 => session[:p1], :player_2 => session[:p2], :board => session[:board].board_with_positions, :message =>" "}
end

post '/get_move' do

	move = params[:choice ].to_i
	
	if session[:board].valid_spot?(move)
		redirect '/make_move?move=' + move.to_s
	else
		redirect '/get_move'
	end

end

get "/make_move" do

		move = params[:move].to_i

		session[:board].update_board((move -1 ), session[:current_player].marker)

			if session[:board].game_won?(session[:current_player].marker) == true
				redirect "/win?current_player=session[:current_player]"
			elsif 
				session[:board].board_full? == true
				redirect "/tie"
			else
				if session[:current_player].marker == "X"
					session[:current_player] = session[:p2]
				else
					session[:current_player] = session[:p1]
				end
			end
		redirect '/get_move'

end

get "/win" do
    current_player = session[:current_player].marker

	erb :win, :locals => {:current_player => session[:current_player].marker}

end



get "/tie" do

	erb :tie

end












