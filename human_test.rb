require "minitest/autorun"
require_relative "human.rb"

class TestHuman < Minitest::Test

	def test_for_new_player
		player = Human.new("X", "ed")
		assert_equal("X", player.marker)
		assert_equal("ed", player.name)
	end

	def test_get_move
		player = Human.new("X", "ed")
		move = player.get_move([" ", " ", " ", " ", " ", " ", " ", " ", " "])
		assert_equal("No", move)	
	end


end