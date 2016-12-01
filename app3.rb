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

	player_1 = params[:player_1]

	 player_2 = params[:player_2]
    
    
    session[:game] = []
    

	# player_1 = params[:player_1]

	#  player_2 = params[:player_2]

	

    name = params[:name]
	p2name = params[:p2name] || p2name = "sweet muffins"
	
		player_1 = Human.new("X", name)
	 	


	 #name is refered with the human anytime it is used. 

		

	if player_2 == "human"

		player_2 = Human.new("O", p2name)

	elsif player_2 == "sequential_ai"

		player_2 = SequentialAI.new("O", p2name)	

	elsif player_2 == "random"
		
		player_2 = RandomAI.new("O", p2name)

	else player_2 == "unbeatable"

		player_2 = UnbeatableAI.new("O", p2name)	

	end


	
	current_player = player_1
    
    session[:game].push({'board' => Board.new, 'current_player' => current_player, 'player_1' => player_1, 'player_2' => player_2, 'name' => name, 'p2name' => p2name})

	erb :game, :locals => {:current_player => session[:game][0]['current_player'].marker,:name => session[:game][0]['name'], :p2name => session[:game][0]['p2name'],
                            :player_1 => session[:game][0]['player_1'], :player_2 => session[:game][0]['player_2'],
                           :board => session[:game][0]['board'].board_with_positions, 
                           :message =>""}

end

get '/get_move' do
    
	move = session[:game][0]['current_player'].get_move(session[:game][0]['board'].ttt_board)
		puts session[:game][0]['current_player']
		if move == "No"
			
			erb :game, :locals => {:current_player => session[:game][0]['current_player'].marker,:player_1 => session[:game][0]['player_1'], :player_2 =>session[:game][0]['player_2'], :p2name => session[:game][0]['p2name'],:name =>session[:game][0]['name'],:board => session[:game][0]['board'].board_with_positions, :message =>" "}
		else 
			session[:game][0]['board'].valid_spot?(move)
			redirect '/make_move?move=' + move.to_s
		
		end

	
end

post '/get_move' do

	move = params[:choice ].to_i
	
	if session[:game][0]['board'].valid_spot?(move)
		redirect '/make_move?move=' + move.to_s
	else
		redirect '/get_move'
	end

end

get "/make_move" do

		move = params[:move].to_i

		session[:game][0]['board'].update_board((move -1 ), session[:game][0]['current_player'].marker)

			if session[:game][0]['board'].game_won?(session[:game][0]['current_player'].marker) == true
				redirect "/win?current_player=session[:game][0]['current_player']"
			elsif 
				session[:game][0]['board'].board_full? == true
				redirect "/tie"
			else
				if session[:game][0]['current_player'].marker == "X"
					session[:game][0]['current_player'].marker = session[:game][0]['player_2']  
				else
					session[:game][0]['current_player'].marker = session[:game][0]['player_1']
				end
			end
		redirect '/get_move'

end

get "/win" do
    current_player = session[:game][0]['current_player'].marker

	erb :win, :locals => {:current_player => session[:game][0]['current_player'].name, :name => session[:game][0]['name'], :p2name => session[:game][0]['p2name']}

end



get "/tie" do

	erb :tie

end

