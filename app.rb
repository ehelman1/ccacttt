require 'sinatra'
require_relative "board.rb"
require_relative "sequentialAI.rb"
require_relative "unbeatable.rb"
require_relative "randomAI.rb"
require_relative "human.rb"


enable :sessions




get '/' do
    erb :index
end

post "/output" do

	session[:board] = Board.new

	player_1 = params[:player_1]

	player_2 = params[:player_2]

	

	session[:name] = params[:name]
	session[:p2name] = params[:p2name] || session[:p2name] = "sweet muffins"
	
		session[:p1] = Human.new("X", session[:name])
	 	


	 #name is refered with the human anytime it is used. 

		

	if player_2 == "human"

		session[:p2] = Human.new("O", session[:p2name])

	elsif player_2 == "sequential_ai"

		session[:p2] = SequentialAI.new("O")	

	elsif player_2 == "random"
		
		session[:p2] = RandomAI.new("O")

	else player_2 == "unbeatable"

		session[:p2] = UnbeatableAI.new("O")	

	end


	
	session[:current_player] = session[:p1]
    

	erb :game, :locals => {:current_player => session[:current_player].marker,:name =>session[:name], :p2name =>session[:p2name],
                           :player_1 => session[:p1], :player_2 => session[:p2],
                           :board => session[:board].board_with_positions, 
                           :message =>""}

end

get '/get_move' do
    
	move = session[:current_player].get_move(session[:board].ttt_board)
		
		if move == "No"
			
			erb :game, :locals => {:current_player => session[:current_player].marker,:name =>session[:name],
        	:player_1 => session[:p1], :player_2 => session[:p2], :p2name => session[:p2name],
        	:board => session[:board].board_with_positions, :message =>" "}
		else 
			session[:board].valid_spot?(move)
			redirect '/make_move?move=' + move.to_s
		
		end

	
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

	erb :win, :locals => {:current_player => session[:current_player].marker, :name =>session[:name], :p2name =>session[:p2name] }

end



get "/tie" do

	erb :tie

end












