require "minitest/autorun"
require_relative "unbeatable.rb"

class TestUnbeatable < Minitest::Test

	def test_for_creating_player
		player = Unbeatable.new("X")
		assert_equal("X", player.marker)
	end

	def test_choices_a_move
		player = Unbeatable.new("X")
		move = player.get_move([" "," "," "," "," "," "," "," "," "])
		assert_equal(true, [0, 1, 2, 3, 4, 5, 6, 7, 8].include?(move))
	end

	def test_takes_winning_spaces
		player = Unbeatable.new("X")
		move = player.get_move([" "," "," ","X","X"," ","O"," ","O"])
		assert_equal(5, move)
	end	
	
end