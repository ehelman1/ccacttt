require 'sinatra'
require_relative "new_tic_tac.rb"
require_relative "sequentialAI.rb"
require_relative "unbeatable.rb"
require_relative "randomAI.rb"
require_relative "console_game.rb"
require_relative "human.rb"

enable :sessions
board = Board.new
#players = Current_player.new


get '/' do
    erb :index
end

get '/game' do
    session[:board] = Board.new
    erb :game, :locals => {:board => session[:board].ttt_board, :message =>"player one pick a space."}
    session[:choice] = params[:choice].to_i
    choice = params[:choice].to_i
    #player_marker = session[:players].current_player()

        if session[:board].square_available?[choice - 1] == true
            session[:board].board[choice - 1] = player_marker 
end






#post '/board' do
#	session[:board] 
#end