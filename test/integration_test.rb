require './test/test_helper'
require './lib/game'

class IntegrationTest < MiniTest::Test
  def correct?(result)
    result =~ /^Congratulations!/
  end

  def wrong_guess
    guess = @correct_sequence
    options = ['R', 'G', 'B', 'Y']
    while guess == @correct_sequence
      guess = (0...4).collect { options.sample }
    end
    guess.join
  end

  def test_playing_a_game
    g = Game.new
    g.start

    @correct_sequence = g.sequence.secret_sequence 

    refute correct?(g.guess(wrong_guess))
    refute correct?(g.guess(wrong_guess))
    refute correct?(g.guess(wrong_guess))
    refute correct?(g.guess(wrong_guess))
    assert correct?(g.guess(@correct_sequence.join))
  end
end
