require_relative "console_game.rb"

p1 = SequentialAI.new("X")
p2 = SequentialAI.new("O")
game = ConsoleGame.new(p1, p2)

game.start_game()
game.board_status()
until game.game_over?
	move = game.get_player_move
	game.make_move(move)
	game.change_player
	game.board_status
end